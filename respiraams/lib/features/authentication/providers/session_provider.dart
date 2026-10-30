import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/api_client.dart';
import '../../../core/network/token_storage.dart';
import '../services/auth_service.dart';

part 'session_provider.g.dart';

/// Logged-in doctor identity shown on headers.
class DoctorProfile {
  const DoctorProfile({
    required this.id,
    required this.name,
    this.avatarUrl,
  });

  final String id;
  final String name;
  final String? avatarUrl;
}

/// Holds the active session (null = logged out). The login screen drives
/// [login]; the app header's logout button drives [logout].
@Riverpod(keepAlive: true)
class SessionController extends _$SessionController {
  @override
  DoctorProfile? build() => _restore();

  DoctorProfile? _restore() {
    final storage = TokenStorage(ref.read(sharedPreferencesProvider));
    final id = storage.doctorId;
    final name = storage.doctorName;
    if (!storage.hasSession || id == null) return null;
    return DoctorProfile(id: id, name: name ?? id);
  }

  /// Persists a local session (any non-empty email/password succeeds) and
  /// resolves the doctor profile from [TokenStorage].
  Future<DoctorProfile> login({
    required String email,
    required String password,
  }) async {
    final storage = TokenStorage(ref.read(sharedPreferencesProvider));
    final fallbackName = await AuthService(
      storage,
    ).login(email: email, password: password);

    final doctorId = storage.doctorId ?? '';
    final profile = DoctorProfile(
      id: doctorId,
      name: storage.doctorName ?? fallbackName,
    );
    state = profile;
    return profile;
  }

  /// Ends the local session.
  Future<void> logout() async {
    final storage = TokenStorage(ref.read(sharedPreferencesProvider));
    await AuthService(storage).logout();
    state = null;
  }
}

/// Exposed for services that only need token storage.
@riverpod
TokenStorage tokenStorage(Ref ref) =>
    TokenStorage(ref.watch(sharedPreferencesProvider));

/// Convenience accessor so widgets/services can locate the doctor profile
/// without null-checking the session.
@riverpod
DoctorProfile? sessionDoctor(SessionDoctorRef ref) =>
    ref.watch(sessionControllerProvider);
