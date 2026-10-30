import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/diagnosis_state.dart';

part 'diagnosis_controller.g.dart';

/// Holds the dynamic diagnosis-wizard input keyed by clinical-variable id.
@Riverpod(keepAlive: true)
class DiagnosisController extends _$DiagnosisController {
  @override
  DiagnosisFormState build() => const DiagnosisFormState();

  void setValue(String variableId, String value) {
    state = state.copyWith(values: {...state.values, variableId: value});
  }

  void setBool(String variableId, bool value) =>
      setValue(variableId, value ? 'true' : 'false');

  void toggleAllergy(String antibioticId) {
    final next = {...state.allergyIds};
    if (!next.remove(antibioticId)) {
      next.add(antibioticId);
    }
    state = state.copyWith(allergyIds: next);
  }

  void reset() => state = const DiagnosisFormState();
}
