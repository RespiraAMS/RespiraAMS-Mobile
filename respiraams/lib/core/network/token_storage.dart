import 'package:shared_preferences/shared_preferences.dart';

/// Persisted auth tokens + account identity (guidelines §2.5: key-value
/// storage behind this small interface).
class TokenStorage {
  TokenStorage(this._prefs);

  static const _kAccess = 'auth.accessToken';
  static const _kRefresh = 'auth.refreshToken';
  static const _kDoctorId = 'auth.doctorId';
  static const _kDoctorName = 'auth.doctorName';
  static const _kEmail = 'auth.email';
  static const _kRole = 'auth.role';

  final SharedPreferences _prefs;

  String? get accessToken => _prefs.getString(_kAccess);
  String? get refreshToken => _prefs.getString(_kRefresh);

  /// Account id (`sub`/`nameid`), not the doctor-profile id.
  String? get doctorId => _prefs.getString(_kDoctorId);
  String? get doctorName => _prefs.getString(_kDoctorName);
  String? get email => _prefs.getString(_kEmail);
  String? get role => _prefs.getString(_kRole);

  bool get hasSession => accessToken != null && refreshToken != null;

  Future<void> save({
    required String accessToken,
    required String refreshToken,
  }) async {
    await _prefs.setString(_kAccess, accessToken);
    await _prefs.setString(_kRefresh, refreshToken);
  }

  Future<void> saveDoctor({required String id, required String name}) async {
    await _prefs.setString(_kDoctorId, id);
    await _prefs.setString(_kDoctorName, name);
  }

  /// Stores the decoded token identity alongside the token pair.
  Future<void> saveIdentity({
    String? accountId,
    String? email,
    String? role,
    String? displayName,
  }) async {
    if (accountId != null && accountId.isNotEmpty) {
      await _prefs.setString(_kDoctorId, accountId);
    }
    if (email != null && email.isNotEmpty) {
      await _prefs.setString(_kEmail, email);
    }
    if (role != null && role.isNotEmpty) {
      await _prefs.setString(_kRole, role);
    }
    if (displayName != null && displayName.isNotEmpty) {
      await _prefs.setString(_kDoctorName, displayName);
    }
  }

  Future<void> clear() async {
    await _prefs.remove(_kAccess);
    await _prefs.remove(_kRefresh);
    await _prefs.remove(_kDoctorId);
    await _prefs.remove(_kDoctorName);
    await _prefs.remove(_kEmail);
    await _prefs.remove(_kRole);
  }
}
