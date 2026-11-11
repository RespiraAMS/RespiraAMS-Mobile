import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../services/doctor_service.dart';
import 'session_provider.dart';

part 'current_doctor_provider.g.dart';

/// Profile of the signed-in doctor, resolved through the account-id bridge.
///
/// The JWT only carries the *account* id, while `GET /doctors/{id}` takes the
/// *profile* id, so the roster is walked once and kept alive for the session.
@Riverpod(keepAlive: true)
Future<DoctorProfileDto?> currentDoctor(CurrentDoctorRef ref) {
  final session = ref.watch(sessionDoctorProvider);
  if (session == null) return Future.value(null);
  return ref.read(doctorServiceProvider).findByAccountId(session.id);
}
