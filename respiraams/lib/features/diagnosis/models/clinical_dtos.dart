import 'package:freezed_annotation/freezed_annotation.dart';

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

/// `GET /diagnose/empirical` variable (`ClinicalVariableResult`).
///
/// [valueType] is one of `Numeric | Boolean | Categorical`; [category] is
/// one of `PersonalInformation | Paraclinical | Clinical`.
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

/// `GET /diagnose/empirical` response (`GetDiagnosisFormResult`).
@freezed
class DiagnosisFormDto with _$DiagnosisFormDto {
  const factory DiagnosisFormDto({
    @Default([]) List<ClinicalVariableDto> variables,
  }) = _DiagnosisFormDto;

  factory DiagnosisFormDto.fromJson(Map<String, dynamic> json) =>
      _$DiagnosisFormDtoFromJson(json);
}

/// `POST /diagnose/empirical` leaf pathogen/antibiotic reference
/// (`PathogenResult` / `AntibioticResult`).
@freezed
class NamedRefDto with _$NamedRefDto {
  const factory NamedRefDto({required String id, required String name}) =
      _NamedRefDto;

  factory NamedRefDto.fromJson(Map<String, dynamic> json) =>
      _$NamedRefDtoFromJson(json);
}

/// Missing-variable reference on the diagnose result
/// (`ClinicalVariableResult`).
@freezed
class VariableRefDto with _$VariableRefDto {
  const factory VariableRefDto({
    required String id,
    required String name,
    @Default('') String code,
  }) = _VariableRefDto;

  factory VariableRefDto.fromJson(Map<String, dynamic> json) =>
      _$VariableRefDtoFromJson(json);
}

/// One evaluated criterion (`Evidence`). Unused keys are ignored.
@freezed
class EvidenceDto with _$EvidenceDto {
  const factory EvidenceDto({
    @Default('') String source,
    @Default('') String formula,
    Object? evaluatedValue,
    num? score,
    bool? isMajor,
    @Default([]) List<VariableRefDto> missingVariables,
  }) = _EvidenceDto;

  factory EvidenceDto.fromJson(Map<String, dynamic> json) =>
      _$EvidenceDtoFromJson(json);
}

/// `POST /diagnose/empirical` response (`DiagnoseResult`).
@freezed
class DiagnoseResultDto with _$DiagnoseResultDto {
  const factory DiagnoseResultDto({
    required String severity, // Mild | Moderate | Severe
    required String treatmentSite, // Outpatient | Inpatient | IntensiveCareUnit
    @Default([]) List<NamedRefDto> worthSuspected,
    @Default([]) List<NamedRefDto> heavySuspected,
    @Default([]) List<EvidenceDto> evidences,
    @Default([]) List<VariableRefDto> missingVariables,
    @Default([]) List<NamedRefDto> allergies,
    @Default(false) bool isPatientPregnantOrInLactationPhase,
  }) = _DiagnoseResultDto;

  factory DiagnoseResultDto.fromJson(Map<String, dynamic> json) =>
      _$DiagnoseResultDtoFromJson(json);
}

/// Body of `POST /diagnose/empirical` (`Observation`).
class ObservationDto {
  const ObservationDto({required this.variableId, required this.value});

  final String variableId;
  final String value;

  Map<String, dynamic> toJson() => {'variableId': variableId, 'value': value};
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
    required String routeOfAdministration,
    required String dose,
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
