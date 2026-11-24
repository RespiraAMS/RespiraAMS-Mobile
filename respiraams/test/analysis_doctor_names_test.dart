import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:respiraams/core/network/api_client.dart';
import 'package:respiraams/features/analysis/providers/analysis_providers.dart';
import 'package:respiraams/features/authentication/providers/current_doctor_provider.dart';
import 'package:respiraams/features/authentication/services/doctor_service.dart';

import 'helpers/fake_api_adapter.dart';

/// `doctorNamesProvider` must cover every doctor a HeadDepartmentDoctor can
/// see in the analysis reports, without ever calling the Admin-only roster.
Future<ProviderContainer> _container({
  required String role,
  required FakeApiAdapter adapter,
}) async {
  SharedPreferences.setMockInitialValues({'auth.role': role});
  final prefs = await SharedPreferences.getInstance();

  final dio = Dio(BaseOptions(baseUrl: 'http://localhost:5016'))
    ..httpClientAdapter = adapter;

  return ProviderContainer(
    overrides: [
      sharedPreferencesProvider.overrideWithValue(prefs),
      apiClientProvider.overrideWithValue(dio),
      currentDoctorProvider.overrideWith(
        (ref) async => DoctorProfileDto(
          id: 'doctor-1',
          accountId: 'account-1',
          firstName: 'Minh',
          lastName: 'Nguyễn',
        ),
      ),
    ],
  );
}

void main() {
  test('a HeadDepartmentDoctor also resolves subordinate names', () async {
    final adapter = FakeApiAdapter();
    final container = await _container(
      role: 'HeadDepartmentDoctor',
      adapter: adapter,
    );
    addTearDown(container.dispose);

    final names = await container.read(doctorNamesProvider.future);

    expect(names['account-1'], 'Minh Nguyễn');
    expect(names['account-2'], 'Lan Trần');
    expect(names['account-3'], 'Hùng Phạm');
    expect(
      adapter.requests.any(
        (request) => request.path.contains('/doctors/subordinates'),
      ),
      isTrue,
    );
  });

  test('a Doctor never calls the HDD-only roster', () async {
    final adapter = FakeApiAdapter();
    final container = await _container(role: 'Doctor', adapter: adapter);
    addTearDown(container.dispose);

    final names = await container.read(doctorNamesProvider.future);

    expect(names, {'account-1': 'Minh Nguyễn'});
    expect(
      adapter.requests.any(
        (request) => request.path.contains('/doctors/subordinates'),
      ),
      isFalse,
    );
  });
}
