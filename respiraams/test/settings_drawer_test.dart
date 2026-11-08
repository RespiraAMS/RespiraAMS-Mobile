import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:respiraams/core/network/api_client.dart';
import 'package:respiraams/design_system/design_system.dart';
import 'package:respiraams/features/authentication/providers/session_provider.dart';
import 'package:respiraams/features/patient/routes.dart';
import 'package:respiraams/features/settings/providers/app_settings_provider.dart';
import 'package:respiraams/features/settings/settings_menu_button.dart';
import 'package:respiraams/features/settings/settings_sheet.dart';
import 'package:respiraams/l10n/l10n.dart';

import 'helpers/pump_test_app.dart';

/// Seeds the session so the profile card has a name to render.
class _SeededSession extends SessionController {
  @override
  DoctorProfile? build() =>
      const DoctorProfile(id: 'doctor-1', name: 'BS. Lê Hoàng Minh');
}

Future<void> _pumpAndOpen(WidgetTester tester) async {
  await pumpTestApp(
    tester,
    initialLocation: PatientRoutes.list,
    providerOverrides: [
      sessionControllerProvider.overrideWith(_SeededSession.new),
    ],
  );
  await settleApi(tester);

  await tester.tap(find.byType(SettingsMenuButton));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('opens the settings sheet from the header menu button', (
    tester,
  ) async {
    await _pumpAndOpen(tester);

    expect(find.byType(SettingsSheet), findsOneWidget);
    expect(find.text('Cài đặt'), findsOneWidget);
    expect(find.text('Cá nhân hóa trải nghiệm'), findsOneWidget);
    expect(find.text('BS. Lê Hoàng Minh'), findsOneWidget);
    expect(find.text('Chuyên khoa Hô hấp'), findsOneWidget);
    expect(find.text('Giao diện'), findsNWidgets(2));
    expect(find.text('Cỡ chữ'), findsOneWidget);
    expect(find.text('Ngôn ngữ'), findsOneWidget);
    expect(find.text('Đăng xuất'), findsOneWidget);

    // Removed per product decision.
    expect(find.text('Đồng bộ dữ liệu'), findsNothing);
    expect(find.text('Bảo mật'), findsNothing);
    expect(find.text('Khóa ứng dụng'), findsNothing);
  });

  testWidgets('renders edge-to-edge without overflow on a phone surface', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
        child: MaterialApp(
          theme: lightThemeData,
          locale: const Locale('vi'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const Scaffold(
            body: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [SettingsSheet()],
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final size = tester.getSize(find.byType(SettingsSheet));
    expect(size.width, closeTo(351, 0.5));
    expect(size.height, closeTo(844, 0.5));
    expect(tester.takeException(), isNull);
  });

  testWidgets('close button dismisses the sheet', (tester) async {
    await _pumpAndOpen(tester);

    await tester.tap(find.byIcon(LucideIcons.x));
    await tester.pumpAndSettle();

    expect(find.byType(SettingsSheet), findsNothing);
  });

  testWidgets('tapping the barrier dismisses the sheet', (tester) async {
    await _pumpAndOpen(tester);

    // The panel is capped at 400dp, so x=600 is over the barrier.
    await tester.tapAt(const Offset(600, 300));
    await tester.pumpAndSettle();

    expect(find.byType(SettingsSheet), findsNothing);
  });

  testWidgets('theme choice applies app-wide and is persisted', (tester) async {
    await _pumpAndOpen(tester);

    await tester.tap(find.text('Hệ thống'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Tối'));
    await tester.pumpAndSettle();

    final app = tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(app.themeMode, ThemeMode.dark);
    expect(
      Theme.of(tester.element(find.text('Cài đặt'))).brightness,
      Brightness.dark,
    );

    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getString('settings.themeMode'), 'dark');
  });

  testWidgets('font size choice scales text and is persisted', (tester) async {
    await _pumpAndOpen(tester);

    await tester.tap(find.text('Mặc định'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Lớn'));
    await tester.pumpAndSettle();

    final container = ProviderScope.containerOf(
      tester.element(find.byType(SettingsSheet)),
    );
    expect(container.read(appTextScaleControllerProvider), AppTextScale.large);

    final scaler = MediaQuery.textScalerOf(
      tester.element(find.byType(SettingsSheet)),
    );
    expect(scaler.scale(16), greaterThan(16));

    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getString('settings.textScale'), 'large');
  });

  testWidgets('logout confirms, clears the session and returns to login', (
    tester,
  ) async {
    await _pumpAndOpen(tester);

    await tester.tap(find.text('Đăng xuất'));
    await tester.pumpAndSettle();
    expect(find.text('Đăng xuất?'), findsOneWidget);

    await tester.tap(find.text('Đăng xuất').last);
    await tester.pumpAndSettle();

    expect(find.byType(SettingsSheet), findsNothing);
    expect(find.text('Đăng nhập'), findsWidgets);

    final container = ProviderScope.containerOf(
      tester.element(find.text('Đăng nhập').first),
    );
    expect(container.read(sessionControllerProvider), isNull);
  });
}
