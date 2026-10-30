import 'package:freezed_annotation/freezed_annotation.dart';

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

/// One treatment reference in the patient's timeline (`TreatmentItem`).
@freezed
class TreatmentItemDto with _$TreatmentItemDto {
  const factory TreatmentItemDto({required String id}) = _TreatmentItemDto;

  factory TreatmentItemDto.fromJson(Map<String, dynamic> json) =>
      _$TreatmentItemDtoFromJson(json);
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
    @Default([]) List<TreatmentItemDto> treatments,
  }) = _PatientDetailDto;

  factory PatientDetailDto.fromJson(Map<String, dynamic> json) =>
      _$PatientDetailDtoFromJson(json);
}
