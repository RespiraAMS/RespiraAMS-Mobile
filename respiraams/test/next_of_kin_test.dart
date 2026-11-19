import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:respiraams/design_system/design_system.dart';
import 'package:respiraams/features/patient/models/next_of_kin_relationship.dart';
import 'package:respiraams/features/patient/routes.dart';

import 'helpers/fake_api_adapter.dart';
import 'helpers/pump_test_app.dart';

const _patientId = 'patient-BA-2026-0001';

int _detailRequests(FakeApiAdapter adapter) => adapter.requests
    .where((request) => request.path.contains('/patients/$_patientId'))
    .length;

void main() {
  testWidgets('refreshes the patient detail after adding a next of kin', (
    tester,
  ) async {
    final adapter = await pumpTestApp(
      tester,
      initialLocation: '${PatientRoutes.detail}?id=$_patientId',
    );
    await settleApi(tester);
    await tester.pumpAndSettle();

    final before = _detailRequests(adapter);
    expect(before, 1);

    await tester.tap(find.text('Thêm người thân'));
    await tester.pumpAndSettle();
    await settleApi(tester);

    await tester.enterText(
      find.widgetWithText(AppTextField, 'Họ và tên *'),
      'Nguyễn Văn An',
    );
    await tester.enterText(
      find.widgetWithText(AppTextField, 'Số điện thoại *'),
      '0901234567',
    );

    // Relationship picker.
    await tester.tap(find.byType(DropdownButton<NextOfKinRelationship>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Vợ/Chồng').last);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Lưu người thân'));
    await settleApi(tester);
    await settleApi(tester);
    await tester.pumpAndSettle();

    // The form awaited the refreshed record before closing, so the detail
    // screen already holds the new list.
    expect(_detailRequests(adapter), greaterThan(before));

    // Back on the detail screen (the form's subtitle is gone).
    expect(find.text('Thông tin liên hệ của bệnh nhân'), findsNothing);
    expect(find.text('Thêm người thân'), findsOneWidget);
  });
}
