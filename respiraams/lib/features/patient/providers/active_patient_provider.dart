import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/patient.dart';

part 'active_patient_provider.g.dart';

/// The patient currently being worked on across clinical screens
/// (detail · progress · diagnosis wizard · result).
///
/// Empty until a patient is selected from the roster (`GET /patients/{id}`)
/// or freshly created; `AddPatientController.save()` swaps it for the newly
/// created patient so the whole flow reflects real data.
@Riverpod(keepAlive: true)
class ActivePatientController extends _$ActivePatientController {
  @override
  Patient? build() => null;

  void set(Patient patient) => state = patient;

  void clear() => state = null;
}
