// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statistics_view.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$KpiStatImpl _$$KpiStatImplFromJson(Map<String, dynamic> json) =>
    _$KpiStatImpl(
      id: $enumDecode(_$KpiIdEnumMap, json['id']),
      value: (json['value'] as num).toInt(),
    );

Map<String, dynamic> _$$KpiStatImplToJson(_$KpiStatImpl instance) =>
    <String, dynamic>{
      'id': _$KpiIdEnumMap[instance.id]!,
      'value': instance.value,
    };

const _$KpiIdEnumMap = {
  KpiId.patients: 'patients',
  KpiId.inTreatment: 'inTreatment',
  KpiId.recovered: 'recovered',
};

_$DistributionBarImpl _$$DistributionBarImplFromJson(
  Map<String, dynamic> json,
) => _$DistributionBarImpl(
  label: json['label'] as String,
  value: (json['value'] as num).toInt(),
);

Map<String, dynamic> _$$DistributionBarImplToJson(
  _$DistributionBarImpl instance,
) => <String, dynamic>{'label': instance.label, 'value': instance.value};

_$BreakdownStatImpl _$$BreakdownStatImplFromJson(Map<String, dynamic> json) =>
    _$BreakdownStatImpl(
      key: json['key'] as String,
      count: (json['count'] as num).toInt(),
      rank: (json['rank'] as num).toInt(),
    );

Map<String, dynamic> _$$BreakdownStatImplToJson(_$BreakdownStatImpl instance) =>
    <String, dynamic>{
      'key': instance.key,
      'count': instance.count,
      'rank': instance.rank,
    };

_$LatestReportImpl _$$LatestReportImplFromJson(Map<String, dynamic> json) =>
    _$LatestReportImpl(
      analysisId: json['analysisId'] as String? ?? '',
      totalTreatmentPlans: (json['totalTreatmentPlans'] as num?)?.toInt() ?? 0,
      totalPatients: (json['totalPatients'] as num?)?.toInt() ?? 0,
      totalAdherentPlans: (json['totalAdherentPlans'] as num?)?.toInt() ?? 0,
      totalNonAdherentPlans:
          (json['totalNonAdherentPlans'] as num?)?.toInt() ?? 0,
      totalPendingReviewPlans:
          (json['totalPendingReviewPlans'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$LatestReportImplToJson(_$LatestReportImpl instance) =>
    <String, dynamic>{
      'analysisId': instance.analysisId,
      'totalTreatmentPlans': instance.totalTreatmentPlans,
      'totalPatients': instance.totalPatients,
      'totalAdherentPlans': instance.totalAdherentPlans,
      'totalNonAdherentPlans': instance.totalNonAdherentPlans,
      'totalPendingReviewPlans': instance.totalPendingReviewPlans,
    };

_$StatisticsViewImpl _$$StatisticsViewImplFromJson(Map<String, dynamic> json) =>
    _$StatisticsViewImpl(
      kpis:
          (json['kpis'] as List<dynamic>?)
              ?.map((e) => KpiStat.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      ageBars:
          (json['ageBars'] as List<dynamic>?)
              ?.map((e) => DistributionBar.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      outcomes:
          (json['outcomes'] as List<dynamic>?)
              ?.map((e) => BreakdownStat.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      latestReport: json['latestReport'] == null
          ? null
          : LatestReport.fromJson(json['latestReport'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$StatisticsViewImplToJson(
  _$StatisticsViewImpl instance,
) => <String, dynamic>{
  'kpis': instance.kpis,
  'ageBars': instance.ageBars,
  'outcomes': instance.outcomes,
  'latestReport': instance.latestReport,
};
