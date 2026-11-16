import 'clinical_dtos.dart';

/// User input for the dynamic diagnosis wizard.
///
/// [values] maps a clinical-variable **id** to the raw string the user
/// entered/toggled (booleans are `'true'`/`'false'`, numerics keep their
/// raw text so partial input is preserved).
///
/// [allergyType] mirrors `AllergyType`
/// (`Yes | No | NonRegisteredAntibiotic | Unknown`); `null` means the doctor
/// has not chosen yet. [allergicAntibioticIds] are only sent when the type is
/// `Yes`, and [otherAllergy] when it is `NonRegisteredAntibiotic` or
/// `Unknown`.
///
/// [specialMedicalHistory], [otherInfections] and [microbialSamples] map to
/// the optional `POST /diagnose` fields of the same names.
class DiagnosisFormState {
  const DiagnosisFormState({
    this.values = const {},
    this.allergyType,
    this.allergicAntibioticIds = const {},
    this.otherAllergy = '',
    this.specialMedicalHistory = const [],
    this.otherInfections = const {},
    this.microbialSamples = const [],
  });

  final Map<String, String> values;
  final String? allergyType;
  final Set<String> allergicAntibioticIds;
  final String otherAllergy;
  final List<String> specialMedicalHistory;
  final Set<String> otherInfections;
  final List<MicrobialSampleInputDto> microbialSamples;

  String? valueOf(String variableId) => values[variableId];

  bool isTrue(String variableId) => values[variableId] == 'true';

  bool get hasAllergySelection => allergyType != null;

  bool get hasAntibioticAllergy => allergyType == 'Yes';

  bool get needsOtherAllergy =>
      allergyType == 'NonRegisteredAntibiotic' || allergyType == 'Unknown';

  DiagnosisFormState copyWith({
    Map<String, String>? values,
    String? allergyType,
    Set<String>? allergicAntibioticIds,
    String? otherAllergy,
    List<String>? specialMedicalHistory,
    Set<String>? otherInfections,
    List<MicrobialSampleInputDto>? microbialSamples,
  }) {
    return DiagnosisFormState(
      values: values ?? this.values,
      allergyType: allergyType ?? this.allergyType,
      allergicAntibioticIds:
          allergicAntibioticIds ?? this.allergicAntibioticIds,
      otherAllergy: otherAllergy ?? this.otherAllergy,
      specialMedicalHistory:
          specialMedicalHistory ?? this.specialMedicalHistory,
      otherInfections: otherInfections ?? this.otherInfections,
      microbialSamples: microbialSamples ?? this.microbialSamples,
    );
  }
}
