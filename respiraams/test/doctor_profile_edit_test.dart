import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:respiraams/design_system/design_system.dart';
import 'package:respiraams/features/authentication/providers/session_provider.dart';
import 'package:respiraams/features/patient/routes.dart';
import 'package:respiraams/features/settings/settings_menu_button.dart';

import 'helpers/fake_api_adapter.dart';
import 'helpers/pump_test_app.dart';

/// Seeds the session with the account id the `/doctors` fixture links to.
class _SeededSession extends SessionController {
  @override
  DoctorProfile? build() =>
      const DoctorProfile(id: 'account-1', name: 'BS. Lê Hoàng Minh');
}

/// Pumps the app, opens Settings → doctor profile → edit form.
Future<FakeApiAdapter> _openEditForm(
  WidgetTester tester, {
  Map<String, MockedResponse> overrides = const {},
}) async {
  final adapter = await pumpTestApp(
    tester,
    initialLocation: PatientRoutes.list,
    initialPrefs: const {
      'auth.accessToken': 'access-token-1',
      'auth.refreshToken': 'refresh-token-1',
    },
    overrides: {
      // The saga reports `Completed` immediately; the screen still verifies by
      // re-fetching the profile (roster endpoint).
      'GET /profile/update': MockedResponse(
        200,
        FakeApiAdapter.envelope({
          'sagaId': 'saga-1',
          'step': 'Completed',
          'accountId': 'account-1',
          'doctorId': 'doctor-1',
          'mediaId': '00000000-0000-0000-0000-000000000000',
          'failureReason': null,
        }),
      ),
      ...overrides,
    },
    providerOverrides: [
      sessionControllerProvider.overrideWith(_SeededSession.new),
    ],
  );
  await settleApi(tester);

  await tester.tap(find.byType(SettingsMenuButton));
  await tester.pumpAndSettle();
  await tester.tap(find.text('BS. Lê Hoàng Minh'));
  await settleApi(tester);
  await tester.pumpAndSettle();

  await tester.tap(find.text('Cập nhật thông tin'));
  await tester.pumpAndSettle();
  await settleApi(tester);
  return adapter;
}

/// The profile-update request body is multipart: the saga payload travels in
/// the `request` field as JSON.
Map<String, dynamic>? _sentPayload(FakeApiAdapter adapter) {
  for (final request in adapter.requests.reversed) {
    if (request.method != 'POST' || !request.path.contains('/profile/update')) {
      continue;
    }
    final data = request.data;
    if (data is! FormData) return null;
    for (final field in data.fields) {
      if (field.key == 'request') {
        return jsonDecode(field.value) as Map<String, dynamic>;
      }
    }
  }
  return null;
}

/// True when the app rotated the token pair (done after a password change).
bool _refreshedSession(FakeApiAdapter adapter) =>
    adapter.requests.any((request) => request.path.contains('/auth/refresh'));

Future<void> _enter(
  WidgetTester tester,
  String label,
  String value,
) async {
  final finder = find.widgetWithText(AppTextField, label);
  await tester.ensureVisible(finder);
  await tester.pump(const Duration(milliseconds: 100));
  await tester.enterText(finder, value);
  await tester.pump(const Duration(milliseconds: 100));
}

Future<void> _tapSave(WidgetTester tester) async {
  await tester.ensureVisible(find.text('Lưu thay đổi'));
  await tester.pump(const Duration(milliseconds: 200));
  await tester.tap(find.text('Lưu thay đổi'));
  await settleApi(tester);
  await settleApi(tester);
  await settleApi(tester);
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('opens the edit form pre-filled from the profile', (
    tester,
  ) async {
    await _openEditForm(tester);

    expect(find.text('Cập nhật hồ sơ'), findsOneWidget);
    expect(find.text('Nguyễn'), findsWidgets); // last name field
    expect(find.text('Minh'), findsWidgets); // first name field
    expect(find.text('bs.minh@respira.vn'), findsOneWidget);
    expect(find.text('0901234567'), findsOneWidget);
    expect(find.text('12/04/1971'), findsOneWidget);
    expect(find.text('079123456789'), findsOneWidget);
    expect(find.text('Quận 1, TP. Hồ Chí Minh'), findsOneWidget);
    expect(find.text('Bảo mật'), findsOneWidget);
    expect(find.text('Lưu thay đổi'), findsOneWidget);
  });

  testWidgets('saves the full replacement payload through the update saga', (
    tester,
  ) async {
    final adapter = await _openEditForm(
      tester,
      overrides: {
        // Real enum wire values so the degree chips map back and forth.
        // `firstName` matches the edited value so the post-saga verification
        // (which re-fetches the roster) succeeds.
        'GET /doctors': MockedResponse(
          200,
          FakeApiAdapter.doctorsEnvelope(
            FakeApiAdapter.doctorProfile(
              firstName: 'Lan',
              degrees: const ['Master', 'Doctor'],
            ),
          ),
        ),
        'GET /doctors/': MockedResponse(
          200,
          FakeApiAdapter.envelope(
            FakeApiAdapter.doctorProfile(firstName: 'Lan'),
          ),
        ),
      },
    );

    await _enter(tester, 'Tên *', 'Lan');
    await _tapSave(tester);

    expect(find.text('Đã cập nhật hồ sơ bác sĩ.'), findsOneWidget);

    final payload = _sentPayload(adapter);
    expect(payload, isNotNull);
    expect(payload!['firstName'], 'Lan');
    expect(payload['lastName'], 'Nguyễn');
    expect(payload['email'], 'bs.minh@respira.vn');
    expect(payload['phone'], '0901234567');
    expect(payload['doctorId'], 'doctor-1');
    expect(payload['accountId'], 'account-1');
    expect(payload['gender'], 'Male');
    expect(payload['dateOfBirth'], '1971-04-12');
    expect(payload['degrees'], unorderedEquals(['Doctor', 'Master']));
    // No password typed → the field is omitted so the old one is kept.
    expect(payload.containsKey('password'), isFalse);
    // No password change → no token rotation is needed.
    expect(_refreshedSession(adapter), isFalse);
  });

  testWidgets('sends the new password when one is typed', (tester) async {
    final adapter = await _openEditForm(tester);

    await _enter(tester, 'Mật khẩu mới', 'Respira1');
    await _enter(tester, 'Xác nhận mật khẩu', 'Respira1');
    await _tapSave(tester);

    final payload = _sentPayload(adapter);
    expect(payload, isNotNull);
    expect(payload!['password'], 'Respira1');
    // Rotating the tokens clears the auth cache so the new password works
    // immediately (the BE login cache would otherwise keep the old hash).
    expect(_refreshedSession(adapter), isTrue);
  });

  testWidgets('rejects a mismatched password before calling the API', (
    tester,
  ) async {
    final adapter = await _openEditForm(tester);

    await _enter(tester, 'Mật khẩu mới', 'Respira1');
    await _enter(tester, 'Xác nhận mật khẩu', 'Respira2');
    await _tapSave(tester);

    expect(find.text('Mật khẩu xác nhận không khớp.'), findsWidgets);
    expect(_sentPayload(adapter), isNull);
  });
}
