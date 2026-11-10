import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/api_client.dart';
import '../../../core/network/api_response.dart';
import '../../patient/providers/current_patient_provider.dart';
import '../models/clinical_dtos.dart';
import '../services/clinical_service.dart';
import 'diagnosis_controller.dart';

part 'diagnosis_flow_provider.g.dart';

/// Dynamic form catalog from `GET /diagnose` (clinical variables,
/// antibiotics and pathogens).
@Riverpod(keepAlive: true)
Future<DiagnosisFormDto> diagnosisForm(DiagnosisFormRef ref) {
  return ClinicalService(ref.watch(apiClientProvider)).getDiagnosisForm();
}

/// Immutable snapshot of the empirical diagnosis call and the
/// confirm-treatment follow-up.
class DiagnosisFlowState {
  const DiagnosisFlowState({
    this.diagnosing = false,
    this.confirming = false,
    this.result,
    this.errorMessage,
    this.confirmError,
    this.needCombinationWarning = false,
  });

  final bool diagnosing;
  final bool confirming;
  final DiagnoseResultDto? result;
  final String? errorMessage;
  final String? confirmError;
  final bool needCombinationWarning;

  DiagnosisFlowState copyWith({
    bool? diagnosing,
    bool? confirming,
    DiagnoseResultDto? result,
    String? errorMessage,
    String? confirmError,
    bool? needCombinationWarning,
    bool clearError = false,
    bool clearConfirmError = false,
    bool clearResult = false,
  }) {
    return DiagnosisFlowState(
      diagnosing: diagnosing ?? this.diagnosing,
      confirming: confirming ?? this.confirming,
      result: clearResult ? null : (result ?? this.result),
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      confirmError:
          clearConfirmError ? null : (confirmError ?? this.confirmError),
      needCombinationWarning:
          needCombinationWarning ?? this.needCombinationWarning,
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

  /// Calls `POST /diagnose` with the collected observations, allergy and
  /// optional contract fields.
  Future<void> runEmpiricalDiagnosis() async {
    final patient = ref.read(currentPatientProvider);
    if (patient == null) {
      state = state.copyWith(errorMessage: LocalApiError.noPatient);
      return;
    }

    final DiagnosisFormDto form;
    try {
      form = await ref.read(diagnosisFormProvider.future);
    } on Exception {
      state = state.copyWith(errorMessage: LocalApiError.formLoadFailed);
      return;
    }

    final inputs = ref.read(diagnosisControllerProvider);
    final observations = <ObservationDto>[];
    final missingRequired = <String>[];

    for (final variable in form.variables) {
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
      if (variable.valueType == 'Numeric' && double.tryParse(raw) == null) {
        state = state.copyWith(
          errorMessage: '${LocalApiError.invalidNumberPrefix}${variable.name}',
        );
        return;
      }
      observations.add(ObservationDto(variableId: variable.id, value: raw));
    }

    if (missingRequired.isNotEmpty) {
      state = state.copyWith(
        errorMessage:
            '${LocalApiError.missingRequiredPrefix}${missingRequired.join(', ')}',
      );
      return;
    }

    // Mirrors `AllergyQueryValidator`: the backend rejects ambiguous
    // combinations, so catch them before the request.
    if (!inputs.hasAllergySelection) {
      state = state.copyWith(errorMessage: LocalApiError.allergyRequired);
      return;
    }
    if (inputs.hasAntibioticAllergy &&
        inputs.allergicAntibioticIds.isEmpty) {
      state = state.copyWith(errorMessage: LocalApiError.allergyYesRequired);
      return;
    }
    if (inputs.needsOtherAllergy && inputs.otherAllergy.trim().isEmpty) {
      state = state.copyWith(errorMessage: LocalApiError.allergyOtherRequired);
      return;
    }

    if (inputs.microbialSamples.any((s) => s.pathogenId.trim().isEmpty)) {
      state = state.copyWith(
        errorMessage: LocalApiError.microbialPathogenRequired,
      );
      return;
    }

    final allergy = AllergyInputDto(
      type: inputs.allergyType!,
      allergicAntibioticIds: inputs.hasAntibioticAllergy
          ? inputs.allergicAntibioticIds.toList()
          : const [],
      otherAllergy: inputs.needsOtherAllergy
          ? inputs.otherAllergy.trim()
          : null,
    );

    state = state.copyWith(diagnosing: true, clearError: true);
    try {
      final result = await _clinical.diagnose(
        observations: observations,
        allergy: allergy,
        specialMedicalHistory: inputs.specialMedicalHistory,
        otherInfections: inputs.otherInfections.toList(),
        microbialSamples: inputs.microbialSamples,
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

  /// `POST /diagnose/warn-antibiotic-combination`. A failed check must not
  /// block the doctor, so it resolves to `false` on any error.
  Future<bool> checkCombinationWarning(List<String> antibioticIds) async {
    if (antibioticIds.length < 2) {
      state = state.copyWith(needCombinationWarning: false);
      return false;
    }
    try {
      final needWarning =
          await _clinical.warnAntibioticCombination(antibioticIds);
      state = state.copyWith(needCombinationWarning: needWarning);
      return needWarning;
    } on Exception {
      return false;
    }
  }

  /// `POST /diagnose/confirm-treatment` with the exact diagnosis snapshot
  /// captured from `POST /diagnose`.
  Future<bool> confirmTreatment({
    required List<String> medicineIds,
    String? reasonForMedicineChoice,
  }) async {
    final patient = ref.read(currentPatientProvider);
    if (patient == null) {
      state = state.copyWith(confirmError: LocalApiError.noPatient);
      return false;
    }

    final result = state.result;
    if (result == null || result.rawJson == null) {
      state = state.copyWith(confirmError: LocalApiError.noResultToSave);
      return false;
    }

    if (medicineIds.isEmpty) {
      state = state.copyWith(
        confirmError: LocalApiError.selectMedicineRequired,
      );
      return false;
    }

    state = state.copyWith(confirming: true, clearConfirmError: true);
    try {
      await _clinical.confirmTreatment(
        patientId: patient.id,
        diagnosis: result.rawJson!,
        medicineIds: medicineIds,
        reasonForMedicineChoice: reasonForMedicineChoice,
      );
      state = state.copyWith(confirming: false, clearConfirmError: true);
      return true;
    } on ApiException catch (e) {
      state = state.copyWith(confirming: false, confirmError: e.message);
      return false;
    } on DioException catch (e) {
      state = state.copyWith(
        confirming: false,
        confirmError: dioErrorMessage(e),
      );
      return false;
    }
  }

  void clearConfirmError() =>
      state = state.copyWith(clearConfirmError: true);

  void clearResult() => state = const DiagnosisFlowState();
}
