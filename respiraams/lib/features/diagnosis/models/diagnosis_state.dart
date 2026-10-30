/// User input for the dynamic empirical-diagnosis wizard.
///
/// [values] maps a clinical-variable **id** to the raw string the user
/// entered/toggled (booleans are `'true'`/`'false'`, numerics keep their
/// raw text so partial input is preserved). [allergyIds] holds selected
/// antibiotic ids sent as `allergies`.
class DiagnosisFormState {
  const DiagnosisFormState({
    this.values = const {},
    this.allergyIds = const {},
  });

  final Map<String, String> values;
  final Set<String> allergyIds;

  String? valueOf(String variableId) => values[variableId];

  bool isTrue(String variableId) => values[variableId] == 'true';

  DiagnosisFormState copyWith({
    Map<String, String>? values,
    Set<String>? allergyIds,
  }) {
    return DiagnosisFormState(
      values: values ?? this.values,
      allergyIds: allergyIds ?? this.allergyIds,
    );
  }
}
