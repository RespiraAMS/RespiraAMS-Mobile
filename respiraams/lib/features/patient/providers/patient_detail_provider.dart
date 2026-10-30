import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/api_client.dart';
import '../models/patient_dtos.dart';
import '../services/patient_service.dart';

part 'patient_detail_provider.g.dart';

/// Real patient profile from `GET /patients/{id}`.
@riverpod
Future<PatientDetailDto> patientDetail(PatientDetailRef ref, String id) {
  return PatientService(ref.watch(apiClientProvider)).getPatient(id);
}
