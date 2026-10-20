// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_patient_form_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AddPatientFormStateImpl _$$AddPatientFormStateImplFromJson(
  Map<String, dynamic> json,
) => _$AddPatientFormStateImpl(
  lastName: json['lastName'] as String? ?? '',
  firstName: json['firstName'] as String? ?? '',
  code: json['code'] as String? ?? '',
  dob: json['dob'] as String? ?? '',
  gender: $enumDecodeNullable(_$GenderEnumMap, json['gender']) ?? Gender.nam,
  insurance: json['insurance'] as String? ?? '',
  phoneNumber: json['phoneNumber'] as String? ?? '',
  heightCm: json['heightCm'] as String? ?? '',
  weightKg: json['weightKg'] as String? ?? '',
  address: json['address'] as String? ?? '',
  city: json['city'] as String? ?? '',
);

Map<String, dynamic> _$$AddPatientFormStateImplToJson(
  _$AddPatientFormStateImpl instance,
) => <String, dynamic>{
  'lastName': instance.lastName,
  'firstName': instance.firstName,
  'code': instance.code,
  'dob': instance.dob,
  'gender': _$GenderEnumMap[instance.gender]!,
  'insurance': instance.insurance,
  'phoneNumber': instance.phoneNumber,
  'heightCm': instance.heightCm,
  'weightKg': instance.weightKg,
  'address': instance.address,
  'city': instance.city,
};

const _$GenderEnumMap = {Gender.nam: 'nam', Gender.nu: 'nu'};
