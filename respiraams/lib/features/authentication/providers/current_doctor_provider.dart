import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../services/doctor_service.dart';
import 'session_provider.dart';

part 'current_doctor_provider.g.dart';

/// Profile of the signed-in doctor (`GET /doctors/me`), kept alive for the
/// session.
///
/// The JWT only carries the *account* id; the backend maps it to the doctor
/// profile, so no roster lookup is needed.
@Riverpod(keepAlive: true)
Future<DoctorProfileDto?> currentDoctor(CurrentDoctorRef ref) {
  final session = ref.watch(sessionDoctorProvider);
  if (session == null) return Future.value(null);
  return ref.read(doctorServiceProvider).getMe();
}
