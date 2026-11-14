import 'package:freezed_annotation/freezed_annotation.dart';

// `@JsonKey` is applied to freezed factory parameters by design.
// ignore_for_file: invalid_annotation_target

part 'clinical_dtos.freezed.dart';
part 'clinical_dtos.g.dart';

/// `range` payload of numeric clinical variables (`Range`).
@freezed
class RangeDto with _$RangeDto {
  const factory RangeDto({
    required num min,
    @Default(false) bool isMinExclusive,
    required num max,
    @Default(false) bool isMaxExclusive,
    String? unit,
  }) = _RangeDto;

  factory RangeDto.fromJson(Map<String, dynamic> json) =>
      _$RangeDtoFromJson(json);
}

/// `GET /diagnose` variable (`ClinicalVariableResult`).
///
/// [valueType] is one of `Numeric | Boolean | Categorical`; [category] is
/// one of `PersonalInformation | MedicalHistory | Paraclinical | Clinical`.
@freezed
class ClinicalVariableDto with _$ClinicalVariableDto {
  const factory ClinicalVariableDto({
    required String id,
    required String name,
    @Default('') String description,
    required String code,
    required String valueType,
    String? canonicalUnit,
    @Default(false) bool isRequired,
    required String category,
    @Default([]) List<String> acceptedValues,
    RangeDto? normalRange,
    RangeDto? acceptedRange,
  }) = _ClinicalVariableDto;

  factory ClinicalVariableDto.fromJson(Map<String, dynamic> json) =>
      _$ClinicalVariableDtoFromJson(json);
}

/// `GET /diagnose` response (`DiagnoseFormResult`).
///
/// [variables] is kept as an alias of [clinicalVariables] for the wizard,
/// which only renders the clinical variable catalog.
@freezed
class DiagnosisFormDto with _$DiagnosisFormDto {
  const DiagnosisFormDto._();

  const factory DiagnosisFormDto({
    @Default([]) List<ClinicalVariableDto> clinicalVariables,
    @Default([]) List<AntibioticFormDto> antibiotics,
    @Default([]) List<NamedRefDto> pathogens,
  }) = _DiagnosisFormDto;

  factory DiagnosisFormDto.fromJson(Map<String, dynamic> json) =>
      _$DiagnosisFormDtoFromJson(json);

  List<ClinicalVariableDto> get variables => clinicalVariables;
}

/// Antibiotic entry of the diagnose form (`DiagnoseFormResult.Antibiotics`).
@freezed
class AntibioticFormDto with _$AntibioticFormDto {
  const factory AntibioticFormDto({
    required String id,
    required String name,
    @Default('') String antibioticGroupId,
    @Default('') String antibioticGroupName,
    @Default('') String classification,
  }) = _AntibioticFormDto;

  factory AntibioticFormDto.fromJson(Map<String, dynamic> json) =>
      _$AntibioticFormDtoFromJson(json);
}

/// `POST /diagnose` leaf pathogen/antibiotic reference
/// (`PathogenResult` / `AntibioticResult`).
@freezed
class NamedRefDto with _$NamedRefDto {
  const factory NamedRefDto({required String id, required String name}) =
      _NamedRefDto;

  factory NamedRefDto.fromJson(Map<String, dynamic> json) =>
      _$NamedRefDtoFromJson(json);
}

/// Missing-variable reference on the diagnose result
/// (`ClinicalVariableResult` for the top-level list, `VariableRef` inside an
/// evidence).
///
/// The lightweight `VariableRef` used by evidence rows only carries
/// `id`/`code`/`valueType` — no `name` — so [name] is optional and falls back
/// to [code] for display.
@freezed
class VariableRefDto with _$VariableRefDto {
  const VariableRefDto._();

  const factory VariableRefDto({
    required String id,
    @Default('') String name,
    @Default('') String code,
  }) = _VariableRefDto;

  factory VariableRefDto.fromJson(Map<String, dynamic> json) =>
      _$VariableRefDtoFromJson(json);

  /// Human-readable label: the variable name when the payload has one,
  /// otherwise its code (e.g. `CONFUSION`).
  String get displayLabel => name.trim().isNotEmpty ? name.trim() : code;
}

/// Clinical observation echoed by an [EvidenceDto] (`ClinicalObservationRef`).
@freezed
class RelatedObservationDto with _$RelatedObservationDto {
  const factory RelatedObservationDto({
    VariableRefDto? variable,
    Object? value,
  }) = _RelatedObservationDto;

  factory RelatedObservationDto.fromJson(Map<String, dynamic> json) =>
      _$RelatedObservationDtoFromJson(json);
}

/// One evaluated criterion (`Evidence`). Unused keys are ignored.
@freezed
class EvidenceDto with _$EvidenceDto {
  const factory EvidenceDto({
    @Default('') String source,
    @Default('') String formula,
    @Default([]) List<RelatedObservationDto> relatedObservations,
    Object? evaluatedValue,
    num? score,
    bool? isMajor,
    @Default([]) List<VariableRefDto> missingVariables,
  }) = _EvidenceDto;

  factory EvidenceDto.fromJson(Map<String, dynamic> json) =>
      _$EvidenceDtoFromJson(json);
}

/// One severity metric result (`MetricsSeverityDiagnosis`).
///
/// The backend serializes two shapes: score-based metrics carry [score],
/// while major/minor metrics carry [majorMatched] and [minorMatched].
@freezed
class MetricsSeverityDto with _$MetricsSeverityDto {
  const factory MetricsSeverityDto({
    @Default('') String code,
    @Default('') String severity,
    @Default('') String treatmentSite,
    @Default([]) List<EvidenceDto> evidences,
    int? score,
    int? majorMatched,
    int? minorMatched,
  }) = _MetricsSeverityDto;

  factory MetricsSeverityDto.fromJson(Map<String, dynamic> json) =>
      _$MetricsSeverityDtoFromJson(json);
}

/// One culture result (`MicrobialTestResult`).
@freezed
class MicrobialTestResultDto with _$MicrobialTestResultDto {
  const factory MicrobialTestResultDto({
    @Default('') String sampleType,
    @Default('') String category, // Susceptible | Intermediate | Resistant
    NamedRefDto? pathogen,
    @Default([]) List<AntibioticRefDto> antibiotics,
  }) = _MicrobialTestResultDto;

  factory MicrobialTestResultDto.fromJson(Map<String, dynamic> json) =>
      _$MicrobialTestResultDtoFromJson(json);
}

/// One criterion reference of a treatment protocol (`CriterionResult`).
@freezed
class CriterionRefDto with _$CriterionRefDto {
  const factory CriterionRefDto({
    @Default('') String id,
    @Default('') String name,
    @Default('') String formula,
  }) = _CriterionRefDto;

  factory CriterionRefDto.fromJson(Map<String, dynamic> json) =>
      _$CriterionRefDtoFromJson(json);
}

/// Recommended treatment protocol (`TreatmentProtocolResult`).
///
/// [medicines] is a list of combinations; each combination is the set of
/// antibiotics that must be prescribed together.
@freezed
class TreatmentProtocolDto with _$TreatmentProtocolDto {
  const factory TreatmentProtocolDto({
    @Default('') String id,
    @Default('') String severity,
    @Default('') String treatmentSite,
    @Default([]) List<List<AntibioticRefDto>> medicines,
    @Default([]) List<NamedRefDto> pathogens,
    @Default([]) List<CriterionRefDto> criteria,
  }) = _TreatmentProtocolDto;

  factory TreatmentProtocolDto.fromJson(Map<String, dynamic> json) =>
      _$TreatmentProtocolDtoFromJson(json);
}

/// `POST /diagnose` response (`DiagnoseResult`).
@freezed
class DiagnoseResultDto with _$DiagnoseResultDto {
  const factory DiagnoseResultDto({
    @Default('') String diagnosisId,
    required String severity, // Mild | Moderate | Severe
    required String treatmentSite, // Outpatient | Inpatient | IntensiveCareUnit
    @Default([]) List<NamedRefDto> worthSuspected,
    @Default([]) List<NamedRefDto> heavySuspected,
    @Default([]) List<EvidenceDto> evidences,
    @Default([]) List<VariableRefDto> missingVariables,
    @Default(false) bool isPatientPregnantOrInLactationPhase,
    double? egfr,
    @Default([]) List<String> otherInfections,
    AllergyResultDto? allergy,
    @Default([]) List<MetricsSeverityDto> metricsSeverityDiagnosis,
    @Default([]) List<MicrobialTestResultDto> microbialTestResults,
    @Default([]) List<TreatmentProtocolDto> protocols,

    /// Raw `data` snapshot of the response, echoed back verbatim to
    /// `POST /diagnose/confirm-treatment` (the backend takes it as
    /// `JsonElement` and must not receive a re-serialized subset).
    @JsonKey(includeFromJson: false, includeToJson: false)
    Map<String, dynamic>? rawJson,
  }) = _DiagnoseResultDto;

  factory DiagnoseResultDto.fromJson(Map<String, dynamic> json) =>
      _$DiagnoseResultDtoFromJson(json);
}

/// Antibiotic reference embedded in the diagnose result (`AntibioticResult`).
@freezed
class AntibioticRefDto with _$AntibioticRefDto {
  const factory AntibioticRefDto({
    required String id,
    required String name,
    @Default('') String classification,
  }) = _AntibioticRefDto;

  factory AntibioticRefDto.fromJson(Map<String, dynamic> json) =>
      _$AntibioticRefDtoFromJson(json);
}

/// Patient allergy echoed by the diagnose result (`AllergyResult`).
@freezed
class AllergyResultDto with _$AllergyResultDto {
  const factory AllergyResultDto({
    @Default('Unknown')
    String type, // Yes | No | NonRegisteredAntibiotic | Unknown
    @Default([]) List<AntibioticRefDto> allergicAntibiotics,
    String? otherAllergy,
  }) = _AllergyResultDto;

  factory AllergyResultDto.fromJson(Map<String, dynamic> json) =>
      _$AllergyResultDtoFromJson(json);
}

/// Body of `POST /diagnose` (`Observation`).
class ObservationDto {
  const ObservationDto({required this.variableId, required this.value});

  final String variableId;
  final String value;

  Map<String, dynamic> toJson() => {'variableId': variableId, 'value': value};
}

/// Body of `POST /diagnose` (`AllergyQuery`).
class AllergyInputDto {
  const AllergyInputDto({
    required this.type,
    this.allergicAntibioticIds = const [],
    this.otherAllergy,
  });

  /// `Yes | No | NonRegisteredAntibiotic | Unknown`.
  final String type;
  final List<String> allergicAntibioticIds;
  final String? otherAllergy;

  Map<String, dynamic> toJson() => {
    'type': type,
    'allergicAntibioticIds': allergicAntibioticIds,
    'otherAllergy': otherAllergy,
  };
}

/// Body of `POST /diagnose` (`MicrobialSampleQuery`).
class MicrobialSampleInputDto {
  const MicrobialSampleInputDto({
    required this.sampleType,
    required this.micCategory,
    required this.pathogenId,
  });

  final String sampleType;
  final String micCategory;
  final String pathogenId;

  MicrobialSampleInputDto copyWith({
    String? sampleType,
    String? micCategory,
    String? pathogenId,
  }) {
    return MicrobialSampleInputDto(
      sampleType: sampleType ?? this.sampleType,
      micCategory: micCategory ?? this.micCategory,
      pathogenId: pathogenId ?? this.pathogenId,
    );
  }

  Map<String, dynamic> toJson() => {
    'sampleType': sampleType,
    'micCategory': micCategory,
    'pathogenId': pathogenId,
  };
}

// ── Targeted (vi sinh) demo types ──────────────────────────────────────
// The mobile app keeps a demo targeted-therapy flow until the backend
// exposes `POST /diagnose/target`.

/// `GET /pathogens/list` item.
@freezed
class PathogenItemDto with _$PathogenItemDto {
  const factory PathogenItemDto({required String id, required String name}) =
      _PathogenItemDto;

  factory PathogenItemDto.fromJson(Map<String, dynamic> json) =>
      _$PathogenItemDtoFromJson(json);
}

/// One recommended antibiotic for the targeted demo.
@freezed
class AntibioticResultDto with _$AntibioticResultDto {
  const factory AntibioticResultDto({
    required String id,
    required String name,
    @Default('') String antibioticGroupName,
    @Default('') String classification,
    @Default([]) List<DosageDto> dosages,
  }) = _AntibioticResultDto;

  factory AntibioticResultDto.fromJson(Map<String, dynamic> json) =>
      _$AntibioticResultDtoFromJson(json);
}

/// Adjusted dose of one antibiotic (`DosageResult`).
@freezed
class DosageDto with _$DosageDto {
  const factory DosageDto({
    @Default('') String id,
    required String routeOfAdministration,
    required String dose,

    /// CrCl adjustment range; `null` means this is the standard dose.
    RangeDto? crcl,
  }) = _DosageDto;

  factory DosageDto.fromJson(Map<String, dynamic> json) =>
      _$DosageDtoFromJson(json);
}

/// Demo targeted-diagnosis result.
@freezed
class TargetedDiagnoseResultDto with _$TargetedDiagnoseResultDto {
  const factory TargetedDiagnoseResultDto({
    @Default(0) double crcl,
    @Default([]) List<AntibioticResultDto> recommendations,
  }) = _TargetedDiagnoseResultDto;

  factory TargetedDiagnoseResultDto.fromJson(Map<String, dynamic> json) =>
      _$TargetedDiagnoseResultDtoFromJson(json);
}
