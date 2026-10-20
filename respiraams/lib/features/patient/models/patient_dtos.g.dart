// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_dtos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PatientListItemDtoImpl _$$PatientListItemDtoImplFromJson(
  Map<String, dynamic> json,
) => _$PatientListItemDtoImpl(
  id: json['id'] as String,
  fullName: json['fullName'] as String,
  dateOfBirth: json['dateOfBirth'] as String,
  age: (json['age'] as num).toInt(),
  gender: json['gender'] as String,
  medicalRecordCode: json['medicalRecordCode'] as String,
  treatmentOutcome: $enumDecode(
    _$PatientStatusDtoEnumMap,
    json['treatmentOutcome'],
  ),
);

Map<String, dynamic> _$$PatientListItemDtoImplToJson(
  _$PatientListItemDtoImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'fullName': instance.fullName,
  'dateOfBirth': instance.dateOfBirth,
  'age': instance.age,
  'gender': instance.gender,
  'medicalRecordCode': instance.medicalRecordCode,
  'treatmentOutcome': _$PatientStatusDtoEnumMap[instance.treatmentOutcome]!,
};

const _$PatientStatusDtoEnumMap = {
  PatientStatusDto.inTreatment: 'InTreatment',
  PatientStatusDto.recovered: 'Recovered',
  PatientStatusDto.death: 'Death',
  PatientStatusDto.outOfScope: 'OutOfScope',
};

_$CreatedPatientDtoImpl _$$CreatedPatientDtoImplFromJson(
  Map<String, dynamic> json,
) => _$CreatedPatientDtoImpl(id: json['id'] as String);

Map<String, dynamic> _$$CreatedPatientDtoImplToJson(
  _$CreatedPatientDtoImpl instance,
) => <String, dynamic>{'id': instance.id};

_$NextOfKinItemDtoImpl _$$NextOfKinItemDtoImplFromJson(
  Map<String, dynamic> json,
) => _$NextOfKinItemDtoImpl(
  id: json['id'] as String,
  fullName: json['fullName'] as String,
  phoneNumber: json['phoneNumber'] as String,
  relationship: json['relationship'] as String,
);

Map<String, dynamic> _$$NextOfKinItemDtoImplToJson(
  _$NextOfKinItemDtoImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'fullName': instance.fullName,
  'phoneNumber': instance.phoneNumber,
  'relationship': instance.relationship,
};

_$TreatmentItemDtoImpl _$$TreatmentItemDtoImplFromJson(
  Map<String, dynamic> json,
) => _$TreatmentItemDtoImpl(id: json['id'] as String);

Map<String, dynamic> _$$TreatmentItemDtoImplToJson(
  _$TreatmentItemDtoImpl instance,
) => <String, dynamic>{'id': instance.id};

_$PatientDetailDtoImpl _$$PatientDetailDtoImplFromJson(
  Map<String, dynamic> json,
) => _$PatientDetailDtoImpl(
  id: json['id'] as String,
  fullName: json['fullName'] as String,
  phoneNumber: json['phoneNumber'] as String,
  dateOfBirth: json['dateOfBirth'] as String,
  gender: json['gender'] as String,
  height: (json['height'] as num).toDouble(),
  weight: (json['weight'] as num).toDouble(),
  medicalRecordCode: json['medicalRecordCode'] as String,
  healthInsuranceCard: json['healthInsuranceCard'] as String,
  address: json['address'] as String,
  city: json['city'] as String,
  admission: json['admission'] as String,
  discharge: json['discharge'] as String?,
  treatmentOutcome: $enumDecode(
    _$PatientStatusDtoEnumMap,
    json['treatmentOutcome'],
  ),
  nextOfKins:
      (json['nextOfKins'] as List<dynamic>?)
          ?.map((e) => NextOfKinItemDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  treatments:
      (json['treatments'] as List<dynamic>?)
          ?.map((e) => TreatmentItemDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$$PatientDetailDtoImplToJson(
  _$PatientDetailDtoImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'fullName': instance.fullName,
  'phoneNumber': instance.phoneNumber,
  'dateOfBirth': instance.dateOfBirth,
  'gender': instance.gender,
  'height': instance.height,
  'weight': instance.weight,
  'medicalRecordCode': instance.medicalRecordCode,
  'healthInsuranceCard': instance.healthInsuranceCard,
  'address': instance.address,
  'city': instance.city,
  'admission': instance.admission,
  'discharge': instance.discharge,
  'treatmentOutcome': _$PatientStatusDtoEnumMap[instance.treatmentOutcome]!,
  'nextOfKins': instance.nextOfKins,
  'treatments': instance.treatments,
};
