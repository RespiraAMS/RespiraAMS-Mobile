import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:respiraams/core/theme/theme_mode_provider.dart';
import 'package:respiraams/design_system/design_system.dart';
import 'package:respiraams/features/diagnosis/routes.dart';
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
  testWidgets('walks the dynamic diagnosis wizard to result + save toast',
      (tester) async {
    await _pumpWizard(tester);

    // Step 1/4 · personal information (AGE/GENDER prefilled from patient).
    expect(find.text('Chẩn đoán kinh nghiệm'), findsOneWidget);
    expect(find.text('Bước 1/4 · Thông tin cá nhân'), findsOneWidget);
    expect(find.text('Tuổi'), findsOneWidget);
    await tester.tap(find.text('Tiếp tục'));
    await _settleNavigation(tester);

    // Step 2/4 · clinical numeric (RR required).
    expect(find.text('Bước 2/4 · Chỉ số sinh tồn'), findsOneWidget);
    await tester.enterText(
        find.widgetWithText(AppUnitField, 'Nhịp thở'), '28');
    await tester.pump(const Duration(milliseconds: 100));
    await tester.tap(find.text('Tiếp tục'));
    await _settleNavigation(tester);

    // Step 3/4 · paraclinical numeric (WBC optional).
    expect(find.text('Bước 3/4 · Kết quả xét nghiệm'), findsOneWidget);
    await tester.enterText(
        find.widgetWithText(AppUnitField, 'Bạch cầu'), '12');
    await tester.pump(const Duration(milliseconds: 100));
    await tester.tap(find.text('Tiếp tục'));
    await _settleNavigation(tester);

    // Step 4/4 · conditions (booleans).
    expect(find.text('Bước 4/4 · Bệnh nền & nguy cơ'), findsOneWidget);
    await tester.tap(find.text('Lú lẫn mới xuất hiện'));
    await tester.pump(const Duration(milliseconds: 100));
    await tester.tap(find.text('Chẩn đoán'));
    await _settleNavigation(tester);
    await settleApi(tester);
    await settleApi(tester);

    // ── Diagnosis result ──────────────────────────────────────────
    expect(find.text('Kết quả chẩn đoán'), findsOneWidget);
    expect(find.text('Nặng'), findsWidgets);
    expect(find.text('Nội trú'), findsWidgets);
    expect(find.text('Nguy cơ cao'), findsWidgets);

    await tester.tap(find.text('Căn nguyên').last);
    await tester.pump(const Duration(milliseconds: 200));
    expect(find.text('Streptococcus pneumoniae'), findsOneWidget);

    await tester.tap(find.text('Bằng chứng').last);
    await tester.pump(const Duration(milliseconds: 200));
    expect(find.text('CURB-65'), findsWidgets);

    // Save is not available yet — a dev toast is shown instead.
    await tester.ensureVisible(find.text('Lưu kết quả'));
    await tester.pump(const Duration(milliseconds: 200));
    await tester.tap(find.text('Lưu kết quả'));
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text('Tính năng đang phát triển.'), findsOneWidget);

    // Flush the toast auto-dismiss timer before the test ends.
    await tester.pump(const Duration(seconds: 3));
  });

  testWidgets('theme mode defaults to system and can be forced', (
    tester,
  ) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final themeMode = container.read(themeModeControllerProvider);
    expect(themeMode, ThemeMode.system);

    container.read(themeModeControllerProvider.notifier).setDark();
    expect(container.read(themeModeControllerProvider), ThemeMode.dark);
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
