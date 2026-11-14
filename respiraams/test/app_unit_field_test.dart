import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:respiraams/design_system/design_system.dart';
import 'package:respiraams/l10n/l10n.dart';

Future<void> _pumpField(
  WidgetTester tester, {
  required bool expanded,
}) async {
  GoogleFonts.config.allowRuntimeFetching = false;

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
      home: Scaffold(
        body: Center(
          child: SizedBox(
            width: 400,
            child: AppUnitField(
              label: 'Chiều cao',
              unit: 'cm',
              initialValue: '170',
              expanded: expanded,
              onChanged: (_) {},
            ),
          ),
        ),
      ),
    ),
  );
  await tester.pump();
}

/// The input box is the nearest [Container] ancestor of the [TextField].
double _inputBoxWidth(WidgetTester tester) => tester
    .getSize(
      find
          .ancestor(of: find.byType(TextField), matching: find.byType(Container))
          .first,
    )
    .width;

void main() {
  testWidgets('expanded unit fields take about half of the row', (
    tester,
  ) async {
    await _pumpField(tester, expanded: true);

    // Label ~half + input ~half of the 400px row.
    expect(_inputBoxWidth(tester), greaterThan(180));
  });

  testWidgets('the default unit field keeps its compact 144px input', (
    tester,
  ) async {
    await _pumpField(tester, expanded: false);

    expect(_inputBoxWidth(tester), 144);
  });

  testWidgets('long labels wrap instead of being truncated', (tester) async {
    GoogleFonts.config.allowRuntimeFetching = false;

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
        home: Scaffold(
          body: Center(
            child: SizedBox(
              width: 360,
              child: AppUnitField(
                label: 'Cân nặng của bệnh nhân khi nhập viện (đo lần đầu)',
                description: 'Ghi nhận theo cân nặng thực tế đã đo tại khoa.',
                unit: 'kg',
                onChanged: (_) {},
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pump();

    final label = tester.widget<Text>(
      find.text('Cân nặng của bệnh nhân khi nhập viện (đo lần đầu)'),
    );
    expect(label.maxLines, isNull);
    expect(label.overflow, isNot(TextOverflow.ellipsis));
  });
}
