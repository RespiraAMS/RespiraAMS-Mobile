import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:respiraams/core/network/api_response.dart';

Response<dynamic> _response({required int status, Object? data}) =>
    Response<dynamic>(
      requestOptions: RequestOptions(path: '/'),
      statusCode: status,
      data: data,
    );

void main() {
  test('unwrapResult accepts 204 responses without a body', () {
    // `ApplicationStatus.Updated` is serialized as 204 No Content; Dio hands
    // back '' (or null) instead of a map.
    expect(() => unwrapResult(_response(status: 204, data: '')), returnsNormally);
    expect(
      () => unwrapResult(_response(status: 204, data: null)),
      returnsNormally,
    );
  });

  test('unwrapResult still throws on a failure envelope', () {
    final res = _response(
      status: 400,
      data: {
        'statusCode': 'FAILURE-BAD-REQUEST',
        'error': {
          'statusCode': 'FAILURE-BAD-REQUEST',
          'description': 'nope',
        },
        'data': null,
      },
    );

    expect(() => unwrapResult(res), throwsA(isA<ApiException>()));
  });
}
