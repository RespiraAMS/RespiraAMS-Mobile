import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:respiraams/design_system/design_system.dart';
import 'package:respiraams/features/patient/routes.dart';

import 'helpers/fake_api_adapter.dart';
import 'helpers/pump_test_app.dart';

const _patientId = 'patient-BA-2026-0001';

Future<FakeApiAdapter> _openEditForm(WidgetTester tester) async {
  final adapter = await pumpTestApp(
    tester,
    initialLocation: '${PatientRoutes.edit}?id=$_patientId',
    overrides: {
      'PUT /patients': MockedResponse(200, {
        'statusCode': 'SUCCESS',
        'error': null,
        'data': null,
      }),
    },
  );
  await settleApi(tester);
  await tester.pumpAndSettle();
  return adapter;
}

/// Reads the current text of the field labelled [label].
String _fieldText(WidgetTester tester, String label, {Type type = AppTextField}) {
  final editable = find.descendant(
    of: find.widgetWithText(type, label),
    matching: find.byType(EditableText),
  );
  return tester.widget<EditableText>(editable).controller.text;
}

Future<void> _enter(WidgetTester tester, String label, String value) async {
  final finder = find.widgetWithText(AppTextField, label);
  await tester.ensureVisible(finder);
  await tester.pump(const Duration(milliseconds: 100));
  await tester.enterText(finder, value);
  await tester.pump(const Duration(milliseconds: 100));
}

Map<String, dynamic>? _lastPut(FakeApiAdapter adapter) {
  for (final request in adapter.requests.reversed) {
    if (request.method == 'PUT' && request.path.contains('/patients/')) {
      return request.data as Map<String, dynamic>;
    }
  }
  return null;
}

Future<void> _tapSave(WidgetTester tester) async {
  await tester.ensureVisible(find.text('Lưu cập nhật'));
  await tester.pump(const Duration(milliseconds: 200));
  await tester.tap(find.text('Lưu cập nhật'));
  await settleApi(tester);
  await settleApi(tester);
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('shows the medical record code of the patient', (tester) async {
    await _openEditForm(tester);

    expect(_fieldText(tester, 'Mã bệnh án *'), 'BA-2026-0001');
    // Height/weight still come from the detail fixture.
    expect(_fieldText(tester, 'Chiều cao', type: AppUnitField), '170');
    expect(_fieldText(tester, 'Cân nặng', type: AppUnitField), '65');
  });

  testWidgets('saves an edited medical record code', (tester) async {
    final adapter = await _openEditForm(tester);

    // The fixture name is a single word, and the form requires a full name.
    await _enter(tester, 'Họ và tên bệnh nhân *', 'Khoa Nguyễn');
    await _enter(tester, 'Mã bệnh án *', 'BA-2026-9999');
    await _tapSave(tester);

    final body = _lastPut(adapter);
    expect(body, isNotNull);
    expect(body!['medicalRecordCode'], 'BA-2026-9999');
  });

  testWidgets('requires a medical record code before saving', (tester) async {
    final adapter = await _openEditForm(tester);

    await _enter(tester, 'Họ và tên bệnh nhân *', 'Khoa Nguyễn');
    await _enter(tester, 'Mã bệnh án *', '');
    await _tapSave(tester);

    expect(find.text('Vui lòng nhập mã bệnh án.'), findsOneWidget);
    expect(_lastPut(adapter), isNull);
  });
}
