import 'package:freezed_annotation/freezed_annotation.dart';

// `@JsonKey` is applied to freezed factory parameters by design.
// ignore_for_file: invalid_annotation_target

part 'patient_dtos.freezed.dart';
part 'patient_dtos.g.dart';

/// `Domain.Enums.TreatmentOutcome` (string-serialized, PascalCase on the wire).
enum PatientStatusDto {
  @JsonValue('InTreatment')
  inTreatment,
  @JsonValue('Recovered')
  recovered,
  @JsonValue('Death')
  death,
  @JsonValue('OutOfScope')
  outOfScope,
}

/// Row of `GET /patients` (`PagedPatientItem`).
@freezed
class PatientListItemDto with _$PatientListItemDto {
  const factory PatientListItemDto({
    required String id,
    required String fullName,
    required String dateOfBirth,
    required int age,

    /// `Male` | `Female`.
    required String gender,
    required String medicalRecordCode,
    required PatientStatusDto treatmentOutcome,
  }) = _PatientListItemDto;

  factory PatientListItemDto.fromJson(Map<String, dynamic> json) =>
      _$PatientListItemDtoFromJson(json);
}

/// Result of `POST /patients` (`CreatePatientResult`).
@freezed
class CreatedPatientDto with _$CreatedPatientDto {
  const factory CreatedPatientDto({required String id}) = _CreatedPatientDto;

  factory CreatedPatientDto.fromJson(Map<String, dynamic> json) =>
      _$CreatedPatientDtoFromJson(json);
}

/// Next-of-kin entry of `GET /patients/{id}` (`NextOfKinItem`).
@freezed
class NextOfKinItemDto with _$NextOfKinItemDto {
  const factory NextOfKinItemDto({
    required String id,
    required String fullName,
    required String phoneNumber,
    required String relationship,
  }) = _NextOfKinItemDto;

  factory NextOfKinItemDto.fromJson(Map<String, dynamic> json) =>
      _$NextOfKinItemDtoFromJson(json);
}

/// One treatment reference in the patient's timeline (`TreatmentPlanItem`).
@freezed
class TreatmentPlanItemDto with _$TreatmentPlanItemDto {
  const factory TreatmentPlanItemDto({
    required String id,

    /// `Adhere` | `NotAdhere` | `NotAdhereValid` | `NotAdhereInvalid`.
    @Default('Adhere') String adherenceState,

    /// `TreatmentPlanStatus` has no string enum converter on the backend,
    /// so it arrives as a number: `0` = InProgress, `1` = Closed.
    @JsonKey(fromJson: _treatmentPlanStatusFromJson)
    @Default(0)
    int treatmentPlanStatus,

    @Default('') String updatedAt,
  }) = _TreatmentPlanItemDto;

  factory TreatmentPlanItemDto.fromJson(Map<String, dynamic> json) =>
      _$TreatmentPlanItemDtoFromJson(json);
}

int _treatmentPlanStatusFromJson(Object? value) {
  if (value is num) return value.toInt();
  if (value is String) {
    final parsed = int.tryParse(value);
    if (parsed != null) return parsed;
    if (value.toLowerCase() == 'closed') return 1;
  }
  return 0;
}

/// Result of `GET /patients/{id}` (`PatientResult`).
@freezed
class PatientDetailDto with _$PatientDetailDto {
  const factory PatientDetailDto({
    required String id,
    required String fullName,
    required String phoneNumber,
    required String dateOfBirth,
    required String gender, // Male | Female
    required double height, // cm
    required double weight, // kg
    required String medicalRecordCode,
    required String healthInsuranceCard,
    required String address,
    required String city,
    required String admission,
    String? discharge,
    required PatientStatusDto treatmentOutcome,
    @Default([]) List<NextOfKinItemDto> nextOfKins,
    @Default([]) List<TreatmentPlanItemDto> treatmentPlans,
  }) = _PatientDetailDto;

  factory PatientDetailDto.fromJson(Map<String, dynamic> json) =>
      _$PatientDetailDtoFromJson(json);
}

/// Patient reference embedded in `GET /treatment-plans/{id}`.
@freezed
class TreatmentPlanPatientDto with _$TreatmentPlanPatientDto {
  const factory TreatmentPlanPatientDto({
    required String id,
    required String name,
  }) = _TreatmentPlanPatientDto;

  factory TreatmentPlanPatientDto.fromJson(Map<String, dynamic> json) =>
      _$TreatmentPlanPatientDtoFromJson(json);
}

/// Medicine embedded in `GET /treatment-plans/{id}` (simplified antibiotic).
@freezed
class TreatmentMedicineDto with _$TreatmentMedicineDto {
  const factory TreatmentMedicineDto({
    required String id,
    required String name,
    @Default('') String classification,
  }) = _TreatmentMedicineDto;

  factory TreatmentMedicineDto.fromJson(Map<String, dynamic> json) =>
      _$TreatmentMedicineDtoFromJson(json);
}

/// Result of `GET /treatment-plans/{id}` (`TreatmentPlanResult`).
@freezed
class TreatmentPlanDetailDto with _$TreatmentPlanDetailDto {
  const factory TreatmentPlanDetailDto({
    required String id,
    required TreatmentPlanPatientDto patient,
    @Default('') String doctorId,
    @Default('') String diagnosis,
    @Default([]) List<TreatmentMedicineDto> medicines,
    String? reasonForMedicineChoice,

    /// `Adhere` | `NotAdhere` | `NotAdhereValid` | `NotAdhereInvalid`.
    @Default('Adhere') String adherenceState,

    /// `TreatmentPlanStatus` is numeric on the wire (`0` = InProgress,
    /// `1` = Closed).
    @JsonKey(fromJson: _treatmentPlanStatusFromJson) @Default(0) int status,

    String? closeReason,
  }) = _TreatmentPlanDetailDto;

  factory TreatmentPlanDetailDto.fromJson(Map<String, dynamic> json) =>
      _$TreatmentPlanDetailDtoFromJson(json);
}
