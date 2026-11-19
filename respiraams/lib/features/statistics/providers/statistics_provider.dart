import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/api_client.dart';
import '../../analysis/services/analysis_service.dart';
import '../../patient/models/patient_dtos.dart';
import '../../patient/services/patient_service.dart';
import '../models/statistics_view.dart';

part 'statistics_provider.g.dart';

/// Selected overview range of the statistics screen.
///
/// The range only filters the analysis report (the roster endpoint has no date
/// filter); the patient KPIs are lifetime totals.
@Riverpod(keepAlive: true)
class StatisticsPeriodController extends _$StatisticsPeriodController {
  @override
  PeriodRange build() => PeriodRange.last30Days;

  void setPeriod(PeriodRange period) => state = period;
}

/// Roster pages are walked to the last page, capped so a misbehaving backend
/// cannot loop forever.
const _pageSize = 100;
const _maxPages = 10;

/// Overview built from the real endpoints:
/// * `GET /patients` for the roster KPIs plus the age/outcome distributions;
/// * `GET /analysis/reports?createdFrom=…` for the latest adherence report.
@Riverpod(keepAlive: true)
Future<StatisticsView> statisticsView(StatisticsViewRef ref) async {
  final period = ref.watch(statisticsPeriodControllerProvider);
  final client = ref.watch(apiClientProvider);

  final totals = await _loadPatients(PatientService(client));
  final report = await _loadLatestReport(
    AnalysisService(client),
    createdFrom: _periodStart(period),
  );

  return StatisticsView(
    kpis: [
      KpiStat(id: KpiId.patients, value: totals.total),
      KpiStat(
        id: KpiId.inTreatment,
        value: totals.byOutcome['InTreatment'] ?? 0,
      ),
      KpiStat(
        id: KpiId.recovered,
        value: totals.byOutcome['Recovered'] ?? 0,
      ),
    ],
    ageBars: [
      for (final band in _ageBands)
        DistributionBar(label: band, value: totals.byAge[band] ?? 0),
    ],
    outcomes: [
      for (var i = 0; i < _outcomeKeys.length; i++)
        if ((totals.byOutcome[_outcomeKeys[i]] ?? 0) > 0)
          BreakdownStat(
            key: _outcomeKeys[i],
            count: totals.byOutcome[_outcomeKeys[i]]!,
            rank: i,
          ),
    ],
    latestReport: report,
  );
}

const _ageBands = ['<18', '18–39', '40–64', '65+'];
const _outcomeKeys = ['InTreatment', 'Recovered', 'Death', 'OutOfScope'];

class _PatientTotals {
  const _PatientTotals({
    required this.total,
    required this.byOutcome,
    required this.byAge,
  });

  final int total;
  final Map<String, int> byOutcome;
  final Map<String, int> byAge;
}

Future<_PatientTotals> _loadPatients(PatientService service) async {
  var page = 1;
  var total = 0;
  final byOutcome = <String, int>{};
  final byAge = <String, int>{};

  while (page <= _maxPages) {
    final paged = await service.getPatients(page: page, size: _pageSize);
    total = paged.metadata.totalItemCount;

    for (final item in paged.items) {
      final outcome = _outcomeKey(item.treatmentOutcome);
      byOutcome.update(outcome, (value) => value + 1, ifAbsent: () => 1);

      final band = _ageBand(item.age);
      byAge.update(band, (value) => value + 1, ifAbsent: () => 1);
    }

    if (!paged.metadata.hasNextPage) break;
    page++;
  }

  return _PatientTotals(total: total, byOutcome: byOutcome, byAge: byAge);
}

Future<LatestReport?> _loadLatestReport(
  AnalysisService service, {
  required DateTime createdFrom,
}) async {
  try {
    final paged = await service.getReports(
      page: 1,
      size: 1,
      createdFrom: createdFrom,
    );
    if (paged.items.isEmpty) return null;

    final item = paged.items.first;
    return LatestReport(
      analysisId: item.analysisId,
      totalTreatmentPlans: item.totalTreatmentPlans,
      totalPatients: item.totalPatients,
      totalAdherentPlans: item.totalAdherentPlans,
      totalNonAdherentPlans: item.totalNonAdherentPlans,
      totalPendingReviewPlans: item.totalPendingReviewPlans,
    );
  } catch (_) {
    // A missing/failed report must not take the whole overview down.
    return null;
  }
}

DateTime _periodStart(PeriodRange period) {
  final now = DateTime.now();
  return switch (period) {
    PeriodRange.last30Days => now.subtract(const Duration(days: 30)),
    PeriodRange.thisQuarter =>
      DateTime(now.year, ((now.month - 1) ~/ 3) * 3 + 1, 1),
    PeriodRange.thisYear => DateTime(now.year, 1, 1),
  };
}

String _ageBand(int age) {
  if (age < 18) return _ageBands[0];
  if (age < 40) return _ageBands[1];
  if (age < 65) return _ageBands[2];
  return _ageBands[3];
}

String _outcomeKey(PatientStatusDto status) => switch (status) {
      PatientStatusDto.inTreatment => 'InTreatment',
      PatientStatusDto.recovered => 'Recovered',
      PatientStatusDto.death => 'Death',
      PatientStatusDto.outOfScope => 'OutOfScope',
    };
