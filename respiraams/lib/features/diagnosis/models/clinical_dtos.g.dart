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
  clinicalVariables:
      (json['clinicalVariables'] as List<dynamic>?)
          ?.map((e) => ClinicalVariableDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  antibiotics:
      (json['antibiotics'] as List<dynamic>?)
          ?.map((e) => AntibioticFormDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  pathogens:
      (json['pathogens'] as List<dynamic>?)
          ?.map((e) => NamedRefDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$$DiagnosisFormDtoImplToJson(
  _$DiagnosisFormDtoImpl instance,
) => <String, dynamic>{
  'clinicalVariables': instance.clinicalVariables,
  'antibiotics': instance.antibiotics,
  'pathogens': instance.pathogens,
};

_$AntibioticFormDtoImpl _$$AntibioticFormDtoImplFromJson(
  Map<String, dynamic> json,
) => _$AntibioticFormDtoImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  antibioticGroupId: json['antibioticGroupId'] as String? ?? '',
  antibioticGroupName: json['antibioticGroupName'] as String? ?? '',
  classification: json['classification'] as String? ?? '',
);

Map<String, dynamic> _$$AntibioticFormDtoImplToJson(
  _$AntibioticFormDtoImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'antibioticGroupId': instance.antibioticGroupId,
  'antibioticGroupName': instance.antibioticGroupName,
  'classification': instance.classification,
};

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

_$RelatedObservationDtoImpl _$$RelatedObservationDtoImplFromJson(
  Map<String, dynamic> json,
) => _$RelatedObservationDtoImpl(
  variable: json['variable'] == null
      ? null
      : VariableRefDto.fromJson(json['variable'] as Map<String, dynamic>),
  value: json['value'],
);

Map<String, dynamic> _$$RelatedObservationDtoImplToJson(
  _$RelatedObservationDtoImpl instance,
) => <String, dynamic>{'variable': instance.variable, 'value': instance.value};

_$EvidenceDtoImpl _$$EvidenceDtoImplFromJson(Map<String, dynamic> json) =>
    _$EvidenceDtoImpl(
      source: json['source'] as String? ?? '',
      formula: json['formula'] as String? ?? '',
      relatedObservations:
          (json['relatedObservations'] as List<dynamic>?)
              ?.map(
                (e) =>
                    RelatedObservationDto.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
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
      'relatedObservations': instance.relatedObservations,
      'evaluatedValue': instance.evaluatedValue,
      'score': instance.score,
      'isMajor': instance.isMajor,
      'missingVariables': instance.missingVariables,
    };

_$MetricsSeverityDtoImpl _$$MetricsSeverityDtoImplFromJson(
  Map<String, dynamic> json,
) => _$MetricsSeverityDtoImpl(
  code: json['code'] as String? ?? '',
  severity: json['severity'] as String? ?? '',
  treatmentSite: json['treatmentSite'] as String? ?? '',
  evidences:
      (json['evidences'] as List<dynamic>?)
          ?.map((e) => EvidenceDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  score: (json['score'] as num?)?.toInt(),
  majorMatched: (json['majorMatched'] as num?)?.toInt(),
  minorMatched: (json['minorMatched'] as num?)?.toInt(),
);

Map<String, dynamic> _$$MetricsSeverityDtoImplToJson(
  _$MetricsSeverityDtoImpl instance,
) => <String, dynamic>{
  'code': instance.code,
  'severity': instance.severity,
  'treatmentSite': instance.treatmentSite,
  'evidences': instance.evidences,
  'score': instance.score,
  'majorMatched': instance.majorMatched,
  'minorMatched': instance.minorMatched,
};

_$MicrobialTestResultDtoImpl _$$MicrobialTestResultDtoImplFromJson(
  Map<String, dynamic> json,
) => _$MicrobialTestResultDtoImpl(
  sampleType: json['sampleType'] as String? ?? '',
  category: json['category'] as String? ?? '',
  pathogen: json['pathogen'] == null
      ? null
      : NamedRefDto.fromJson(json['pathogen'] as Map<String, dynamic>),
  antibiotics:
      (json['antibiotics'] as List<dynamic>?)
          ?.map((e) => AntibioticRefDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$$MicrobialTestResultDtoImplToJson(
  _$MicrobialTestResultDtoImpl instance,
) => <String, dynamic>{
  'sampleType': instance.sampleType,
  'category': instance.category,
  'pathogen': instance.pathogen,
  'antibiotics': instance.antibiotics,
};

_$CriterionRefDtoImpl _$$CriterionRefDtoImplFromJson(
  Map<String, dynamic> json,
) => _$CriterionRefDtoImpl(
  id: json['id'] as String? ?? '',
  name: json['name'] as String? ?? '',
  formula: json['formula'] as String? ?? '',
);

Map<String, dynamic> _$$CriterionRefDtoImplToJson(
  _$CriterionRefDtoImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'formula': instance.formula,
};

_$TreatmentProtocolDtoImpl _$$TreatmentProtocolDtoImplFromJson(
  Map<String, dynamic> json,
) => _$TreatmentProtocolDtoImpl(
  id: json['id'] as String? ?? '',
  severity: json['severity'] as String? ?? '',
  treatmentSite: json['treatmentSite'] as String? ?? '',
  medicines:
      (json['medicines'] as List<dynamic>?)
          ?.map(
            (e) => (e as List<dynamic>)
                .map(
                  (e) => AntibioticRefDto.fromJson(e as Map<String, dynamic>),
                )
                .toList(),
          )
          .toList() ??
      const [],
  pathogens:
      (json['pathogens'] as List<dynamic>?)
          ?.map((e) => NamedRefDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  criteria:
      (json['criteria'] as List<dynamic>?)
          ?.map((e) => CriterionRefDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$$TreatmentProtocolDtoImplToJson(
  _$TreatmentProtocolDtoImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'severity': instance.severity,
  'treatmentSite': instance.treatmentSite,
  'medicines': instance.medicines,
  'pathogens': instance.pathogens,
  'criteria': instance.criteria,
};

_$DiagnoseResultDtoImpl _$$DiagnoseResultDtoImplFromJson(
  Map<String, dynamic> json,
) => _$DiagnoseResultDtoImpl(
  diagnosisId: json['diagnosisId'] as String? ?? '',
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
  isPatientPregnantOrInLactationPhase:
      json['isPatientPregnantOrInLactationPhase'] as bool? ?? false,
  egfr: (json['egfr'] as num?)?.toDouble(),
  otherInfections:
      (json['otherInfections'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  allergy: json['allergy'] == null
      ? null
      : AllergyResultDto.fromJson(json['allergy'] as Map<String, dynamic>),
  metricsSeverityDiagnosis:
      (json['metricsSeverityDiagnosis'] as List<dynamic>?)
          ?.map((e) => MetricsSeverityDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  microbialTestResults:
      (json['microbialTestResults'] as List<dynamic>?)
          ?.map(
            (e) => MicrobialTestResultDto.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
  protocols:
      (json['protocols'] as List<dynamic>?)
          ?.map((e) => TreatmentProtocolDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$$DiagnoseResultDtoImplToJson(
  _$DiagnoseResultDtoImpl instance,
) => <String, dynamic>{
  'diagnosisId': instance.diagnosisId,
  'severity': instance.severity,
  'treatmentSite': instance.treatmentSite,
  'worthSuspected': instance.worthSuspected,
  'heavySuspected': instance.heavySuspected,
  'evidences': instance.evidences,
  'missingVariables': instance.missingVariables,
  'isPatientPregnantOrInLactationPhase':
      instance.isPatientPregnantOrInLactationPhase,
  'egfr': instance.egfr,
  'otherInfections': instance.otherInfections,
  'allergy': instance.allergy,
  'metricsSeverityDiagnosis': instance.metricsSeverityDiagnosis,
  'microbialTestResults': instance.microbialTestResults,
  'protocols': instance.protocols,
};

_$AntibioticRefDtoImpl _$$AntibioticRefDtoImplFromJson(
  Map<String, dynamic> json,
) => _$AntibioticRefDtoImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  classification: json['classification'] as String? ?? '',
);

Map<String, dynamic> _$$AntibioticRefDtoImplToJson(
  _$AntibioticRefDtoImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'classification': instance.classification,
};

_$AllergyResultDtoImpl _$$AllergyResultDtoImplFromJson(
  Map<String, dynamic> json,
) => _$AllergyResultDtoImpl(
  type: json['type'] as String? ?? 'Unknown',
  allergicAntibiotics:
      (json['allergicAntibiotics'] as List<dynamic>?)
          ?.map((e) => AntibioticRefDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  otherAllergy: json['otherAllergy'] as String?,
);

Map<String, dynamic> _$$AllergyResultDtoImplToJson(
  _$AllergyResultDtoImpl instance,
) => <String, dynamic>{
  'type': instance.type,
  'allergicAntibiotics': instance.allergicAntibiotics,
  'otherAllergy': instance.otherAllergy,
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
      id: json['id'] as String? ?? '',
      routeOfAdministration: json['routeOfAdministration'] as String,
      dose: json['dose'] as String,
      crcl: json['crcl'] == null
          ? null
          : RangeDto.fromJson(json['crcl'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$DosageDtoImplToJson(_$DosageDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'routeOfAdministration': instance.routeOfAdministration,
      'dose': instance.dose,
      'crcl': instance.crcl,
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
