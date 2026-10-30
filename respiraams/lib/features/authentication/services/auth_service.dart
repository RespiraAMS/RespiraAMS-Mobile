import '../../../core/network/token_storage.dart';

/// Local (offline) auth. The backend gateway exposes no auth service and
/// does not enforce authorization, so login succeeds for any non-empty
/// email/password — a synthetic session is persisted via [TokenStorage].
class AuthService {
  AuthService(this._storage);

  final TokenStorage _storage;

  /// Persists a local session and returns the entered identifier (email).
  Future<String> login({
    required String email,
    required String password,
  }) async {
    await _storage.save(
      accessToken: 'local-access-$email',
      refreshToken: 'local-refresh-$email',
    );
    await _storage.saveDoctor(id: email, name: email);
    return email;
  }

  /// Ends the local session (no server-side revoke).
  Future<void> logout() async {
    await _storage.clear();
  }
}
