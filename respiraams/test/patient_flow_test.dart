import 'package:flutter_test/flutter_test.dart';

import 'package:respiraams/design_system/design_system.dart';
import 'package:respiraams/features/patient/routes.dart';

import 'helpers/pump_test_app.dart';

/// Clinical patient-flow tests (ft/patient branch): add → detail → progress.

Future<void> _pumpAt(WidgetTester tester, String initialLocation) =>
    pumpTestApp(tester, initialLocation: initialLocation);

Future<void> _settleNavigation(WidgetTester tester) async {
  await tester.pump(const Duration(milliseconds: 400));
  await tester.pump(const Duration(milliseconds: 400));
}

Future<void> _enter(
    WidgetTester tester, Type field, String label, String value) async {
  await tester.ensureVisible(find.widgetWithText(field, label));
  await tester.pump(const Duration(milliseconds: 100));
  await tester.enterText(find.widgetWithText(field, label), value);
  await tester.pump(const Duration(milliseconds: 100));
}

/// Fills every field the client-side validation requires.
Future<void> _fillAddPatientForm(
  WidgetTester tester, {
  String lastName = 'Nguyễn Minh',
  String firstName = 'Khôi',
}) async {
  await _enter(tester, AppTextField, 'Họ', lastName);
  await _enter(tester, AppTextField, 'Tên', firstName);
  await _enter(tester, AppTextField, 'Mã bệnh án', 'BA-2026-9001');
  await _enter(tester, AppTextField, 'Ngày sinh', '12/04/1971');
  await _enter(tester, AppTextField, 'Số thẻ BHYT', '0123456789');
  await _enter(tester, AppTextField, 'Số điện thoại', '0900000000');
  await _enter(tester, AppUnitField, 'Chiều cao', '170');
  await _enter(tester, AppUnitField, 'Cân nặng', '65');
  await _enter(tester, AppTextField, 'Địa chỉ', 'Cần Thơ');
  await _enter(tester, AppTextField, 'Tỉnh/Thành phố', 'Cần Thơ');
}

Future<void> _tapSave(WidgetTester tester) async {
  await tester.ensureVisible(find.text('Lưu hồ sơ'));
  await tester.pump(const Duration(milliseconds: 200));
  await tester.tap(find.text('Lưu hồ sơ'));
  // POST /patients is async now — wait for it, then for navigation.
  await tester.pump(const Duration(milliseconds: 600));
  await _settleNavigation(tester);
}

void main() {
  testWidgets('renders the add patient screen', (tester) async {
    await _pumpAt(tester, PatientRoutes.addPatient);

    expect(find.text('Thêm bệnh nhân'), findsOneWidget);
    expect(find.text('Tạo hồ sơ bệnh nhân mới'), findsOneWidget);
    expect(find.text('Lưu hồ sơ'), findsOneWidget);
    expect(find.text('Họ'), findsOneWidget);
    expect(find.text('Tên'), findsOneWidget);
  });

  testWidgets('submitting the form navigates to patient detail',
      (tester) async {
    await _pumpAt(tester, PatientRoutes.addPatient);

    await _fillAddPatientForm(tester);
    await _tapSave(tester);

    expect(find.text('Chi tiết bệnh nhân'), findsOneWidget);
    // The form route was replaced, so the name now appears only in the
    // detail header.
    expect(find.text('Nguyễn Minh Khôi'), findsWidgets);
    expect(find.text('Tiến trình điều trị'), findsOneWidget);
  });

  testWidgets('detail actions share a single row', (tester) async {
    await pumpTestApp(
      tester,
      initialLocation: '${PatientRoutes.detail}?id=patient-BA-2026-0001',
    );
    await settleApi(tester);
    await tester.pumpAndSettle();

    // "Thêm điều trị" (left) and "Xuất viện" (right) sit on the same row.
    final addRect = tester.getRect(find.text('Thêm điều trị'));
    final dischargeRect = tester.getRect(find.text('Xuất viện'));
    expect(addRect.center.dy, closeTo(dischargeRect.center.dy, 1));
    expect(addRect.center.dx, lessThan(dischargeRect.center.dx));
  });

  testWidgets('detail action opens the diagnosis wizard directly', (
    tester,
  ) async {
    await _pumpAt(tester, PatientRoutes.addPatient);

    await _fillAddPatientForm(tester);
    await _tapSave(tester);

    // Bottom-pinned actions may be below the fold on the test surface.
    await tester.ensureVisible(find.text('Thêm điều trị'));
    await tester.pump(const Duration(milliseconds: 200));

    await tester.tap(find.text('Thêm điều trị'));
    await _settleNavigation(tester);
    await settleApi(tester);
    await settleApi(tester);

    // "Thêm điều trị" goes straight to the wizard (no "Thêm diễn biến").
    expect(find.text('Chẩn đoán kinh nghiệm'), findsOneWidget);
    expect(
      find.text('Bước 1/5 · Đánh giá mức độ & nhiễm khuẩn'),
      findsOneWidget,
    );
    expect(find.text('Thêm diễn biến'), findsNothing);
  });

  testWidgets(
      'Chẩn đoán nav tab: create patient then go straight to the wizard', (
    tester,
  ) async {
    await _pumpAt(tester, PatientRoutes.list);

    // 'Chẩn đoán' appears only as the nav label on the list screen.
    await tester.tap(find.text('Chẩn đoán'));
    await _settleNavigation(tester);

    expect(find.text('Thêm bệnh nhân'), findsOneWidget);

    // Fill in a distinguishable patient and save.
    await _fillAddPatientForm(tester, firstName: 'Mới');
    await _tapSave(tester);
    await settleApi(tester);
    await settleApi(tester);

    // Straight into the diagnosis wizard for the just-created patient
    // (active-patient propagation), skipping the old progress page.
    expect(find.text('Chẩn đoán kinh nghiệm'), findsOneWidget);
    expect(
      find.text('Bước 1/5 · Đánh giá mức độ & nhiễm khuẩn'),
      findsOneWidget,
    );
    expect(find.text('Thêm diễn biến'), findsNothing);
  });
}
