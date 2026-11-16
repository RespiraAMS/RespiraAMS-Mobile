import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:respiraams/features/patient/routes.dart';
import 'package:respiraams/features/settings/settings_menu_button.dart';

import 'helpers/pump_test_app.dart';

Locale? _appLocale(WidgetTester tester) =>
    tester.widget<MaterialApp>(find.byType(MaterialApp)).locale;

void main() {
  group('default language', () {
    testWidgets('starts in Vietnamese when nothing is stored', (tester) async {
      await pumpTestApp(tester, initialLocation: PatientRoutes.list);
      await settleApi(tester);

      expect(_appLocale(tester), const Locale('vi'));
      expect(find.text('Danh sách bệnh nhân'), findsOneWidget);
      expect(find.textContaining('Tất cả'), findsOneWidget);
    });
  });

  group('English locale', () {
    testWidgets('renders the patient roster in English', (tester) async {
      await pumpTestApp(
        tester,
        initialLocation: PatientRoutes.list,
        initialPrefs: const {'settings.language': 'en'},
      );
      await settleApi(tester);

      expect(_appLocale(tester), const Locale('en'));
      expect(find.text('Patients'), findsWidgets);
      expect(find.textContaining('All'), findsOneWidget);
      expect(find.text('Search by name or medical record code'), findsOneWidget);
      expect(find.text('Danh sách bệnh nhân'), findsNothing);
    });

    testWidgets('keeps the dd/MM/yyyy date format in English', (tester) async {
      await pumpTestApp(
        tester,
        initialLocation: PatientRoutes.addPatient,
        initialPrefs: const {'settings.language': 'en'},
      );

      expect(_appLocale(tester), const Locale('en'));
      expect(find.text('Add patient'), findsOneWidget);
      expect(find.text('dd/MM/yyyy'), findsOneWidget);
    });
  });

  group('settings language picker', () {
    testWidgets('switches language immediately and persists the choice', (
      tester,
    ) async {
      await pumpTestApp(tester, initialLocation: PatientRoutes.list);
      await settleApi(tester);

      await tester.tap(find.byType(SettingsMenuButton));
      await tester.pumpAndSettle();

      // Vietnamese settings sheet → open language options.
      expect(find.text('Ngôn ngữ'), findsOneWidget);
      await tester.tap(find.text('Ngôn ngữ'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('English'));
      await tester.pumpAndSettle();

      // The open sheet and the app locale switch without a restart.
      expect(_appLocale(tester), const Locale('en'));
      expect(find.text('Language'), findsOneWidget);
      expect(find.text('Settings'), findsOneWidget);

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString('settings.language'), 'en');

      // Switching back restores Vietnamese.
      await tester.tap(find.text('Language'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Tiếng Việt'));
      await tester.pumpAndSettle();

      expect(_appLocale(tester), const Locale('vi'));
      expect(find.text('Ngôn ngữ'), findsOneWidget);
      expect(prefs.getString('settings.language'), 'vi');
    });
  });

  group('translation resources', () {
    test('vi and en ARB files have matching message keys', () {
      Map<String, dynamic> load(String path) =>
          jsonDecode(File(path).readAsStringSync()) as Map<String, dynamic>;

      final vi = load('lib/l10n/app_vi.arb');
      final en = load('lib/l10n/app_en.arb');

      Set<String> messages(Map<String, dynamic> arb) =>
          arb.keys.where((key) => !key.startsWith('@')).toSet();

      expect(messages(en), equals(messages(vi)));
    });

    test('no translation message is empty', () {
      for (final path in ['lib/l10n/app_vi.arb', 'lib/l10n/app_en.arb']) {
        final arb =
            jsonDecode(File(path).readAsStringSync()) as Map<String, dynamic>;
        for (final entry in arb.entries) {
          if (entry.key.startsWith('@')) continue;
          expect(
            entry.value.toString().trim(),
            isNotEmpty,
            reason: '${entry.key} in $path is empty',
          );
        }
      }
    });
  });
}
