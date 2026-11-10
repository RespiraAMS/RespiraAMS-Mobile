import 'package:dio/dio.dart';

import '../../../core/network/api_response.dart';
import '../../../core/network/pagination_dto.dart';
import '../models/patient_dtos.dart';

/// Patient endpoints of Respira.Patient (`/patients/*`).
///
/// Paths are relative to [kApiRootUrl] (`/api/v1`), which is baked into
/// the shared Dio's base URL.
class PatientService {
  PatientService(this._dio);

  final Dio _dio;

  /// `GET /patients` — paged roster. The backend only supports the
  /// `Gender` / `MinAge` / `MaxAge` filters here (name lookup lives in
  /// [searchPatients]).
  Future<Paged<PatientListItemDto>> getPatients({
    int page = 1,
    int size = 10,
    String? gender,
    int? minAge,
    int? maxAge,
  }) async {
    final res = await _dio.get(
      '/patients',
      queryParameters: {
        'page': page,
        'size': size,
        if (gender != null && gender.isNotEmpty) 'gender': gender,
        'minAge': ?minAge,
        'maxAge': ?maxAge,
      },
    );
    final json = unwrapEnvelope(res);
    return Paged.fromJson(json, PatientListItemDto.fromJson);
  }

  /// `GET /patients/search` — relevance-ranked free-text search over the
  /// full name / medical record code.
  Future<Paged<PatientListItemDto>> searchPatients({
    required String searchTerm,
    int page = 1,
    int size = 10,
  }) async {
    final res = await _dio.get(
      '/patients/search',
      queryParameters: {'searchTerm': searchTerm, 'page': page, 'size': size},
    );
    final json = unwrapEnvelope(res);
    return Paged.fromJson(json, PatientListItemDto.fromJson);
  }

  /// `GET /patients/{id}` — full profile + treatment timeline.
  Future<PatientDetailDto> getPatient(String id) async {
    final res = await _dio.get('/patients/$id');
    return unwrapData(res, (json) => PatientDetailDto.fromJson(json));
  }

  /// `POST /patients` — returns the created patient's ID.
  Future<String> createPatient({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String dateOfBirth, // yyyy-MM-dd
    required String gender, // Male | Female
    required double height, // cm
    required double weight, // kg
    required String medicalRecordCode,
    required String healthInsuranceCard,
    required String address,
    required String city,
  }) async {
    final res = await _dio.post(
      '/patients',
      data: {
        'firstName': firstName,
        'lastName': lastName,
        'phoneNumber': phoneNumber,
        'dateOfBirth': dateOfBirth,
        'gender': gender,
        'height': height,
        'weight': weight,
        'medicalRecordCode': medicalRecordCode,
        'healthInsuranceCard': healthInsuranceCard,
        'address': address,
        'city': city,
      },
    );
    final created = unwrapData(res, (json) => CreatedPatientDto.fromJson(json));
    return created.id;
  }

  /// `PUT /patients/{id}` — updates the editable demographics.
  Future<void> updatePatient({
    required String id,
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String dateOfBirth, // yyyy-MM-dd
    required String gender, // Male | Female
    required double height, // cm
    required double weight, // kg
    required String medicalRecordCode,
    required String healthInsuranceCard,
    required String address,
    required String city,
  }) async {
    final res = await _dio.put(
      '/patients/$id',
      data: {
        'firstName': firstName,
        'lastName': lastName,
        'phoneNumber': phoneNumber,
        'dateOfBirth': dateOfBirth,
        'gender': gender,
        'height': height,
        'weight': weight,
        'medicalRecordCode': medicalRecordCode,
        'healthInsuranceCard': healthInsuranceCard,
        'address': address,
        'city': city,
      },
    );
    unwrapResult(res);
  }

  /// `PUT /patients/{id}/discharge?outcome=…` — closes the episode.
  ///
  /// [outcome] is `Recovered` | `Death` | `OutOfScope` (the backend also
  /// accepts `InTreatment`, but discharging into that state is a no-op).
  Future<void> dischargePatient({
    required String id,
    required String outcome,
  }) async {
    final res = await _dio.put(
      '/patients/$id/discharge',
      queryParameters: {'outcome': outcome},
    );
    unwrapResult(res);
  }

  /// `DELETE /patients/{id}`.
  Future<void> deletePatient(String id) async {
    final res = await _dio.delete('/patients/$id');
    unwrapResult(res);
  }

  /// `POST /patients/{id}/next-of-kin` — returns the created kin's ID.
  Future<String> addNextOfKin({
    required String patientId,
    required String fullName,
    required String phoneNumber,
    required String relationship,
  }) async {
    final res = await _dio.post(
      '/patients/$patientId/next-of-kin',
      data: {
        'fullName': fullName,
        'phoneNumber': phoneNumber,
        'relationship': relationship,
      },
    );
    return unwrapScalar(
      res,
      (data) => data is Map<String, dynamic> ? data['id'] as String? ?? '' : '',
    );
  }

  /// `PUT /next-of-kin/{nextOfKinId}`.
  ///
  /// Note the absolute route: the backend declares it with a leading `/`,
  /// so it is not nested under `/patients`.
  Future<void> updateNextOfKin({
    required String nextOfKinId,
    required String fullName,
    required String phoneNumber,
    required String relationship,
  }) async {
    final res = await _dio.put(
      '/next-of-kin/$nextOfKinId',
      data: {
        'fullName': fullName,
        'phoneNumber': phoneNumber,
        'relationship': relationship,
      },
    );
    unwrapResult(res);
  }

  /// `DELETE /next-of-kin/{nextOfKinId}` (absolute route).
  Future<void> deleteNextOfKin(String nextOfKinId) async {
    final res = await _dio.delete('/next-of-kin/$nextOfKinId');
    unwrapResult(res);
  }

  /// `GET /treatment-plans/{id}` — full plan detail.
  Future<TreatmentPlanDetailDto> getTreatmentPlan(String id) async {
    final res = await _dio.get('/treatment-plans/$id');
    return unwrapData(res, TreatmentPlanDetailDto.fromJson);
  }

  /// `PUT /treatment-plans/{id}/close` — closes the plan with a reason.
  Future<void> closeTreatmentPlan({
    required String id,
    required String reason,
  }) async {
    final res = await _dio.put(
      '/treatment-plans/$id/close',
      data: {'reason': reason},
    );
    unwrapResult(res);
  }

  /// `PUT /treatment-plans/{id}/review` — records the adherence review.
  ///
  /// [adherenceState] is `Adhere` | `NotAdhere` | `NotAdhereValid` |
  /// `NotAdhereInvalid`.
  Future<void> reviewTreatmentPlan({
    required String id,
    required String adherenceState,
  }) async {
    final res = await _dio.put(
      '/treatment-plans/$id/review',
      data: {'adherenceState': adherenceState},
    );
    unwrapResult(res);
  }
}
