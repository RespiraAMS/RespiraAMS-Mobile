import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';

import 'package:respiraams/core/network/api_client.dart';
import 'package:respiraams/design_system/design_system.dart';
import 'package:respiraams/features/treatment_protocol/providers/treatment_protocol_provider.dart';
import 'package:respiraams/features/treatment_protocol/providers/treatment_protocol_service.dart';
import 'package:respiraams/features/treatment_protocol/screens/treatment_protocol_list_screen.dart';
import 'package:respiraams/l10n/l10n.dart';

import 'helpers/fake_api_adapter.dart';

/// Pumps the protocol lookup screen over the offline adapter so the filter
/// sheet can be exercised without the router/network.
Future<FakeApiAdapter> _pumpScreen(WidgetTester tester) async {
  GoogleFonts.config.allowRuntimeFetching = false;

  // Tall viewport so the whole filter sheet (chips + both checklists) fits
  // and every option is hittable.
  tester.view.physicalSize = const Size(1200, 2800);
  tester.view.devicePixelRatio = 2;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  final adapter = FakeApiAdapter();
  final dio = Dio(BaseOptions(baseUrl: 'http://localhost:5016'))
    ..httpClientAdapter = adapter;
  final provider = TreatmentProtocolProvider(
    TreatmentProtocolRepository(apiClient: ApiClient(dioOverride: dio)),
  );

  await tester.pumpWidget(
    MaterialApp(
      locale: const Locale('vi'),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      theme: lightThemeData,
      home: ChangeNotifierProvider.value(
        value: provider,
        child: const TreatmentProtocolListScreen(),
      ),
    ),
  );
  await _settle(tester);
  return adapter;
}

/// The request is kicked off inside a fake-async frame, so first advance the
/// fake clock (fires Dio's zero-delay timer), then let the adapter's real
/// futures resolve and flush the resulting frames.
Future<void> _settle(WidgetTester tester) async {
  await tester.pump(const Duration(milliseconds: 100));
  await tester.pump(const Duration(milliseconds: 100));
  await tester.runAsync(
    () => Future<void>.delayed(const Duration(milliseconds: 200)),
  );
  await tester.pump();
  await tester.pump();
}

RequestOptions? _lastRequest(FakeApiAdapter adapter, String path) {
  for (final request in adapter.requests.reversed) {
    if (request.path.contains(path)) return request;
  }
  return null;
}

void main() {
  testWidgets('loads the protocol list with the compact filter header', (
    tester,
  ) async {
    await _pumpScreen(tester);

    expect(find.text('Phác đồ điều trị'), findsOneWidget);
    expect(find.byIcon(LucideIcons.listFilter), findsOneWidget);
    // The old always-visible chip rows are gone.
    expect(find.text('Nhẹ'), findsNothing);
    expect(find.text('Ngoại trú'), findsNothing);

    // Card summary from the fixture.
    expect(find.text('Nặng'), findsOneWidget);
    expect(find.text('Nội trú'), findsOneWidget);
  });

  testWidgets('applies severity, site, pathogen and criteria filters', (
    tester,
  ) async {
    final adapter = await _pumpScreen(tester);

    await tester.tap(find.byIcon(LucideIcons.listFilter));
    await _settle(tester);
    await tester.pumpAndSettle();

    expect(find.text('Bộ lọc dữ liệu'), findsOneWidget);
    // Pathogen/criterion options arrive from the mocked lookup endpoints.
    expect(find.text('Klebsiella pneumoniae'), findsOneWidget);
    expect(find.text('CURB-65 ≥ 3'), findsOneWidget);

    // The card summary repeats the same labels, and the sheet lives in the
    // overlay, i.e. after the screen subtree — `last` targets the sheet.
    await tester.tap(find.text('Nặng').last);
    await tester.pump();
    await tester.tap(find.text('Nội trú').last);
    await tester.pump();

    await tester.tap(find.text('Klebsiella pneumoniae'));
    await tester.pump();
    await tester.tap(find.text('CURB-65 ≥ 3').last);
    await tester.pump();

    await tester.tap(find.text('Áp dụng'));
    await _settle(tester);
    await tester.pumpAndSettle();

    final request = _lastRequest(adapter, '/treatment-protocols');
    expect(request, isNotNull);
    expect(request!.queryParameters['severity'], 'Severe');
    expect(request.queryParameters['treatmentSite'], 'Inpatient');
    expect(
      request.queryParameters['pathogenIds'] as List<dynamic>,
      contains('pathogen-1'),
    );
    expect(
      request.queryParameters['criteriaIds'] as List<dynamic>,
      contains('criterion-1'),
    );

    // The filter button switches to the active (filled) state.
    final container = tester.widget<Container>(
      find
          .ancestor(
            of: find.byIcon(LucideIcons.listFilter),
            matching: find.byType(Container),
          )
          .first,
    );
    expect(
      (container.decoration as BoxDecoration).color,
      RespiraColors.light.primary,
    );
  });

  testWidgets('filters the loaded pages by pathogen name as the user types', (
    tester,
  ) async {
    await _pumpScreen(tester);

    // Collapsed card summary lists the protocol's pathogens.
    expect(find.text('Streptococcus pneumoniae'), findsOneWidget);

    // The fixture's only protocol lists S. pneumoniae, so Klebsiella must not
    // match. The search runs 300ms after the keystroke.
    await tester.enterText(find.byType(TextField).first, 'klebsiella');
    await tester.pump(const Duration(milliseconds: 350));
    await tester.pump();
    expect(find.text('Không tìm thấy kết quả nào.'), findsOneWidget);

    // A matching antibiotic name brings the card back.
    await tester.enterText(find.byType(TextField).first, 'meropenem');
    await tester.pump(const Duration(milliseconds: 350));
    await tester.pump();
    expect(find.text('Streptococcus pneumoniae'), findsOneWidget);
  });
}
