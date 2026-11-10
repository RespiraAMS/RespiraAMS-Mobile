import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:respiraams/core/network/api_client.dart';
import 'package:respiraams/core/theme/theme_mode_provider.dart';
import 'package:respiraams/design_system/design_system.dart';
import 'package:respiraams/features/diagnosis/routes.dart';
import 'package:respiraams/features/diagnosis/widgets/selection_row_widget.dart';
import 'package:respiraams/features/patient/models/patient.dart';
import 'package:respiraams/features/patient/providers/active_patient_provider.dart';
import 'package:respiraams/features/patient/routes.dart';

import 'helpers/pump_test_app.dart';

class _SeededActivePatient extends ActivePatientController {
  _SeededActivePatient(this._patient);

  final Patient _patient;

  @override
  Patient? build() => _patient;
}

final _seedPatient = Patient(
  id: 'patient-BA-2026-0231',
  name: 'Nguyễn Minh Khôi',
  code: 'BA-2026-0231',
  dob: '12/04/1971',
  gender: Gender.nam,
  insurance: '0123456789',
  address: 'Cần Thơ',
);

Future<void> _pumpWizard(WidgetTester tester) async {
  await pumpTestApp(
    tester,
    initialLocation: DiagnosisRoutes.wizard,
    providerOverrides: [
      activePatientControllerProvider
          .overrideWith(() => _SeededActivePatient(_seedPatient)),
    ],
  );
  await settleApi(tester);
  await settleApi(tester);
}

Future<void> _settleNavigation(WidgetTester tester) async {
  await tester.pump(const Duration(milliseconds: 400));
  await tester.pump(const Duration(milliseconds: 400));
}

void main() {
  testWidgets('walks the dynamic diagnosis wizard to result + saves treatment',
      (tester) async {
    await _pumpWizard(tester);

    // Step 1/9 · personal information (AGE/GENDER prefilled from patient).
    expect(find.text('Chẩn đoán kinh nghiệm'), findsOneWidget);
    expect(find.text('Bước 1/9 · Thông tin cá nhân'), findsOneWidget);
    expect(find.text('Tuổi'), findsOneWidget);
    await tester.tap(find.text('Tiếp tục'));
    await _settleNavigation(tester);

    // Step 2/9 · clinical numeric (RR required).
    expect(find.text('Bước 2/9 · Chỉ số sinh tồn'), findsOneWidget);
    await tester.enterText(
        find.widgetWithText(AppUnitField, 'Nhịp thở'), '28');
    await tester.pump(const Duration(milliseconds: 100));
    await tester.tap(find.text('Tiếp tục'));
    await _settleNavigation(tester);

    // Step 3/9 · paraclinical numeric (WBC optional).
    expect(find.text('Bước 3/9 · Kết quả xét nghiệm'), findsOneWidget);
    await tester.enterText(
        find.widgetWithText(AppUnitField, 'Bạch cầu'), '12');
    await tester.pump(const Duration(milliseconds: 100));
    await tester.tap(find.text('Tiếp tục'));
    await _settleNavigation(tester);

    // Step 4/9 · medical history (new `MedicalHistory` category).
    expect(find.text('Bước 4/9 · Tiền sử bệnh'), findsOneWidget);
    await tester.tap(find.text('Bệnh thận mạn'));
    await tester.pump(const Duration(milliseconds: 100));
    await tester.tap(find.text('Tiếp tục'));
    await _settleNavigation(tester);

    // Step 5/9 · conditions (booleans).
    expect(find.text('Bước 5/9 · Bệnh nền & nguy cơ'), findsOneWidget);
    await tester.tap(find.text('Lú lẫn mới xuất hiện'));
    await tester.pump(const Duration(milliseconds: 100));
    await tester.tap(find.text('Tiếp tục'));
    await _settleNavigation(tester);

    // Optional contract steps.
    expect(find.text('Bước 6/9 · Bệnh sử đặc biệt'), findsOneWidget);
    await tester.tap(find.text('Tiếp tục'));
    await _settleNavigation(tester);

    expect(find.text('Bước 7/9 · Nhiễm trùng khác'), findsOneWidget);
    await tester.tap(find.text('Tiếp tục'));
    await _settleNavigation(tester);

    expect(find.text('Bước 8/9 · Mẫu xét nghiệm vi sinh'), findsOneWidget);
    await tester.tap(find.text('Tiếp tục'));
    await _settleNavigation(tester);

    // Step 9/9 · allergy (must be explicitly selected).
    expect(find.text('Bước 9/9 · Dị ứng'), findsOneWidget);
    await tester.tap(find.text('Không dị ứng'));
    await tester.pump(const Duration(milliseconds: 100));
    await tester.tap(find.widgetWithText(AppButton, 'Chẩn đoán'));
    await _settleNavigation(tester);
    await settleApi(tester);
    await settleApi(tester);

    // ── Diagnosis result ──────────────────────────────────────────
    expect(find.text('Kết quả chẩn đoán'), findsOneWidget);
    expect(find.text('Nặng'), findsWidgets);
    expect(find.text('Nội trú'), findsWidgets);
    expect(find.text('Nguy cơ cao'), findsWidgets);
    expect(find.text('78.0'), findsOneWidget);

    await tester.tap(find.text('Căn nguyên').last);
    await tester.pump(const Duration(milliseconds: 200));
    expect(find.text('Streptococcus pneumoniae'), findsOneWidget);
    expect(find.text('Klebsiella pneumoniae'), findsWidgets);

    await tester.tap(find.text('Bằng chứng').last);
    await tester.pump(const Duration(milliseconds: 200));
    expect(find.text('CURB-65'), findsWidgets);

    await tester.tap(find.text('Phác đồ').last);
    await tester.pump(const Duration(milliseconds: 200));
    expect(find.text('Meropenem'), findsOneWidget);

    // ── Confirm treatment ─────────────────────────────────────────
    await tester.ensureVisible(find.text('Lưu kết quả'));
    await tester.pump(const Duration(milliseconds: 200));
    await tester.tap(find.text('Lưu kết quả'));
    await tester.pump(const Duration(milliseconds: 300));

    final medicineRow = find.descendant(
      of: find.byType(SelectionRowWidget),
      matching: find.text('Meropenem'),
    );
    expect(medicineRow, findsOneWidget);
    await tester.ensureVisible(medicineRow);
    await tester.pump(const Duration(milliseconds: 200));
    await tester.tap(medicineRow);
    await tester.pump(const Duration(milliseconds: 300));
    await settleApi(tester);

    await tester.ensureVisible(
        find.widgetWithText(AppButton, 'Xác nhận điều trị'));
    await tester.pump(const Duration(milliseconds: 200));
    await tester.tap(find.widgetWithText(AppButton, 'Xác nhận điều trị'));
    await tester.pump(const Duration(milliseconds: 500));
    await settleApi(tester);
    await settleApi(tester);

    expect(find.text('Đã lưu kết quả điều trị.'), findsOneWidget);

    // Flush the toast auto-dismiss timer before the test ends.
    await tester.pump(const Duration(seconds: 3));
  });

  testWidgets('theme mode defaults to system and can be forced', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final container = ProviderContainer(
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
    );
    addTearDown(container.dispose);

    final themeMode = container.read(themeModeControllerProvider);
    expect(themeMode, ThemeMode.system);

    container.read(themeModeControllerProvider.notifier).setDark();
    expect(container.read(themeModeControllerProvider), ThemeMode.dark);
    expect(prefs.getString('settings.themeMode'), 'dark');
  });

  testWidgets('input text is vertically centered inside its field box', (
    tester,
  ) async {
    await pumpTestApp(tester, initialLocation: PatientRoutes.addPatient);

    final fieldRect = tester.getRect(find.byType(TextFormField).first);
    expect(fieldRect.height, ControlSize.inputDefault);

    final editText = find
        .descendant(
          of: find.byType(TextFormField).first,
          matching: find.byType(EditableText),
        )
        .first;
    final textRect = tester.getRect(editText);

    expect(textRect.center.dy - fieldRect.center.dy, lessThan(2.0));
    expect(fieldRect.center.dy - textRect.center.dy, lessThan(2.0));
  });
}
