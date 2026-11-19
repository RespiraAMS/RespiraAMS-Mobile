import 'package:freezed_annotation/freezed_annotation.dart';

part 'statistics_view.freezed.dart';
part 'statistics_view.g.dart';

/// Overview ranges of the statistics screen. Display labels are provided by
/// `l10n_labels.dart`.
enum PeriodRange { last30Days, thisQuarter, thisYear }

/// Headline KPIs of the statistics screen. Display labels are provided by
/// `l10n_labels.dart`.
enum KpiId { patients, inTreatment, recovered }

/// One headline KPI tile ("Đang điều trị · 24").
@freezed
class KpiStat with _$KpiStat {
  const factory KpiStat({
    required KpiId id,
    required int value,
  }) = _KpiStat;

  factory KpiStat.fromJson(Map<String, dynamic> json) => _$KpiStatFromJson(json);
}

/// One bar of the age-distribution chart. [label] is display-ready
/// (`<18`, `18–39`, `40–64`, `65+`) so it needs no translation.
@freezed
class DistributionBar with _$DistributionBar {
  const factory DistributionBar({
    required String label,
    required int value,
  }) = _DistributionBar;

  factory DistributionBar.fromJson(Map<String, dynamic> json) =>
      _$DistributionBarFromJson(json);
}

/// One row of the outcome breakdown. [key] is the wire value of
/// `TreatmentOutcome`; the screen maps it to a localized label.
@freezed
class BreakdownStat with _$BreakdownStat {
  const factory BreakdownStat({
    required String key,
    required int count,

    /// 0 = most frequent; drives the bar color.
    required int rank,
  }) = _BreakdownStat;

  factory BreakdownStat.fromJson(Map<String, dynamic> json) =>
      _$BreakdownStatFromJson(json);
}

/// Newest analysis report inside the selected period.
@freezed
class LatestReport with _$LatestReport {
  const LatestReport._();

  const factory LatestReport({
    @Default('') String analysisId,
    @Default(0) int totalTreatmentPlans,
    @Default(0) int totalPatients,
    @Default(0) int totalAdherentPlans,
    @Default(0) int totalNonAdherentPlans,
    @Default(0) int totalPendingReviewPlans,
  }) = _LatestReport;

  factory LatestReport.fromJson(Map<String, dynamic> json) =>
      _$LatestReportFromJson(json);

  double get adherenceRate =>
      totalTreatmentPlans <= 0 ? 0 : totalAdherentPlans / totalTreatmentPlans;
}

/// Aggregate view model for one [PeriodRange].
@freezed
class StatisticsView with _$StatisticsView {
  const factory StatisticsView({
    @Default([]) List<KpiStat> kpis,
    @Default([]) List<DistributionBar> ageBars,
    @Default([]) List<BreakdownStat> outcomes,
    LatestReport? latestReport,
  }) = _StatisticsView;

  factory StatisticsView.fromJson(Map<String, dynamic> json) =>
      _$StatisticsViewFromJson(json);
}
