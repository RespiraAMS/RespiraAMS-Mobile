import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:respiraams/core/network/api_client.dart';
import 'package:respiraams/core/theme/theme_mode_provider.dart';
import 'package:respiraams/design_system/design_system.dart';
import 'package:respiraams/features/diagnosis/models/clinical_dtos.dart';
import 'package:respiraams/features/diagnosis/providers/diagnosis_controller.dart';
import 'package:respiraams/features/diagnosis/routes.dart';
import 'package:respiraams/features/diagnosis/models/diagnosis_state.dart';
import 'package:respiraams/features/diagnosis/screens/diagnosis_wizard_screen.dart';
import 'package:respiraams/features/patient/models/patient.dart';
import 'package:respiraams/features/patient/providers/active_patient_provider.dart';
import 'package:respiraams/features/patient/routes.dart';

import 'helpers/fake_api_adapter.dart';
import 'helpers/pump_test_app.dart';

class _SeededActivePatient extends ActivePatientController {
  _SeededActivePatient(this._patient);

  final Patient _patient;

  @override
  Patient? build() => _patient;
}

/// Starts with stale values, as if a previous patient/attempt was left
/// half-way through the wizard.
class _SeededDiagnosisController extends DiagnosisController {
  @override
  DiagnosisFormState build() => const DiagnosisFormState(
        values: {'var-stale': 'true'},
        allergyType: 'Yes',
      );
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

Future<void> _pumpWizard(
  WidgetTester tester, {
  Map<String, MockedResponse> overrides = const {},
}) async {
  await pumpTestApp(
    tester,
    initialLocation: DiagnosisRoutes.wizard,
    overrides: overrides,
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

/// Finder of the two-tab boolean field of [variableId].
Finder _boolField(String variableId) =>
    find.byKey(ValueKey('bool-field-$variableId'));

/// Taps the "Có"/"Không" tab of a boolean field.
Future<void> _answerBoolean(
  WidgetTester tester,
  String variableId, {
  required bool yes,
}) async {
  final field = _boolField(variableId);
  await tester.ensureVisible(field);
  await tester.pump(const Duration(milliseconds: 100));
  await tester.tap(
    find.descendant(of: field, matching: find.text(yes ? 'Có' : 'Không')),
  );
  await tester.pump(const Duration(milliseconds: 200));
}

void main() {
  test('VariableRefDto tolerates the name-less evidence reference', () {
    // BE's `VariableRef` = { id, code, valueType } — no `name`.
    final ref = VariableRefDto.fromJson({
      'id': 'var-rr',
      'code': 'RR',
      'valueType': 'Numeric',
    });
    expect(ref.name, isEmpty);
    expect(ref.displayLabel, 'RR');

    // Top-level missing variables come as `ClinicalVariableResult` (named).
    final named = VariableRefDto.fromJson({
      'id': 'var-rr',
      'name': 'Nhịp thở',
      'code': 'RR',
    });
    expect(named.displayLabel, 'Nhịp thở');
  });

  test('gender prefill matches the option casing of the diagnose form', () {
    // Seed data uses uppercase constants (criteria compare against these).
    expect(genderOptionFor(Gender.nam, const ['MALE', 'FEMALE']), 'MALE');
    expect(genderOptionFor(Gender.nu, const ['MALE', 'FEMALE']), 'FEMALE');

    // Older/other payloads that use title case still resolve.
    expect(genderOptionFor(Gender.nam, const ['Male', 'Female']), 'Male');

    // No options advertised → fall back to the uppercase constant.
    expect(genderOptionFor(Gender.nam, const []), 'MALE');
  });

  testWidgets('walks the dynamic diagnosis wizard to result + saves treatment',
      (tester) async {
    await _pumpWizard(tester);

    // Step 1/5 · assessment: every variable grouped by BE category.
    expect(find.text('Chẩn đoán kinh nghiệm'), findsOneWidget);
    expect(find.text('Bước 1/5 · Đánh giá mức độ & nhiễm khuẩn'), findsOneWidget);
    expect(find.text('Tìm biến số'), findsOneWidget);
    expect(find.text('Thông tin cá nhân'), findsOneWidget);
    expect(find.text('Tiền sử bệnh'), findsOneWidget);
    expect(find.text('Cận lâm sàng'), findsOneWidget);
    expect(find.text('Lâm sàng'), findsOneWidget);
    // FiO2 và PaO2 cùng section "Lâm sàng" (category `Clinical` như BE).
    expect(find.text('FiO2 *'), findsOneWidget);
    expect(find.text('PaO2'), findsOneWidget);

    await tester.enterText(
        find.widgetWithText(AppUnitField, 'Nhịp thở *'), '28');
    await tester.pump(const Duration(milliseconds: 100));
    await tester.enterText(
        find.widgetWithText(AppUnitField, 'FiO2 *'), '21');
    await tester.pump(const Duration(milliseconds: 100));
    await tester.enterText(
        find.widgetWithText(AppUnitField, 'Bạch cầu'), '12');
    await tester.pump(const Duration(milliseconds: 100));
    await _answerBoolean(tester, 'var-ckd', yes: true);
    await _answerBoolean(tester, 'var-confusion', yes: true);
    await tester.tap(find.text('Tiếp tục'));
    await _settleNavigation(tester);

    // Step 2/5 · allergy (must be explicitly selected).
    expect(find.text('Bước 2/5 · Dị ứng'), findsOneWidget);
    await tester.tap(find.text('Không dị ứng'));
    await tester.pump(const Duration(milliseconds: 100));
    await tester.tap(find.text('Tiếp tục'));
    await _settleNavigation(tester);

    // Optional contract steps.
    expect(find.text('Bước 3/5 · Bệnh sử đặc biệt'), findsOneWidget);
    await tester.tap(find.text('Tiếp tục'));
    await _settleNavigation(tester);

    expect(find.text('Bước 4/5 · Nhiễm trùng khác'), findsOneWidget);
    await tester.tap(find.text('Tiếp tục'));
    await _settleNavigation(tester);

    expect(find.text('Bước 5/5 · Mẫu xét nghiệm vi sinh'), findsOneWidget);
    await tester.tap(find.widgetWithText(AppButton, 'Chẩn đoán'));
    await _settleNavigation(tester);
    await settleApi(tester);
    await settleApi(tester);

    // ── Diagnosis result ──────────────────────────────────────────
    expect(find.text('Kết quả chẩn đoán'), findsOneWidget);
    expect(find.text('Nặng'), findsWidgets);
    expect(find.text('Nội trú'), findsWidgets);
    // The redundant "Nguy cơ cao/nhẹ" pill was removed (severity is already
    // shown by the "Mức độ" tile).
    expect(find.text('Nguy cơ cao'), findsNothing);
    expect(find.text('78.0'), findsOneWidget);

    await tester.tap(find.text('Căn nguyên').last);
    await tester.pump(const Duration(milliseconds: 200));
    expect(find.text('Streptococcus pneumoniae'), findsOneWidget);
    expect(find.text('Klebsiella pneumoniae'), findsWidgets);

    await tester.tap(find.text('Bằng chứng').last);
    await tester.pump(const Duration(milliseconds: 200));
    expect(find.text('CURB-65'), findsWidgets);
    // The formula line is intentionally hidden on the result screen.
    expect(find.textContaining('Công thức:'), findsNothing);
    // Evidence refs carry only a code: the form catalog resolves the name…
    expect(find.textContaining('Lú lẫn mới xuất hiện'), findsWidgets);
    // …and codes without a catalog entry fall back to the code itself.
    expect(find.textContaining('UREA'), findsWidgets);

    await tester.tap(find.text('Phác đồ').last);
    await tester.pump(const Duration(milliseconds: 200));
    // Drugs are rendered as AWaRe-coloured chips ("<name> · <class>").
    expect(find.text('Meropenem · Watch'), findsOneWidget);

    // ── Confirm treatment (dedicated page, not a bottom sheet) ────
    await tester.ensureVisible(find.text('Lưu kết quả'));
    await tester.pump(const Duration(milliseconds: 200));
    await tester.tap(find.text('Lưu kết quả'));
    await _settleNavigation(tester);
    await settleApi(tester);

    expect(find.text('Tìm thuốc'), findsOneWidget);
    expect(find.text('Xác nhận điều trị'), findsWidgets);

    // A non-protocol pick requires a reason.
    final amoxicillinRow = find.byKey(const ValueKey('drug-abx-amoxicillin'));
    await tester.ensureVisible(amoxicillinRow);
    await tester.pump(const Duration(milliseconds: 200));
    await tester.tap(amoxicillinRow);
    await tester.pump(const Duration(milliseconds: 200));
    await tester.tap(find.widgetWithText(AppButton, 'Xác nhận điều trị'));
    await tester.pump(const Duration(milliseconds: 200));
    expect(find.text('Vui lòng nhập lý do chọn thuốc.'), findsOneWidget);

    // Switch to the protocol combination → marked as adherent.
    await tester.tap(amoxicillinRow);
    await tester.pump(const Duration(milliseconds: 200));
    final meropenemRow = find.byKey(const ValueKey('drug-abx-meropenem'));
    await tester.ensureVisible(meropenemRow);
    await tester.pump(const Duration(milliseconds: 200));
    await tester.tap(meropenemRow);
    await tester.pump(const Duration(milliseconds: 300));
    await settleApi(tester);
    expect(find.text('Tuân thủ'), findsOneWidget);

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

  testWidgets(
      'boolean fields show the label above Không/Có tabs and default to Không',
      (tester) async {
    await _pumpWizard(tester);

    // Step 1/5 · assessment holds the boolean fields of every category.
    expect(
      find.text('Bước 1/5 · Đánh giá mức độ & nhiễm khuẩn'),
      findsOneWidget,
    );

    final field = _boolField('var-ckd');
    expect(field, findsOneWidget);

    final label = find.descendant(
      of: field,
      matching: find.text('Bệnh thận mạn'),
    );
    final noTab = find.descendant(of: field, matching: find.text('Không'));
    final yesTab = find.descendant(of: field, matching: find.text('Có'));
    expect(label, findsOneWidget);
    expect(noTab, findsOneWidget);
    expect(yesTab, findsOneWidget);

    // The tabs live on their own line below the field name.
    expect(
      tester.getBottomLeft(label).dy,
      lessThan(tester.getTopLeft(noTab).dy),
    );

    // "Không" is selected by default (payload sends `false`).
    final segments = tester
        .widgetList<AnimatedContainer>(
          find.descendant(of: field, matching: find.byType(AnimatedContainer)),
        )
        .toList();
    expect(segments, hasLength(2));
    // The segments fill the whole control (44px minus the 1px borders).
    expect(
      tester
          .getSize(
            find
                .descendant(of: field, matching: find.byType(AnimatedContainer))
                .first,
          )
          .height,
      ControlSize.touchTargetMin - 2,
    );
    expect(
      (segments[0].decoration as BoxDecoration?)?.color,
      RespiraColors.light.primary,
    );
    expect(
      (segments[1].decoration as BoxDecoration?)?.color,
      RespiraColors.light.surface,
    );

    // Tapping "Có" flips both the colors and the stored value.
    await _answerBoolean(tester, 'var-ckd', yes: true);

    final flipped = tester
        .widgetList<AnimatedContainer>(
          find.descendant(of: field, matching: find.byType(AnimatedContainer)),
        )
        .toList();
    expect(flipped[0].decoration, isA<BoxDecoration>());
    expect(
      (flipped[0].decoration as BoxDecoration).color,
      RespiraColors.light.surface,
    );
    expect(
      (flipped[1].decoration as BoxDecoration).color,
      RespiraColors.light.primary,
    );

    final container = ProviderScope.containerOf(
      tester.element(find.byType(DiagnosisWizardScreen)),
    );
    expect(
      container.read(diagnosisControllerProvider).values['var-ckd'],
      'true',
    );
  });

  testWidgets('warns — without blocking — when a value is out of range', (
    tester,
  ) async {
    await _pumpWizard(tester);

    await tester.enterText(
        find.widgetWithText(AppUnitField, 'Nhịp thở *'), '28');
    await tester.pump(const Duration(milliseconds: 100));
    await tester.enterText(
        find.widgetWithText(AppUnitField, 'FiO2 *'), '150');
    await tester.pump(const Duration(milliseconds: 200));

    expect(
      find.text('Ngoài khoảng cho phép 21 – 100 %. Vẫn có thể tiếp tục.'),
      findsOneWidget,
    );

    // Advisory only: the step still advances.
    await tester.tap(find.text('Tiếp tục'));
    await _settleNavigation(tester);
    expect(find.text('Bước 2/5 · Dị ứng'), findsOneWidget);
  });

  testWidgets('opening the wizard clears values from a previous attempt', (
    tester,
  ) async {
    await pumpTestApp(
      tester,
      initialLocation: DiagnosisRoutes.wizard,
      providerOverrides: [
        activePatientControllerProvider
            .overrideWith(() => _SeededActivePatient(_seedPatient)),
        diagnosisControllerProvider
            .overrideWith(_SeededDiagnosisController.new),
      ],
    );
    await settleApi(tester);
    await settleApi(tester);

    final container = ProviderScope.containerOf(
      tester.element(find.byType(DiagnosisWizardScreen)),
    );
    final form = container.read(diagnosisControllerProvider);

    // Stale values are gone…
    expect(form.values.containsKey('var-stale'), isFalse);
    expect(form.allergyType, isNull);
    // …while the patient prefill still ran.
    expect(form.values.containsKey('var-age'), isTrue);
  });

  testWidgets('surfaces the BE field details instead of the generic message', (
    tester,
  ) async {
    await _pumpWizard(
      tester,
      overrides: {
        'POST /diagnose': const MockedResponse(400, {
          'statusCode': 'FAILURE-BAD-REQUEST',
          'error': {
            'statusCode': 'FAILURE-BAD-REQUEST',
            'description': 'Invalid observation value',
            'detail': {
              'var-rr': 'Nhịp thở should be > 0 và ≤ 40',
            },
          },
          'data': null,
        }),
      },
    );

    // Walk to the samples step with the minimum required data.
    await tester.enterText(
        find.widgetWithText(AppUnitField, 'Nhịp thở *'), '28');
    await tester.pump(const Duration(milliseconds: 100));
    await tester.enterText(
        find.widgetWithText(AppUnitField, 'FiO2 *'), '21');
    await tester.pump(const Duration(milliseconds: 100));
    await tester.tap(find.text('Tiếp tục'));
    await _settleNavigation(tester);

    expect(find.text('Bước 2/5 · Dị ứng'), findsOneWidget);
    await tester.tap(find.text('Không dị ứng'));
    await tester.pump(const Duration(milliseconds: 100));
    for (var i = 0; i < 3; i++) {
      await tester.tap(find.text('Tiếp tục'));
      await _settleNavigation(tester);
    }
    expect(find.text('Bước 5/5 · Mẫu xét nghiệm vi sinh'), findsOneWidget);

    await tester.tap(find.widgetWithText(AppButton, 'Chẩn đoán'));
    await _settleNavigation(tester);
    await settleApi(tester);
    await settleApi(tester);

    expect(
      find.text('Dữ liệu không hợp lệ ở: Nhịp thở. Vui lòng kiểm tra lại giá trị.'),
      findsOneWidget,
    );
  });

  testWidgets('numeric fields sit on one row: info left, input right', (
    tester,
  ) async {
    await _pumpWizard(tester);

    final field = find.widgetWithText(AppUnitField, 'Nhịp thở *');
    expect(field, findsOneWidget);
    // Placeholder mirrors `normalPlaceholder()` of the web form.
    expect(find.text('BT: 12–20'), findsOneWidget);
    // Description is part of the left-hand info column.
    expect(find.text('Nhịp thở bệnh nhân'), findsOneWidget);

    final label = find.text('Nhịp thở *');
    final input = find.descendant(of: field, matching: find.byType(TextField));
    expect(
      tester.getTopRight(label).dx,
      lessThan(tester.getTopLeft(input).dx),
    );
    // The input takes roughly half of the row.
    expect(
      tester.getSize(input).width,
      greaterThan(tester.getSize(field).width * 0.25),
    );
  });

  testWidgets('assessment search filters variables by name or code', (
    tester,
  ) async {
    await _pumpWizard(tester);

    expect(find.text('Tuổi *'), findsOneWidget);
    expect(find.text('Nhịp thở *'), findsOneWidget);

    await tester.enterText(
      find.widgetWithText(AppTextField, 'Tìm biến số'),
      'nhịp',
    );
    await tester.pumpAndSettle();

    expect(find.text('Nhịp thở *'), findsOneWidget);
    expect(find.text('Tuổi *'), findsNothing);
    // Sections without matches disappear.
    expect(find.text('Thông tin cá nhân'), findsNothing);

    await tester.enterText(
      find.widgetWithText(AppTextField, 'Tìm biến số'),
      '',
    );
    await tester.pumpAndSettle();
    expect(find.text('Tuổi *'), findsOneWidget);
  });

  testWidgets('allergy step searches the antibiotic list', (tester) async {
    await _pumpWizard(tester);

    await tester.enterText(
        find.widgetWithText(AppUnitField, 'Nhịp thở *'), '28');
    await tester.pump(const Duration(milliseconds: 100));
    await tester.enterText(
        find.widgetWithText(AppUnitField, 'FiO2 *'), '21');
    await tester.pump(const Duration(milliseconds: 100));
    await tester.tap(find.text('Tiếp tục'));
    await _settleNavigation(tester);

    expect(find.text('Bước 2/5 · Dị ứng'), findsOneWidget);
    await tester.tap(find.text('Có dị ứng kháng sinh'));
    await tester.pumpAndSettle();

    expect(find.text('Meropenem'), findsOneWidget);
    expect(find.text('Amoxicillin'), findsOneWidget);

    await tester.enterText(
      find.widgetWithText(AppTextField, 'Tìm kháng sinh'),
      'mero',
    );
    await tester.pumpAndSettle();

    expect(find.text('Meropenem'), findsOneWidget);
    expect(find.text('Amoxicillin'), findsNothing);
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
