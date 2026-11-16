// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PatientSummaryImpl _$$PatientSummaryImplFromJson(Map<String, dynamic> json) =>
    _$PatientSummaryImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      code: json['code'] as String,
      gender: $enumDecode(_$GenderEnumMap, json['gender']),
      age: (json['age'] as num).toInt(),
      status: $enumDecode(_$PatientStatusEnumMap, json['status']),
    );

Map<String, dynamic> _$$PatientSummaryImplToJson(
  _$PatientSummaryImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'code': instance.code,
  'gender': _$GenderEnumMap[instance.gender]!,
  'age': instance.age,
  'status': _$PatientStatusEnumMap[instance.status]!,
};

const _$GenderEnumMap = {Gender.nam: 'nam', Gender.nu: 'nu'};

const _$PatientStatusEnumMap = {
  PatientStatus.treating: 'treating',
  PatientStatus.recovered: 'recovered',
  PatientStatus.deceased: 'deceased',
};
