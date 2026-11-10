import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_client.dart';
import '../../../core/network/api_response.dart';
import '../../../core/network/token_storage.dart';
import '../../../core/utils/jwt.dart';

/// Identity resolved from a successful `POST /auth/login`.
class AuthSession {
  const AuthSession({required this.accountId, required this.email, this.role});

  /// Account id carried by the JWT (`sub` / `nameid`).
  final String accountId;
  final String email;
  final String? role;
}

/// Authentication endpoints of Respira.Authentication (`/auth/*`).
///
/// Uses the shared Dio (its base URL already carries `/api/v1`). The auth
/// interceptor deliberately skips bearer injection for `/auth/` routes.
class AuthService {
  AuthService(this._dio, this._storage);

  final Dio _dio;
  final TokenStorage _storage;

  /// `POST /auth/login` — returns the token pair, then persists the decoded
  /// account identity.
  Future<AuthSession> login({
    required String email,
    required String password,
  }) async {
    final res = await _dio.post(
      '/auth/login',
      data: {'email': email, 'password': password},
    );

    final tokens = unwrapData(res, _TokenPair.fromJson);
    await _storage.save(
      accessToken: tokens.accessToken,
      refreshToken: tokens.refreshToken,
    );

    final claims = decodeJwt(tokens.accessToken);
    final accountId = claims?.accountId ?? '';
    final resolvedEmail = claims?.email ?? email;
    await _storage.saveIdentity(
      accountId: accountId,
      email: resolvedEmail,
      role: claims?.role,
    );

    return AuthSession(
      accountId: accountId,
      email: resolvedEmail,
      role: claims?.role,
    );
  }

  /// `POST /auth/logout` — revokes the refresh token server-side, then
  /// clears the local session (best-effort: a network failure must never
  /// keep the user signed in locally).
  Future<void> logout() async {
    final access = _storage.accessToken;
    final refresh = _storage.refreshToken;
    if (refresh != null && refresh.isNotEmpty) {
      try {
        await _dio.post(
          '/auth/logout',
          data: {'accessToken': access ?? '', 'refreshToken': refresh},
        );
      } on DioException {
        // Offline / already-revoked token: fall through and clear locally.
      }
    }
    await _storage.clear();
  }

  /// `POST /auth/email-verification` — sends a verification link to an
  /// active, unverified account.
  Future<bool> sendEmailVerification(String email) async {
    final res = await _dio.post(
      '/auth/email-verification',
      data: {'email': email},
    );
    return unwrapScalar(res, (data) => data is bool ? data : false);
  }

  /// `POST /auth/email-verification/confirm` — confirms the address using
  /// the raw token carried by the emailed link.
  Future<bool> verifyEmail(String token) async {
    final res = await _dio.post(
      '/auth/email-verification/confirm',
      data: {'token': token},
    );
    return unwrapScalar(res, (data) => data is bool ? data : false);
  }
}

class _TokenPair {
  const _TokenPair({required this.accessToken, required this.refreshToken});

  factory _TokenPair.fromJson(Map<String, dynamic> json) => _TokenPair(
    accessToken: json['accessToken'] as String? ?? '',
    refreshToken: json['refreshToken'] as String? ?? '',
  );

  final String accessToken;
  final String refreshToken;
}

final authServiceProvider = Provider<AuthService>(
  (ref) => AuthService(
    ref.watch(apiClientProvider),
    TokenStorage(ref.watch(sharedPreferencesProvider)),
  ),
);
