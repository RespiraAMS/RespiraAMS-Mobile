import 'package:flutter_test/flutter_test.dart';

import 'package:respiraams/features/diagnosis/routes.dart';
import 'package:respiraams/features/patient/models/patient.dart';
import 'package:respiraams/features/patient/providers/active_patient_provider.dart';

import 'helpers/pump_test_app.dart';

/// Targeted-treatment tests: the Chẩn đoán vi sinh screen and its selection
/// chips. The screen is opened directly (its former entry point, the
/// "Thêm diễn biến" page, was removed from the flow).

/// Seeds the active patient the targeted screen works on.
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

Future<void> _openTargetedDiagnosis(WidgetTester tester) async {
  await pumpTestApp(
    tester,
    initialLocation: DiagnosisRoutes.targetedTreatment,
    providerOverrides: [
      activePatientControllerProvider
          .overrideWith(() => _SeededActivePatient(_seedPatient)),
    ],
  );
  await settleApi(tester);
  await settleApi(tester);
}

void main() {
  testWidgets('targeted CTA opens Chẩn đoán vi sinh with derived chips',
      (tester) async {
    await _openTargetedDiagnosis(tester);

    expect(find.text('Chẩn đoán vi sinh'), findsOneWidget);
    expect(
        find.text('Mỗi đường dùng là một lựa chọn thuốc riêng'),
        findsOneWidget);
    // Demo recommendations.
    expect(find.text('Meropenem'), findsOneWidget);
    expect(find.text('Ciprofloxacin'), findsOneWidget);

    // Nothing selected initially → no chips. Select Meropenem → P1 chip.
    expect(
        find.text('P1 · Meropenem · TM', skipOffstage: false), findsNothing);
    await tester.tap(find.text('Meropenem'));
    await tester.pump(const Duration(milliseconds: 200));
    expect(
        find.text('P1 · Meropenem · TM', skipOffstage: false), findsOneWidget);

    // Select Ciprofloxacin → P2 chip appears.
    await tester.ensureVisible(find.text('Ciprofloxacin'));
    await tester.pump(const Duration(milliseconds: 200));
    await tester.tap(find.text('Ciprofloxacin'));
    await tester.pump(const Duration(milliseconds: 200));
    expect(
        find.text('P2 · Ciprofloxacin · Uống', skipOffstage: false),
        findsOneWidget);
  });

  testWidgets('saving targeted treatment is not available yet', (tester) async {
    await _openTargetedDiagnosis(tester);

    await tester.tap(find.text('Meropenem'));
    await tester.pump(const Duration(milliseconds: 200));

    await tester.ensureVisible(find.text('Lưu điều trị đích'));
    await tester.pump(const Duration(milliseconds: 200));
    await tester.tap(find.text('Lưu điều trị đích'));
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('Tính năng đang phát triển.'), findsOneWidget);
    expect(find.text('Chẩn đoán vi sinh'), findsOneWidget);

    // Flush the toast auto-dismiss timer before the test ends.
    await tester.pump(const Duration(seconds: 3));
  });
}
