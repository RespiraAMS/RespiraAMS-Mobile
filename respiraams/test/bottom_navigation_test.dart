import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lucide_icons/lucide_icons.dart';

import 'package:respiraams/design_system/design_system.dart';

/// Bottom navigation must survive narrow phones (Galaxy A34, 360–390dp) at the
/// largest in-app text preset and at the OS accessibility scale.
const _viItems = [
  AppBottomNavItem(icon: LucideIcons.users, label: 'Bệnh nhân'),
  AppBottomNavItem(icon: LucideIcons.search, label: 'Tra cứu'),
  AppBottomNavItem(icon: LucideIcons.stethoscope, label: 'Chẩn đoán'),
  AppBottomNavItem(icon: LucideIcons.calculator, label: 'Máy tính'),
  AppBottomNavItem(icon: LucideIcons.barChart2, label: 'Thống kê'),
];

const _enItems = [
  AppBottomNavItem(icon: LucideIcons.users, label: 'Patients'),
  AppBottomNavItem(icon: LucideIcons.search, label: 'Lookup'),
  AppBottomNavItem(icon: LucideIcons.stethoscope, label: 'Diagnosis'),
  AppBottomNavItem(icon: LucideIcons.calculator, label: 'Calculators'),
  AppBottomNavItem(icon: LucideIcons.barChart2, label: 'Statistics'),
];

Future<void> _pumpBar(
  WidgetTester tester, {
  required List<AppBottomNavItem> items,
  required double textScale,
  double width = 360,
}) async {
  tester.view.physicalSize = Size(width * 3, 800 * 3);
  tester.view.devicePixelRatio = 3;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(
    MaterialApp(
      theme: lightThemeData,
      home: Builder(
        builder: (context) => MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.linear(textScale),
          ),
          child: Scaffold(
            // Mirrors the 16dp screen padding used by the workspace tabs.
            body: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: AppBottomNavigation(
                  items: items,
                  activeIndex: 0,
                  onTap: (_) {},
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

void main() {
  testWidgets('keeps the Vietnamese labels inside a 360dp phone at 1.15×', (
    tester,
  ) async {
    await _pumpBar(tester, items: _viItems, textScale: 1.15);

    expect(tester.takeException(), isNull);
    for (final item in _viItems) {
      expect(find.text(item.label), findsOneWidget);
    }

    // The bar is inside the 16dp screen padding and its destinations share it.
    final barWidth = tester.getSize(find.byType(AppBottomNavigation)).width;
    expect(barWidth, lessThanOrEqualTo(360 - 32));

    final itemWidths = [
      for (var i = 0; i < _viItems.length; i++)
        tester.getSize(find.byType(InkWell).at(i)).width,
    ];
    expect(itemWidths, hasLength(5));
    for (final width in itemWidths) {
      expect(width, greaterThanOrEqualTo(ControlSize.touchTargetMin));
    }
  });

  testWidgets('fits the longer English labels at the 1.3× clamp', (
    tester,
  ) async {
    await _pumpBar(tester, items: _enItems, textScale: 1.3);

    expect(tester.takeException(), isNull);
    expect(find.text('Calculators'), findsOneWidget);
    expect(find.text('Diagnosis'), findsOneWidget);
  });

  testWidgets('clamps the OS scale so the bar keeps its height', (
    tester,
  ) async {
    await _pumpBar(tester, items: _viItems, textScale: 1.3);
    final clampedHeight = tester.getSize(find.byType(AppBottomNavigation)).height;

    await _pumpBar(tester, items: _viItems, textScale: 2.0);
    expect(tester.takeException(), isNull);

    final scaledHeight = tester.getSize(find.byType(AppBottomNavigation)).height;
    expect(scaledHeight, moreOrLessEquals(clampedHeight, epsilon: 0.5));
  });
}
