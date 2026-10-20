import 'package:dio/dio.dart';

import '../../../core/network/api_response.dart';
import '../models/clinical_dtos.dart';

/// Clinical endpoints of Respira.Clinical (`/api/1/...`): the empirical
/// diagnosis form and the diagnose call.
class ClinicalService {
  ClinicalService(this._dio);

  final Dio _dio;

  /// `GET /diagnose/empirical` — the dynamic form's variable catalog.
  Future<List<ClinicalVariableDto>> getDiagnosisForm() async {
    final res = await _dio.get('/api/1/diagnose/empirical');
    final form = unwrapData(res, (json) => DiagnosisFormDto.fromJson(json));
    return form.variables;
  }

  /// `POST /diagnose/empirical` — severity, treatment site, suspected
  /// pathogens, evidences, missing variables and allergies.
  Future<DiagnoseResultDto> diagnoseEmpirical({
    required List<ObservationDto> observations,
    required List<String> allergies,
  }) async {
    final res = await _dio.post(
      '/api/1/diagnose/empirical',
      data: {
        'observations': observations.map((o) => o.toJson()).toList(),
        'allergies': allergies,
      },
    );
    return unwrapData(res, (json) => DiagnoseResultDto.fromJson(json));
  }
}
