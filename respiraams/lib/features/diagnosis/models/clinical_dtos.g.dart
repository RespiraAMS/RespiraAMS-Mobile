// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clinical_dtos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RangeDtoImpl _$$RangeDtoImplFromJson(Map<String, dynamic> json) =>
    _$RangeDtoImpl(
      min: json['min'] as num,
      isMinExclusive: json['isMinExclusive'] as bool? ?? false,
      max: json['max'] as num,
      isMaxExclusive: json['isMaxExclusive'] as bool? ?? false,
      unit: json['unit'] as String?,
    );

Map<String, dynamic> _$$RangeDtoImplToJson(_$RangeDtoImpl instance) =>
    <String, dynamic>{
      'min': instance.min,
      'isMinExclusive': instance.isMinExclusive,
      'max': instance.max,
      'isMaxExclusive': instance.isMaxExclusive,
      'unit': instance.unit,
    };

_$ClinicalVariableDtoImpl _$$ClinicalVariableDtoImplFromJson(
  Map<String, dynamic> json,
) => _$ClinicalVariableDtoImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String? ?? '',
  code: json['code'] as String,
  valueType: json['valueType'] as String,
  canonicalUnit: json['canonicalUnit'] as String?,
  isRequired: json['isRequired'] as bool? ?? false,
  category: json['category'] as String,
  acceptedValues:
      (json['acceptedValues'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  normalRange: json['normalRange'] == null
      ? null
      : RangeDto.fromJson(json['normalRange'] as Map<String, dynamic>),
  acceptedRange: json['acceptedRange'] == null
      ? null
      : RangeDto.fromJson(json['acceptedRange'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$ClinicalVariableDtoImplToJson(
  _$ClinicalVariableDtoImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'code': instance.code,
  'valueType': instance.valueType,
  'canonicalUnit': instance.canonicalUnit,
  'isRequired': instance.isRequired,
  'category': instance.category,
  'acceptedValues': instance.acceptedValues,
  'normalRange': instance.normalRange,
  'acceptedRange': instance.acceptedRange,
};

_$DiagnosisFormDtoImpl _$$DiagnosisFormDtoImplFromJson(
  Map<String, dynamic> json,
) => _$DiagnosisFormDtoImpl(
  variables:
      (json['variables'] as List<dynamic>?)
          ?.map((e) => ClinicalVariableDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$$DiagnosisFormDtoImplToJson(
  _$DiagnosisFormDtoImpl instance,
) => <String, dynamic>{'variables': instance.variables};

_$NamedRefDtoImpl _$$NamedRefDtoImplFromJson(Map<String, dynamic> json) =>
    _$NamedRefDtoImpl(id: json['id'] as String, name: json['name'] as String);

Map<String, dynamic> _$$NamedRefDtoImplToJson(_$NamedRefDtoImpl instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};

_$VariableRefDtoImpl _$$VariableRefDtoImplFromJson(Map<String, dynamic> json) =>
    _$VariableRefDtoImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      code: json['code'] as String? ?? '',
    );

Map<String, dynamic> _$$VariableRefDtoImplToJson(
  _$VariableRefDtoImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'code': instance.code,
};

_$EvidenceDtoImpl _$$EvidenceDtoImplFromJson(Map<String, dynamic> json) =>
    _$EvidenceDtoImpl(
      source: json['source'] as String? ?? '',
      formula: json['formula'] as String? ?? '',
      evaluatedValue: json['evaluatedValue'],
      score: json['score'] as num?,
      isMajor: json['isMajor'] as bool?,
      missingVariables:
          (json['missingVariables'] as List<dynamic>?)
              ?.map((e) => VariableRefDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$EvidenceDtoImplToJson(_$EvidenceDtoImpl instance) =>
    <String, dynamic>{
      'source': instance.source,
      'formula': instance.formula,
      'evaluatedValue': instance.evaluatedValue,
      'score': instance.score,
      'isMajor': instance.isMajor,
      'missingVariables': instance.missingVariables,
    };

_$DiagnoseResultDtoImpl _$$DiagnoseResultDtoImplFromJson(
  Map<String, dynamic> json,
) => _$DiagnoseResultDtoImpl(
  severity: json['severity'] as String,
  treatmentSite: json['treatmentSite'] as String,
  worthSuspected:
      (json['worthSuspected'] as List<dynamic>?)
          ?.map((e) => NamedRefDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  heavySuspected:
      (json['heavySuspected'] as List<dynamic>?)
          ?.map((e) => NamedRefDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  evidences:
      (json['evidences'] as List<dynamic>?)
          ?.map((e) => EvidenceDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  missingVariables:
      (json['missingVariables'] as List<dynamic>?)
          ?.map((e) => VariableRefDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  allergies:
      (json['allergies'] as List<dynamic>?)
          ?.map((e) => NamedRefDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  isPatientPregnantOrInLactationPhase:
      json['isPatientPregnantOrInLactationPhase'] as bool? ?? false,
);

Map<String, dynamic> _$$DiagnoseResultDtoImplToJson(
  _$DiagnoseResultDtoImpl instance,
) => <String, dynamic>{
  'severity': instance.severity,
  'treatmentSite': instance.treatmentSite,
  'worthSuspected': instance.worthSuspected,
  'heavySuspected': instance.heavySuspected,
  'evidences': instance.evidences,
  'missingVariables': instance.missingVariables,
  'allergies': instance.allergies,
  'isPatientPregnantOrInLactationPhase':
      instance.isPatientPregnantOrInLactationPhase,
};

_$PathogenItemDtoImpl _$$PathogenItemDtoImplFromJson(
  Map<String, dynamic> json,
) => _$PathogenItemDtoImpl(
  id: json['id'] as String,
  name: json['name'] as String,
);

Map<String, dynamic> _$$PathogenItemDtoImplToJson(
  _$PathogenItemDtoImpl instance,
) => <String, dynamic>{'id': instance.id, 'name': instance.name};

_$AntibioticResultDtoImpl _$$AntibioticResultDtoImplFromJson(
  Map<String, dynamic> json,
) => _$AntibioticResultDtoImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  antibioticGroupName: json['antibioticGroupName'] as String? ?? '',
  classification: json['classification'] as String? ?? '',
  dosages:
      (json['dosages'] as List<dynamic>?)
          ?.map((e) => DosageDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$$AntibioticResultDtoImplToJson(
  _$AntibioticResultDtoImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'antibioticGroupName': instance.antibioticGroupName,
  'classification': instance.classification,
  'dosages': instance.dosages,
};

_$DosageDtoImpl _$$DosageDtoImplFromJson(Map<String, dynamic> json) =>
    _$DosageDtoImpl(
      routeOfAdministration: json['routeOfAdministration'] as String,
      dose: json['dose'] as String,
    );

Map<String, dynamic> _$$DosageDtoImplToJson(_$DosageDtoImpl instance) =>
    <String, dynamic>{
      'routeOfAdministration': instance.routeOfAdministration,
      'dose': instance.dose,
    };

_$TargetedDiagnoseResultDtoImpl _$$TargetedDiagnoseResultDtoImplFromJson(
  Map<String, dynamic> json,
) => _$TargetedDiagnoseResultDtoImpl(
  crcl: (json['crcl'] as num?)?.toDouble() ?? 0,
  recommendations:
      (json['recommendations'] as List<dynamic>?)
          ?.map((e) => AntibioticResultDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$$TargetedDiagnoseResultDtoImplToJson(
  _$TargetedDiagnoseResultDtoImpl instance,
) => <String, dynamic>{
  'crcl': instance.crcl,
  'recommendations': instance.recommendations,
};
