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

  /// Key format: `'METHOD /patients/...'` (path may be a substring of the
  /// real path; first matching entry wins). The version prefix lives in the
  /// Dio base URL, so [RequestOptions.path] carries only the relative path.
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
    // ── Auth / session ────────────────────────────────────────────
    'POST /auth/login': MockedResponse(
      200,
      envelope({
        // Payload: {"sub":"account-1","email":"bs.minh@respira.vn",
        // "role":"Doctor"} — signature is never verified by the client.
        'accessToken': 'eyJhbGciOiJIUzI1NiJ9.'
            'eyJzdWIiOiJhY2NvdW50LTEiLCJlbWFpbCI6ImJzLm1pbmhAcmVzcGlyYS52biIsInJvbGUiOiJEb2N0b3IifQ'
            '.signature',
        'refreshToken': 'refresh-token-1',
      }),
    ),
    'GET /doctors': MockedResponse(
      200,
      envelope({
        'metadata': {
          'hasNextPage': false,
          'hasPreviousPage': false,
          'totalItemCount': 1,
          'pageCount': 1,
          'currentPage': 1,
          'pageSize': 100,
        },
        'items': [
          {
            'id': 'doctor-1',
            'accountId': 'account-1',
            'firstName': 'Minh',
            'lastName': 'Nguyễn',
            'degrees': <String>['ThS', 'BS'],
            'role': 'Doctor',
            'academicTitle': 'PGS.TS',
            'position': 'Trưởng khoa Hô hấp',
            'gender': 'Male',
            'citizenIdentificationNumber': '079123456789',
            'address': 'Quận 1, TP. Hồ Chí Minh',
            'email': 'bs.minh@respira.vn',
            'phone': '0901234567',
          },
        ],
      }),
    ),
    // Placed before the list handler: `/patients` is a substring of both
    // the detail and search paths, and the first match wins.
    'GET /patients/search': MockedResponse(
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
    // Generic detail route (any id, including the UUID returned by create).
    'GET /patients/': MockedResponse(
      200,
      envelope(_patientDetail()),
    ),
    'GET /patients': MockedResponse(
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
    'POST /patients': MockedResponse(
      201,
      envelope({
        'id': '11111111-1111-1111-1111-111111111111',
      }),
    ),
    // More specific diagnose routes must come before the base POST route,
    // because matching is substring-based.
    'POST /diagnose/warn-antibiotic-combination': MockedResponse(
      200,
      envelope({'needWarning': false}),
    ),
    'POST /diagnose/confirm-treatment': MockedResponse(
      200,
      envelope(<String, dynamic>{}),
    ),
    'GET /diagnose': MockedResponse(
      200,
      envelope(_diagnosisForm()),
    ),
    'POST /diagnose': MockedResponse(
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
        'diagnosisId': '0192f5db-7f3a-7b2c-9d1e-8a6b5c4d3e2f',
        'severity': 'Severe',
        'treatmentSite': 'Inpatient',
        'metricsSeverityDiagnosis': [
          {
            'code': 'CURB-65',
            'severity': 'Severe',
            'treatmentSite': 'Inpatient',
            'score': 3,
            'evidences': [
              {
                'source': 'CURB-65',
                'formula': 'Confusion + Urea',
                'score': 3,
              },
            ],
          },
        ],
        'worthSuspected': [
          {'id': 'pathogen-1', 'name': 'Klebsiella pneumoniae'},
        ],
        'heavySuspected': [
          {'id': 'pathogen-2', 'name': 'Streptococcus pneumoniae'},
        ],
        'evidences': [
          {
            'source': 'CURB-65',
            'formula': 'Confusion + Urea',
            'evaluatedValue': true,
            'score': 3,
            'relatedObservations': [
              {
                'variable': {
                  'id': 'var-confusion',
                  'name': 'Lú lẫn mới xuất hiện',
                  'code': 'CONFUSION',
                },
                'value': true,
              },
            ],
          },
        ],
        'missingVariables': <Map<String, dynamic>>[],
        'allergy': {
          'type': 'No',
          'allergicAntibiotics': <Map<String, dynamic>>[],
          'otherAllergy': null,
        },
        'isPatientPregnantOrInLactationPhase': false,
        'egfr': 78.0,
        'otherInfections': ['Sepsis'],
        'microbialTestResults': [
          {
            'sampleType': 'Sputum',
            'category': 'Susceptible',
            'pathogen': {'id': 'pathogen-1', 'name': 'Klebsiella pneumoniae'},
            'antibiotics': [
              {'id': 'abx-meropenem', 'name': 'Meropenem', 'classification': 'Watch'},
            ],
          },
        ],
        'protocols': [
          {
            'id': 'protocol-severe-inpatient',
            'severity': 'Severe',
            'treatmentSite': 'Inpatient',
            'medicines': [
              [
                {
                  'id': 'abx-meropenem',
                  'name': 'Meropenem',
                  'classification': 'Watch',
                },
              ],
            ],
            'pathogens': [
              {'id': 'pathogen-2', 'name': 'Streptococcus pneumoniae'},
            ],
            'criteria': [
              {'id': 'criterion-1', 'name': 'CURB-65 ≥ 3', 'formula': 'CURB-65 >= 3'},
            ],
          },
        ],
      };

  static Map<String, dynamic> _diagnosisForm() => {
        'clinicalVariables': [
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
          {
            'id': 'var-ckd',
            'name': 'Bệnh thận mạn',
            'description': '',
            'code': 'CKD',
            'valueType': 'Boolean',
            'isRequired': false,
            'category': 'MedicalHistory',
          },
        ],
        'antibiotics': [
          {
            'id': 'abx-meropenem',
            'name': 'Meropenem',
            'antibioticGroupId': 'group-carbapenem',
            'antibioticGroupName': 'Carbapenem',
            'classification': 'Watch',
          },
        ],
        'pathogens': [
          {'id': 'pathogen-1', 'name': 'Klebsiella pneumoniae'},
          {'id': 'pathogen-2', 'name': 'Streptococcus pneumoniae'},
        ],
      };
}
