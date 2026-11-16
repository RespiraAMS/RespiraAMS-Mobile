import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'token_storage.dart';

/// Compile-time override, e.g. `--dart-define=API_BASE_URL=https://...`.
/// `String.fromEnvironment` yields the default when the define is not
/// passed, so an explicitly-passed value always differs from it.
const String _kDefineBaseUrl = String.fromEnvironment(
  'API_BASE_URL',
  defaultValue: '',
);

const String _kDefaultBaseUrl = 'https://localhost:7283';

/// Base URL of the RespiraAMS gateway (YARP).
///
/// Precedence: `--dart-define` → `API_BASE_URL` in `.env` → the
/// gateway's HTTPS default (its HTTP port only 307-redirects back here,
/// and the Aspire dev certificate `CN=localhost` is trusted on developer
/// machines). Debug builds additionally accept self-signed certs so
/// emulators (`10.0.2.2`) and LAN devices work.
String get kApiBaseUrl {
  if (_kDefineBaseUrl.isNotEmpty) return _kDefineBaseUrl;
  try {
    final fromEnv = dotenv.env['API_BASE_URL'];
    if (fromEnv != null && fromEnv.trim().isNotEmpty) return fromEnv.trim();
  } catch (_) {
    // dotenv not loaded (e.g. widget tests) — fall through to default.
  }
  return _kDefaultBaseUrl;
}

/// API version segment of the gateway routes (`/api/v{version}`).
///
/// The backend versioning middleware (`UrlSegmentApiVersionReader`) reads
/// this segment, so it must stay in sync with `[ApiVersion("1.0")]` on the
/// controllers — i.e. `v1`.
const String kApiVersion = 'v1';

/// Versioned API prefix, e.g. `/api/v1`.
///
/// Every HTTP client in the app is built from [kApiBaseUrl] + this prefix,
/// so bumping [kApiVersion] updates all services at once.
const String kApiBasePath = '/api/$kApiVersion';

/// Absolute root of the versioned API, e.g. `https://localhost:7283/api/v1`.
String get kApiRootUrl => '$kApiBaseUrl$kApiBasePath';

/// Base options shared by every Dio instance in the app.
BaseOptions gatewayBaseOptions({String? baseUrl}) => BaseOptions(
      baseUrl: baseUrl ?? kApiBaseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 20),
      headers: {'Accept': 'application/json'},
    );

/// Trusts the .NET dev certificate in debug builds only (Aspire's
/// `CN=localhost` cert fails hostname validation for `10.0.2.2` / LAN
/// IPs). Release builds keep strict TLS validation.
void attachDebugTrust(Dio dio) {
  if (!kDebugMode) return;
  dio.httpClientAdapter = IOHttpClientAdapter(
    createHttpClient: () => HttpClient()
      ..badCertificateCallback = (cert, host, port) => true,
  );
}

/// Raw Dio instance shared by every service. Handles:
/// 1. Bearer header injection from [TokenStorage]
/// 2. Single-flight 401/403 recovery: POST /auth/refresh then retry once
///
/// Its base URL already includes [kApiBasePath], so feature services use
/// paths relative to `/api/v1` (e.g. `/patients`, `/diagnose`).
final Provider<Dio> apiClientProvider = Provider<Dio>((ref) {
  final storage = TokenStorage(ref.watch(sharedPreferencesProvider));
  final dio = Dio(gatewayBaseOptions(baseUrl: kApiRootUrl));
  attachDebugTrust(dio);

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        final token = storage.accessToken;
        // Login/refresh/verify-email must go out unauthenticated.
        final isAuthRoute = options.path.contains('/auth/');
        if (token != null && !isAuthRoute) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        handler.next(options);
      },
      onError: (error, handler) async {
        final status = error.response?.statusCode;
        final isAuthRoute = error.requestOptions.path.contains('/auth/');

        if ((status == 401 || status == 403) &&
            !isAuthRoute &&
            storage.refreshToken != null) {
          final retried = await refreshAndRetry(dio, storage, error);
          return handler.resolve(retried);
        }
        handler.next(error);
      },
    ),
  );

  return dio;
});

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('Override in ProviderScope/bootstrap');
});

/// Single refresh call shared by every client; parallel 401s trigger
/// only one `POST /auth/refresh`.
Future<Response<dynamic>>? _refreshing;

/// Recovers from a 401/403 by refreshing the token pair and retrying the
/// original request once. Throws the original [DioException] when the
/// retried request fails again (after clearing the session).
Future<Response<dynamic>> refreshAndRetry(
  Dio dio,
  TokenStorage storage,
  DioException error,
) async {
  final requestOptions = error.requestOptions;

  // A retried request failing again must not loop.
  if (requestOptions.extra['__retried'] == true) {
    await storage.clear();
    throw error;
  }

  try {
    _refreshing ??= _performRefresh(dio, storage);
    final refreshResponse = await _refreshing!;
    final data = refreshResponse.data as Map<String, dynamic>;
    final tokens = data['data'] as Map<String, dynamic>;
    final access = tokens['accessToken'] as String;
    final refresh = tokens['refreshToken'] as String;
    await storage.save(accessToken: access, refreshToken: refresh);
    requestOptions.headers['Authorization'] = 'Bearer $access';
    requestOptions.extra['__retried'] = true;
    return dio.fetch(requestOptions);
  } on DioException {
    await storage.clear();
    rethrow;
  } finally {
    _refreshing = null;
  }
}

Future<Response<dynamic>> _performRefresh(Dio dio, TokenStorage storage) {
  final refreshDio = Dio(gatewayBaseOptions());
  attachDebugTrust(refreshDio);
  return refreshDio.post(
    '/api/$kApiVersion/auth/refresh',
    data: {'refreshToken': storage.refreshToken},
  );
}

/// Builds a Dio pre-configured for an unauthenticated call (login).
Dio unauthenticatedDio() {
  final dio = Dio(gatewayBaseOptions());
  attachDebugTrust(dio);
  return dio;
}

/// Compatibility client for lookup-feature repositories
/// (`AntibioticRepository`, `PathogenRepository`, …).
///
/// Builds a [Dio] whose base URL is [kApiRootUrl] so their relative paths
/// (`/antibiotics`, `/pathogens`, …) resolve against the versioned gateway
/// API. Prefer [apiClientServiceProvider] over constructing this directly,
/// so every repository shares one authenticated client.
class ApiClient {
  final Dio dio;

  ApiClient({Dio? dioOverride}) : dio = _buildDio(dioOverride);

  static Dio _buildDio(Dio? dioOverride) {
    if (dioOverride != null) return dioOverride;
    final dio = Dio(gatewayBaseOptions(baseUrl: kApiRootUrl));
    attachDebugTrust(dio);
    dio.interceptors.add(_authInterceptor(dio));
    return dio;
  }

  /// Bearer injection + refresh recovery for instances that load their
  /// own [TokenStorage] (constructed without a Riverpod scope).
  static InterceptorsWrapper _authInterceptor(Dio dio) {
    Future<TokenStorage> loadStorage() async =>
        TokenStorage(await SharedPreferences.getInstance());

    return InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = (await loadStorage()).accessToken;
        // Login/refresh/verify-email must go out unauthenticated.
        final isAuthRoute = options.path.contains('/auth/');
        if (token != null && token.isNotEmpty && !isAuthRoute) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        handler.next(options);
      },
      onError: (error, handler) async {
        final status = error.response?.statusCode;
        final isAuthRoute = error.requestOptions.path.contains('/auth/');
        if ((status == 401 || status == 403) && !isAuthRoute) {
          final storage = await loadStorage();
          if (storage.refreshToken != null) {
            try {
              final retried = await refreshAndRetry(dio, storage, error);
              return handler.resolve(retried);
            } on DioException {
              // Refresh failed — tokens were cleared; surface the
              // original error instead.
            }
          }
        }
        handler.next(error);
      },
    );
  }
}

/// Shared [ApiClient] for lookup-feature repositories.
///
/// It reuses [apiClientProvider]'s Dio (base URL `…/api/v1`, bearer
/// injection, refresh recovery), so the API version lives in exactly one
/// place and tests can override a single provider.
final Provider<ApiClient> apiClientServiceProvider = Provider<ApiClient>(
  (ref) => ApiClient(dioOverride: ref.watch(apiClientProvider)),
);
