import 'package:dio/dio.dart';

/// Domain-specific failure surfaced from failed `Result` envelopes;
/// controllers map it into error states (guidelines Rule 3/5).
class ApiException implements Exception {
  const ApiException(this.statusCode, this.message);

  final int statusCode;
  final String message;

  @override
  String toString() => 'ApiException($statusCode): $message';
}

/// True for statuses where a token refresh + retry can recover the call.
bool isAuthRetryable(int statusCode) =>
    statusCode == 401 || statusCode == 403;

/// The backend answers with `Result` / `Result<T>`
/// (`Respira.ServiceDefaults.Contracts.Results`), serialized as:
///
/// ```json
/// { "statusCode": "SUCCESS",      "error": null,  "data": <T> }
/// { "statusCode": "FAILURE-...",  "error": { "description": "…" }, "data": null }
/// ```
///
/// `error` is non-null only on failure (Result invariant).
bool _isFailure(Map<String, dynamic> json) {
  if (json['error'] != null) return true;
  final code = json['statusCode'];
  return code is String && code.contains('FAILURE');
}

Never _throwFailure(Map<String, dynamic> json, Response<dynamic> res) {
  final error = json['error'];
  final description = error is Map
      ? error['description'] as String?
      : null;
  throw ApiException(
    res.statusCode ?? 500,
    description ?? (json['message'] as String?) ?? 'Request failed',
  );
}

/// Extracts the envelope's `data` as a typed value, throwing [ApiException]
/// on failure envelopes.
T unwrapData<T>(
  Response<dynamic> res,
  T Function(Map<String, dynamic> json) fromJson,
) {
  final json = res.data as Map<String, dynamic>;
  if (_isFailure(json)) _throwFailure(json, res);
  final data = json['data'];
  if (data == null) {
    throw ApiException(res.statusCode ?? 500, 'Empty response data');
  }
  return fromJson(data as Map<String, dynamic>);
}

/// Extracts the whole envelope's `data` field (for non-single-object
/// payloads such as lists or paginated results).
Map<String, dynamic> unwrapEnvelope(Response<dynamic> res) {
  final json = res.data as Map<String, dynamic>;
  if (_isFailure(json)) _throwFailure(json, res);
  return json['data'] as Map<String, dynamic>? ?? {};
}

/// Best-effort human message for a failed Dio call. Dio throws on non-2xx
/// before [unwrapData]/[unwrapEnvelope] run, so this inspects the error
/// response body. The backend answers failures in two shapes:
///
/// 1. The `Result` envelope — `{ statusCode, error: { description } }`
///    (handlers/`GlobalExceptionHandler`).
/// 2. ASP.NET `ValidationProblemDetails` — `application/problem+json`
///    `{ title, status, errors: { field: [messages] } }`, emitted by
///    `[ApiController]` model binding *before* the handler runs.
///
/// Only a missing response (connection/timeout) is reported as a
/// connectivity problem; everything else surfaces the server's own text.
String dioErrorMessage(DioException error) {
  final response = error.response;
  if (response == null) {
    return 'Không thể kết nối máy chủ. Vui lòng kiểm tra kết nối mạng.';
  }

  final data = response.data;
  if (data is Map) {
    // 1. Result envelope.
    final err = data['error'];
    if (err is Map && err['description'] is String) {
      return err['description'] as String;
    }

    // 2. ValidationProblemDetails — prefer a field-specific message over
    // the generic `req` ("The req field is required.") one.
    final errors = data['errors'];
    if (errors is Map) {
      String? generic;
      for (final entry in errors.entries) {
        final value = entry.value;
        final message = value is List && value.isNotEmpty && value.first is String
            ? value.first as String
            : value is String
                ? value
                : null;
        if (message == null || message.isEmpty) continue;
        if (entry.key == 'req') {
          generic ??= message;
          continue;
        }
        return message;
      }
      if (generic != null) return generic;
    }

    // ProblemDetails / StatusCodePages fallbacks.
    for (final key in const ['description', 'message', 'detail', 'title']) {
      final value = data[key];
      if (value is String && value.isNotEmpty) return value;
    }
  }

  return 'Yêu cầu không hợp lệ (mã ${response.statusCode}).';
}
