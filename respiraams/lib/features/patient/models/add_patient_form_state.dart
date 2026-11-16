import 'package:freezed_annotation/freezed_annotation.dart';

import 'patient.dart';

part 'add_patient_form_state.freezed.dart';
part 'add_patient_form_state.g.dart';

/// Editable state of the "Thêm bệnh nhân" form.
///
/// Mirrors `CreatePatientCommand`: the name is split into Họ ([lastName]) /
/// Tên ([firstName]) as the backend stores `LastName` + `FirstName`, and the
/// body additionally needs phone, height and weight.
@freezed
class AddPatientFormState with _$AddPatientFormState {
  const factory AddPatientFormState({
    @Default('') String lastName,
    @Default('') String firstName,
    @Default('') String code,
    @Default('') String dob,
    @Default(Gender.nam) Gender gender,
    @Default('') String insurance,
    @Default('') String phoneNumber,
    @Default('') String heightCm,
    @Default('') String weightKg,
    @Default('') String address,
    @Default('') String city,
  }) = _AddPatientFormState;

  factory AddPatientFormState.fromJson(Map<String, dynamic> json) =>
      _$AddPatientFormStateFromJson(json);
}
