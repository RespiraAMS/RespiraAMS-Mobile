import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:respiraams/core/network/api_response.dart';
import 'package:respiraams/features/authentication/services/profile_update_service.dart';

import 'helpers/fake_api_adapter.dart';

ProfileUpdateService _service(FakeApiAdapter adapter) {
  final dio = Dio(BaseOptions(baseUrl: 'http://localhost:5016'))
    ..httpClientAdapter = adapter;
  return ProfileUpdateService(dio);
}

void main() {
  test('returns as soon as the saga reports Completed', () async {
    final adapter = FakeApiAdapter(
      overrides: {
        'GET /profile/update': MockedResponse(
          200,
          FakeApiAdapter.envelope({
            'sagaId': 'saga-1',
            'step': 'Completed',
            'failureReason': null,
          }),
        ),
      },
    );

    await _service(adapter).waitUntilFinished(
      'saga-1',
      interval: const Duration(milliseconds: 1),
    );
    expect(adapter.requests.where((r) => r.method == 'GET'), hasLength(1));
  });

  test('surfaces the saga failure reason', () async {
    final adapter = FakeApiAdapter(
      overrides: {
        'GET /profile/update': MockedResponse(
          200,
          FakeApiAdapter.envelope({
            'sagaId': 'saga-1',
            'step': 'Failed',
            'failureReason': 'Phone is required',
          }),
        ),
      },
    );

    expect(
      () => _service(adapter).waitUntilFinished(
        'saga-1',
        interval: const Duration(milliseconds: 1),
      ),
      throwsA(
        isA<ApiException>().having(
          (e) => e.message,
          'message',
          'Phone is required',
        ),
      ),
    );
  });

  test('treats 404 as finished once the start grace elapses', () async {
    // The default adapter answers 404 for the status route.
    final adapter = FakeApiAdapter();

    await _service(adapter).waitUntilFinished(
      'saga-1',
      startGrace: Duration.zero,
      interval: const Duration(milliseconds: 1),
    );
  });
}
