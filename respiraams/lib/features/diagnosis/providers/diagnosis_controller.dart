import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/clinical_dtos.dart';
import '../models/diagnosis_state.dart';

part 'diagnosis_controller.g.dart';

/// Holds the dynamic diagnosis-wizard input keyed by clinical-variable id,
/// plus the optional contract fields (`specialMedicalHistory`,
/// `otherInfections`, `microbialSamples`).
@Riverpod(keepAlive: true)
class DiagnosisController extends _$DiagnosisController {
  @override
  DiagnosisFormState build() => const DiagnosisFormState();

  void setValue(String variableId, String value) {
    state = state.copyWith(values: {...state.values, variableId: value});
  }

  void setBool(String variableId, bool value) =>
      setValue(variableId, value ? 'true' : 'false');

  /// `Yes | No | NonRegisteredAntibiotic | Unknown`.
  void setAllergyType(String type) {
    state = state.copyWith(
      allergyType: type,
      // Keep the selection only while it is meaningful; re-selecting `Yes`
      // starts from an empty antibiotic list.
      allergicAntibioticIds: state.allergyType == type
          ? state.allergicAntibioticIds
          : const {},
    );
  }

  void toggleAllergy(String antibioticId) {
    final next = {...state.allergicAntibioticIds};
    if (!next.remove(antibioticId)) {
      next.add(antibioticId);
    }
    state = state.copyWith(allergicAntibioticIds: next);
  }

  void setOtherAllergy(String value) =>
      state = state.copyWith(otherAllergy: value);

  void addSpecialHistory(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) return;
    state = state.copyWith(
      specialMedicalHistory: [...state.specialMedicalHistory, trimmed],
    );
  }

  void removeSpecialHistory(int index) {
    if (index < 0 || index >= state.specialMedicalHistory.length) return;
    final next = [...state.specialMedicalHistory]..removeAt(index);
    state = state.copyWith(specialMedicalHistory: next);
  }

  void toggleOtherInfection(String type) {
    final next = {...state.otherInfections};
    if (!next.remove(type)) {
      next.add(type);
    }
    state = state.copyWith(otherInfections: next);
  }

  void addMicrobialSample() {
    state = state.copyWith(
      microbialSamples: [
        ...state.microbialSamples,
        const MicrobialSampleInputDto(
          sampleType: 'Sputum',
          micCategory: 'Susceptible',
          pathogenId: '',
        ),
      ],
    );
  }

  void updateMicrobialSample(
    int index, {
    String? sampleType,
    String? micCategory,
    String? pathogenId,
  }) {
    if (index < 0 || index >= state.microbialSamples.length) return;
    final next = [...state.microbialSamples];
    next[index] = next[index].copyWith(
      sampleType: sampleType,
      micCategory: micCategory,
      pathogenId: pathogenId,
    );
    state = state.copyWith(microbialSamples: next);
  }

  void removeMicrobialSample(int index) {
    if (index < 0 || index >= state.microbialSamples.length) return;
    final next = [...state.microbialSamples]..removeAt(index);
    state = state.copyWith(microbialSamples: next);
  }

  void reset() => state = const DiagnosisFormState();
}
