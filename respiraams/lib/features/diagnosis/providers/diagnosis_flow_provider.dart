import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/api_client.dart';
import '../../../core/network/api_response.dart';
import '../../patient/providers/current_patient_provider.dart';
import '../models/clinical_dtos.dart';
import '../services/clinical_service.dart';
import 'diagnosis_controller.dart';

part 'diagnosis_flow_provider.g.dart';

/// Dynamic form catalog from `GET /diagnose/empirical`.
@Riverpod(keepAlive: true)
Future<List<ClinicalVariableDto>> diagnosisForm(DiagnosisFormRef ref) {
  return ClinicalService(ref.watch(apiClientProvider)).getDiagnosisForm();
}

/// Immutable snapshot of the empirical diagnosis call.
class DiagnosisFlowState {
  const DiagnosisFlowState({
    this.diagnosing = false,
    this.result,
    this.errorMessage,
  });

  final bool diagnosing;
  final DiagnoseResultDto? result;
  final String? errorMessage;

  DiagnosisFlowState copyWith({
    bool? diagnosing,
    DiagnoseResultDto? result,
    String? errorMessage,
    bool clearError = false,
    bool clearResult = false,
  }) {
    return DiagnosisFlowState(
      diagnosing: diagnosing ?? this.diagnosing,
      result: clearResult ? null : (result ?? this.result),
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}

/// Orchestrates the API-backed empirical diagnosis flow.
@Riverpod(keepAlive: true)
class DiagnosisFlowController extends _$DiagnosisFlowController {
  ClinicalService get _clinical =>
      ClinicalService(ref.watch(apiClientProvider));

  @override
  DiagnosisFlowState build() => const DiagnosisFlowState();

  /// Calls `POST /diagnose/empirical` with the collected observations.
  Future<void> runEmpiricalDiagnosis() async {
    final patient = ref.read(currentPatientProvider);
    if (patient == null) {
      state = state.copyWith(errorMessage: 'Chưa chọn bệnh nhân.');
      return;
    }

    final List<ClinicalVariableDto> variables;
    try {
      variables = await ref.read(diagnosisFormProvider.future);
    } on Exception {
      state = state.copyWith(errorMessage: 'Không thể tải biểu mẫu chẩn đoán.');
      return;
    }

    final inputs = ref.read(diagnosisControllerProvider);
    final observations = <ObservationDto>[];
    final missingRequired = <String>[];

    for (final variable in variables) {
      final raw = inputs.valueOf(variable.id)?.trim() ?? '';
      if (variable.valueType == 'Boolean') {
        observations.add(
          ObservationDto(
            variableId: variable.id,
            value: raw == 'true' ? 'true' : 'false',
          ),
        );
        continue;
      }
      if (raw.isEmpty) {
        if (variable.isRequired) missingRequired.add(variable.name);
        continue;
      }
      observations.add(ObservationDto(variableId: variable.id, value: raw));
    }

    if (missingRequired.isNotEmpty) {
      state = state.copyWith(
        errorMessage: 'Thiếu thông tin bắt buộc: ${missingRequired.join(', ')}.',
      );
      return;
    }

    state = state.copyWith(diagnosing: true, clearError: true);
    try {
      final result = await _clinical.diagnoseEmpirical(
        observations: observations,
        allergies: inputs.allergyIds.toList(),
      );
      state = state.copyWith(
        diagnosing: false,
        result: result,
        clearError: true,
      );
    } on ApiException catch (e) {
      state = state.copyWith(diagnosing: false, errorMessage: e.message);
    } on DioException catch (e) {
      state = state.copyWith(
        diagnosing: false,
        errorMessage: dioErrorMessage(e),
      );
    }
  }
}
