import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:respiraams/core/network/api_client.dart';
import 'package:respiraams/features/statistics/models/statistics_view.dart';
import 'package:respiraams/features/statistics/providers/statistics_provider.dart';

import 'helpers/fake_api_adapter.dart';
import 'helpers/pump_test_app.dart';

Future<void> _settleNavigation(WidgetTester tester) async {
  await tester.pump(const Duration(milliseconds: 400));
  await tester.pump(const Duration(milliseconds: 400));
}

/// Statistics tests: overview built from the real roster + analysis report,
/// period switching and bottom-nav navigation both ways.

Future<FakeApiAdapter> _pumpStatistics(WidgetTester tester) =>
    pumpTestApp(tester, initialLocation: '/statistics');

List<String?> _createdFromQueries(FakeApiAdapter adapter) => [
      for (final request in adapter.requests)
        if (request.path.contains('/analysis/reports'))
          request.queryParameters['createdFrom'] as String?,
    ];

void main() {
  testWidgets('renders the overview from the patient roster', (tester) async {
    await _pumpStatistics(tester);
    await settleApi(tester);
    await tester.pumpAndSettle();

    expect(find.text('Tổng quan hoạt động điều trị'), findsOneWidget);

    // KPIs are computed from the two patients of the roster fixture.
    expect(find.text('Tổng bệnh nhân'), findsOneWidget);
    // Also the outcome breakdown row below.
    expect(find.text('Đang điều trị'), findsWidgets);
    expect(find.text('Đã khỏi'), findsWidgets);
    expect(find.text('2'), findsWidgets);

    // Distributions replace the old hardcoded chart / pathogen ranking.
    expect(find.text('Phân bố nhóm tuổi'), findsOneWidget);
    expect(find.text('Ca theo kết cục điều trị'), findsOneWidget);

    // No analysis report fixture → the empty message, not demo numbers.
    expect(find.text('Báo cáo gần nhất'), findsOneWidget);
    expect(
      find.text('Chưa có báo cáo phân tích trong kỳ này.'),
      findsOneWidget,
    );
  });

  test('switching the period re-queries the analysis report', () async {
    final adapter = FakeApiAdapter();
    final dio = Dio(BaseOptions(baseUrl: 'http://localhost:5016'))
      ..httpClientAdapter = adapter;
    final container = ProviderContainer(
      overrides: [apiClientProvider.overrideWithValue(dio)],
    );
    addTearDown(container.dispose);

    await container.read(statisticsViewProvider.future);
    final first = _createdFromQueries(adapter);
    expect(first, hasLength(1));

    container
        .read(statisticsPeriodControllerProvider.notifier)
        .setPeriod(PeriodRange.thisQuarter);
    await container.read(statisticsViewProvider.future);

    final queries = _createdFromQueries(adapter);
    expect(queries, hasLength(2));
    expect(queries.last, isNot(first.single));
  });

  testWidgets('bottom navigation reaches the patient list and back', (
    tester,
  ) async {
    await _pumpStatistics(tester);
    await settleApi(tester);

    // 'Bệnh nhân' appears once (nav label only — the title says
    // 'Danh sách bệnh nhân' after navigation).
    await tester.tap(find.text('Bệnh nhân'));
    await _settleNavigation(tester);
    expect(find.text('Danh sách bệnh nhân'), findsOneWidget);

    // And back via the statistics tab. The stats screen (title + its own
    // active label) can still be alive below, so target the last match —
    // the list's inactive nav label.
    await tester.tap(find.text('Thống kê').last);
    await _settleNavigation(tester);
    expect(find.text('Tổng quan hoạt động điều trị'), findsOneWidget);
  });
}
