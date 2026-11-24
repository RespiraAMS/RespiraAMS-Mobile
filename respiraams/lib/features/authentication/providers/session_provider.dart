import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/api_client.dart';
import '../../../core/network/api_response.dart';
import '../../../core/network/token_storage.dart';
import '../services/auth_service.dart';
import '../services/doctor_service.dart';

part 'session_provider.g.dart';

/// Logged-in doctor identity shown on headers.
class DoctorProfile {
  const DoctorProfile({required this.id, required this.name, this.avatarUrl});

  /// Account id (`sub` / `nameid`), used as the session key.
  final String id;
  final String name;
  final String? avatarUrl;
}

/// Roles the mobile client supports. Both have a doctor profile and are
/// accepted by the patient/clinical service role matrix; Admin and
/// MedicalRegulationReviewer are rejected.
const _allowedRoles = {'doctor', 'headdepartmentdoctor'};

bool _isAllowedRole(String? role) {
  final normalized = role?.trim().toLowerCase();
  if (normalized == null || normalized.isEmpty) return false;
  return _allowedRoles.contains(normalized);
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
    if (!storage.hasSession || id == null) return null;

    // The mobile client is doctor-facing only: a session restored from an
    // unsupported account (e.g. saved before this restriction) is discarded.
    final role = storage.role?.trim().toLowerCase();
    if (role != null && role.isNotEmpty && !_isAllowedRole(role)) return null;

    final name = storage.doctorName ?? storage.email ?? id;
    return DoctorProfile(id: id, name: name);
  }

  /// `POST /auth/login`, then resolves the linked doctor profile so the
  /// header shows a real name instead of the email.
  Future<DoctorProfile> login({
    required String email,
    required String password,
  }) async {
    final storage = TokenStorage(ref.read(sharedPreferencesProvider));
    final session = await ref
        .read(authServiceProvider)
        .login(email: email, password: password);

    // Only Doctor and HeadDepartmentDoctor may enter the workspace; the other
    // roles are blocked by the service-level role matrix, so reject them here
    // instead of letting every screen fail with 403.
    if (!_isAllowedRole(session.role)) {
      await ref.read(authServiceProvider).logout();
      throw const ApiException(403, LocalApiError.roleNotAllowed);
    }

    var name = session.email;
    String? avatarUrl;
    try {
      final doctor = await ref.read(doctorServiceProvider).getMe();
      if (doctor != null) {
        if (doctor.fullName.trim().isNotEmpty) name = doctor.fullName;
        avatarUrl = doctor.avatarUrl;
      }
    } catch (_) {
      // Doctor profile unavailable — the email still identifies the user.
    }

    await storage.saveIdentity(displayName: name);

    final profile = DoctorProfile(
      id: session.accountId,
      name: name,
      avatarUrl: avatarUrl,
    );
    state = profile;
    return profile;
  }

  /// Refreshes the cached identity after the doctor edits their profile, so
  /// the settings header picks up the new name/avatar without re-login.
  Future<void> updateIdentity({String? displayName, String? avatarUrl}) async {
    final current = state;
    if (current == null) return;

    final name = displayName?.trim();
    final storage = TokenStorage(ref.read(sharedPreferencesProvider));
    if (name != null && name.isNotEmpty) {
      await storage.saveIdentity(displayName: name);
    }

    state = DoctorProfile(
      id: current.id,
      name: name != null && name.isNotEmpty ? name : current.name,
      avatarUrl: avatarUrl ?? current.avatarUrl,
    );
  }

  /// Revokes the server session (best-effort) and clears local tokens.
  Future<void> logout() async {
    await ref.read(authServiceProvider).logout();
    state = null;
  }
}

/// Exposed for services that only need token storage.
@riverpod
TokenStorage tokenStorage(TokenStorageRef ref) =>
    TokenStorage(ref.watch(sharedPreferencesProvider));

/// Convenience accessor so widgets/services can locate the doctor profile
/// without null-checking the session.
@riverpod
DoctorProfile? sessionDoctor(SessionDoctorRef ref) =>
    ref.watch(sessionControllerProvider);
