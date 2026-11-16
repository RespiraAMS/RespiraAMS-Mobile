import 'package:dio/dio.dart';

import '../../../core/network/api_response.dart';
import '../models/clinical_dtos.dart';

/// Clinical endpoints of Respira.Clinical (`/diagnose`).
///
/// Paths are relative to [kApiRootUrl] (`/api/v1`).
class ClinicalService {
  ClinicalService(this._dio);

  final Dio _dio;

  /// `GET /diagnose` — the dynamic form catalog (clinical variables,
  /// antibiotics and pathogens).
  Future<DiagnosisFormDto> getDiagnosisForm() async {
    final res = await _dio.get('/diagnose');
    return unwrapData(res, DiagnosisFormDto.fromJson);
  }

  /// `POST /diagnose` — severity, treatment site, suspected pathogens,
  /// evidences, missing variables, allergy and recommended protocols.
  ///
  /// The raw response body is kept on [DiagnoseResultDto.rawJson] because
  /// `POST /diagnose/confirm-treatment` expects the exact snapshot echoed
  /// back (the backend binds it as `JsonElement`).
  Future<DiagnoseResultDto> diagnose({
    required List<ObservationDto> observations,
    required AllergyInputDto allergy,
    List<String> specialMedicalHistory = const [],
    List<String> otherInfections = const [],
    List<MicrobialSampleInputDto> microbialSamples = const [],
  }) async {
    final res = await _dio.post(
      '/diagnose',
      data: {
        'observations': observations.map((o) => o.toJson()).toList(),
        'allergy': allergy.toJson(),
        'specialMedicalHistory': specialMedicalHistory,
        'otherInfections': otherInfections,
        'microbialSamples': microbialSamples.map((s) => s.toJson()).toList(),
      },
    );

    final result = unwrapData(res, DiagnoseResultDto.fromJson);
    final envelope = res.data as Map<String, dynamic>;
    final raw = envelope['data'];
    if (raw is! Map<String, dynamic>) return result;
    return result.copyWith(rawJson: raw);
  }

  /// `POST /diagnose/warn-antibiotic-combination` — whether the selected
  /// antibiotics require a duplicate/compatibility warning.
  Future<bool> warnAntibioticCombination(List<String> antibioticIds) async {
    final res = await _dio.post(
      '/diagnose/warn-antibiotic-combination',
      data: {'antibioticIds': antibioticIds},
    );
    return unwrapScalar(
      res,
      (data) => data is Map<String, dynamic> && data['needWarning'] is bool
          ? data['needWarning'] as bool
          : false,
    );
  }

  /// `POST /diagnose/confirm-treatment` — persists the doctor-confirmed
  /// diagnosis as a treatment plan.
  ///
  /// [diagnosis] must be the raw JSON captured from [diagnose]
  /// ([DiagnoseResultDto.rawJson]); the backend forwards it untouched.
  /// [medicineIds] are the antibiotic IDs chosen by the doctor.
  Future<void> confirmTreatment({
    required String patientId,
    required Map<String, dynamic> diagnosis,
    required List<String> medicineIds,
    String? reasonForMedicineChoice,
  }) async {
    final res = await _dio.post(
      '/diagnose/confirm-treatment',
      data: {
        'patientId': patientId,
        'diagnosis': diagnosis,
        'medicines': medicineIds,
        'reasonForMedicineChoice': reasonForMedicineChoice,
      },
    );
    unwrapResult(res);
  }
}
