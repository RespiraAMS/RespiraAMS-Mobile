// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statistics_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$statisticsViewHash() => r'7dc6a14ffecc06b34d366ba60310254aab55bca4';

/// Overview built from the real endpoints:
/// * `GET /patients` for the roster KPIs plus the age/outcome distributions;
/// * `GET /analysis/reports?createdFrom=…` for the latest adherence report.
///
/// Copied from [statisticsView].
@ProviderFor(statisticsView)
final statisticsViewProvider = FutureProvider<StatisticsView>.internal(
  statisticsView,
  name: r'statisticsViewProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$statisticsViewHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef StatisticsViewRef = FutureProviderRef<StatisticsView>;
String _$statisticsPeriodControllerHash() =>
    r'279530f4a593ce2e08477b8a4327c14c5cf46cce';

/// Selected overview range of the statistics screen.
///
/// The range only filters the analysis report (the roster endpoint has no date
/// filter); the patient KPIs are lifetime totals.
///
/// Copied from [StatisticsPeriodController].
@ProviderFor(StatisticsPeriodController)
final statisticsPeriodControllerProvider =
    NotifierProvider<StatisticsPeriodController, PeriodRange>.internal(
      StatisticsPeriodController.new,
      name: r'statisticsPeriodControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$statisticsPeriodControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$StatisticsPeriodController = Notifier<PeriodRange>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
