import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';

/// Canned response for one mocked route.
class MockedResponse {
  const MockedResponse(this.status, this.body);

  final int status;
  final Map<String, dynamic> body;
}

/// Offline [HttpClientAdapter] for widget tests: matches requests by
/// method + path (substring) against canned JSON envelopes, so flow tests
/// never touch the network (CI-safe).
class FakeApiAdapter implements HttpClientAdapter {
  FakeApiAdapter({Map<String, MockedResponse> overrides = const {}})
      : _handlers = {..._defaultHandlers, ...overrides};

  /// Key format: `'METHOD /api/1/...'` (path may be a substring of the
  /// real path; first matching entry wins).
  final Map<String, MockedResponse> _handlers;

  void add(String key, MockedResponse response) =>
      _handlers[key] = response;

  @override
  void close({bool force = false}) {}

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    for (final entry in _handlers.entries) {
      final space = entry.key.indexOf(' ');
      final method = entry.key.substring(0, space);
      final path = entry.key.substring(space + 1);
      if (options.method == method && options.path.contains(path)) {
        return ResponseBody.fromString(
          jsonEncode(entry.value.body),
          entry.value.status,
          headers: _jsonHeaders,
        );
      }
    }
    return ResponseBody.fromString(
      jsonEncode({
        'statusCode': 'FAILURE-RESOURCE-NOT-FOUND',
        'error': {
          'statusCode': 'FAILURE-RESOURCE-NOT-FOUND',
          'description': 'Not mocked: ${options.method} ${options.path}',
        },
        'data': null,
      }),
      404,
      headers: _jsonHeaders,
    );
  }

  static const _jsonHeaders = {
    Headers.contentTypeHeader: [Headers.jsonContentType],
  };

  static Map<String, dynamic> envelope(Map<String, dynamic> data) => {
        'statusCode': 'SUCCESS',
        'error': null,
        'data': data,
      };

  // ── Default demo dataset (mirrors the retired demo providers) ──────

  static final Map<String, MockedResponse> _defaultHandlers = {
    // Placed before the list handler: `GET /api/1/patients` is a substring
    // of both the detail and search paths, and the first match wins.
    'GET /api/1/patients/search': MockedResponse(
      200,
      envelope({
        'metadata': {
          'hasNextPage': false,
          'hasPreviousPage': false,
          'totalItemCount': 1,
          'pageCount': 1,
          'currentPage': 1,
          'pageSize': 10,
        },
        'items': [_patient('An', 'BA-2026-0002', 47, 'InTreatment')],
      }),
    ),
    'GET /api/1/patients/patient-': MockedResponse(
      200,
      envelope(_patientDetail()),
    ),
    'GET /api/1/patients': MockedResponse(
      200,
      envelope({
        'metadata': {
          'hasNextPage': false,
          'hasPreviousPage': false,
          'totalItemCount': 2,
          'pageCount': 1,
          'currentPage': 1,
          'pageSize': 10,
        },
        'items': [
          _patient('Khoa', 'BA-2026-0001', 55, 'InTreatment'),
          _patient('An', 'BA-2026-0002', 47, 'InTreatment'),
        ],
      }),
    ),
    'POST /api/1/patients': MockedResponse(
      201,
      envelope({
        'id': '11111111-1111-1111-1111-111111111111',
      }),
    ),
    'GET /api/1/diagnose/empirical': MockedResponse(
      200,
      envelope(_diagnosisForm()),
    ),
    'POST /api/1/diagnose/empirical': MockedResponse(
      200,
      envelope(_empiricalResult()),
    ),
  };

  static Map<String, dynamic> _patient(
    String name,
    String code,
    int age,
    String outcome,
  ) =>
      {
        'id': 'patient-$code',
        'fullName': name,
        'dateOfBirth': '1971-04-12',
        'age': age,
        'gender': 'Male',
        'medicalRecordCode': code,
        'treatmentOutcome': outcome,
      };

  static Map<String, dynamic> _patientDetail() => {
        'id': 'patient-BA-2026-0001',
        'fullName': 'Khoa',
        'phoneNumber': '0900000000',
        'dateOfBirth': '1971-04-12',
        'gender': 'Male',
        'height': 170.0,
        'weight': 65.0,
        'medicalRecordCode': 'BA-2026-0001',
        'healthInsuranceCard': '0123456789',
        'address': 'Cần Thơ',
        'city': 'Cần Thơ',
        'admission': '2026-01-02',
        'treatmentOutcome': 'InTreatment',
        'nextOfKins': <Map<String, dynamic>>[],
        'treatments': <Map<String, dynamic>>[],
      };

  static Map<String, dynamic> _empiricalResult() => {
        'severity': 'Severe',
        'treatmentSite': 'Inpatient',
        'worthSuspected': [
          {'id': 'pathogen-1', 'name': 'Klebsiella pneumoniae'},
        ],
        'heavySuspected': [
          {'id': 'pathogen-2', 'name': 'Streptococcus pneumoniae'},
        ],
        'evidences': [
          {'source': 'CURB-65', 'formula': 'Confusion + Urea', 'score': 3},
        ],
        'missingVariables': <Map<String, dynamic>>[],
        'allergies': <Map<String, dynamic>>[],
        'isPatientPregnantOrInLactationPhase': false,
      };

  static Map<String, dynamic> _diagnosisForm() => {
        'variables': [
          {
            'id': 'var-age',
            'name': 'Tuổi',
            'description': '',
            'code': 'AGE',
            'valueType': 'Numeric',
            'canonicalUnit': 'tuổi',
            'isRequired': true,
            'category': 'PersonalInformation',
            'acceptedValues': <String>[],
          },
          {
            'id': 'var-gender',
            'name': 'Giới tính',
            'description': '',
            'code': 'GENDER',
            'valueType': 'Categorical',
            'isRequired': true,
            'category': 'PersonalInformation',
            'acceptedValues': ['Male', 'Female'],
          },
          {
            'id': 'var-rr',
            'name': 'Nhịp thở',
            'description': '',
            'code': 'RR',
            'valueType': 'Numeric',
            'canonicalUnit': 'lần/phút',
            'isRequired': true,
            'category': 'Clinical',
            'acceptedRange': {
              'min': 12,
              'max': 20,
              'unit': 'lần/phút',
              'isMinExclusive': false,
              'isMaxExclusive': false,
            },
          },
          {
            'id': 'var-confusion',
            'name': 'Lú lẫn mới xuất hiện',
            'description': '',
            'code': 'CONFUSION',
            'valueType': 'Boolean',
            'isRequired': false,
            'category': 'Clinical',
          },
          {
            'id': 'var-wbc',
            'name': 'Bạch cầu',
            'description': '',
            'code': 'WBC',
            'valueType': 'Numeric',
            'canonicalUnit': 'G/L',
            'isRequired': false,
            'category': 'Paraclinical',
          },
        ],
      };
}
