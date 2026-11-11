import 'package:flutter_test/flutter_test.dart';
import 'package:lucide_icons/lucide_icons.dart';

import 'package:respiraams/design_system/design_system.dart';
import 'package:respiraams/features/authentication/providers/session_provider.dart';
import 'package:respiraams/features/authentication/screens/doctor_profile_screen.dart';
import 'package:respiraams/features/patient/routes.dart';
import 'package:respiraams/features/settings/settings_menu_button.dart';
import 'package:respiraams/features/settings/settings_sheet.dart';

import 'helpers/fake_api_adapter.dart';
import 'helpers/pump_test_app.dart';

/// Seeds the session with the account id the `/doctors` fixture links to.
class _SeededSession extends SessionController {
  _SeededSession({this.accountId = 'account-1'});

  final String accountId;

  @override
  DoctorProfile? build() =>
      DoctorProfile(id: accountId, name: 'BS. Lê Hoàng Minh');
}

Future<void> _openProfile(
  WidgetTester tester, {
  String accountId = 'account-1',
  Map<String, MockedResponse> overrides = const {},
}) async {
  await pumpTestApp(
    tester,
    initialLocation: PatientRoutes.list,
    overrides: overrides,
    providerOverrides: [
      sessionControllerProvider.overrideWith(
        () => _SeededSession(accountId: accountId),
      ),
    ],
  );
  await settleApi(tester);

  await tester.tap(find.byType(SettingsMenuButton));
  await tester.pumpAndSettle();
  await tester.tap(find.text('BS. Lê Hoàng Minh'));
  await settleApi(tester);
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('opens the doctor profile from the settings name', (
    tester,
  ) async {
    await _openProfile(tester);

    expect(find.byType(SettingsSheet), findsNothing);
    expect(find.byType(DoctorProfileScreen), findsOneWidget);
    expect(find.text('Hồ sơ bác sĩ'), findsOneWidget);

    // Identity block from the enriched roster fixture.
    expect(find.text('Minh Nguyễn'), findsOneWidget);
    expect(find.text('PGS.TS · Trưởng khoa Hô hấp'), findsOneWidget);
    expect(find.text('Chuyên môn'), findsOneWidget);
    expect(find.text('ThS, BS'), findsOneWidget);
    expect(find.text('Bác sĩ'), findsOneWidget);

    expect(find.text('Liên hệ'), findsOneWidget);
    expect(find.text('bs.minh@respira.vn'), findsOneWidget);
    expect(find.text('0901234567'), findsOneWidget);
    expect(find.text('Quận 1, TP. Hồ Chí Minh'), findsOneWidget);

    // The citizen id is masked down to the last four digits.
    expect(find.text('CCCD'), findsOneWidget);
    expect(find.text('•••• 6789'), findsOneWidget);
    expect(find.text('079123456789'), findsNothing);
  });

  testWidgets('back returns to the workspace', (tester) async {
    await _openProfile(tester);

    await tester.tap(find.byIcon(LucideIcons.arrowLeft));
    await tester.pumpAndSettle();

    expect(find.byType(DoctorProfileScreen), findsNothing);
    expect(find.byType(SettingsMenuButton), findsOneWidget);
  });

  testWidgets('shows the error state when the roster fails', (tester) async {
    await _openProfile(
      tester,
      overrides: {
        'GET /doctors': const MockedResponse(500, {
          'statusCode': 'FAILURE',
          'error': {'description': 'boom'},
          'data': null,
        }),
      },
    );

    expect(find.text('Không tải được hồ sơ bác sĩ.'), findsOneWidget);
    expect(find.widgetWithText(AppButton, 'Thử lại'), findsOneWidget);
  });

  testWidgets('shows the empty state when no profile matches the account', (
    tester,
  ) async {
    await _openProfile(tester, accountId: 'account-missing');

    expect(find.text('Chưa có thông tin hồ sơ.'), findsOneWidget);
    expect(find.widgetWithText(AppButton, 'Thử lại'), findsOneWidget);
  });
}
