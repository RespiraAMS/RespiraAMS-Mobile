import 'package:dio/dio.dart';

import '../../../core/network/api_response.dart';
import '../../../core/network/pagination_dto.dart';
import '../models/patient_dtos.dart';

/// Patient endpoints of Respira.Patient (`/api/1/patients/*`).
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
      '/api/1/patients',
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
      '/api/1/patients/search',
      queryParameters: {
        'searchTerm': searchTerm,
        'page': page,
        'size': size,
      },
    );
    final json = unwrapEnvelope(res);
    return Paged.fromJson(json, PatientListItemDto.fromJson);
  }

  /// `GET /patients/{id}` — full profile + treatment timeline.
  Future<PatientDetailDto> getPatient(String id) async {
    final res = await _dio.get('/api/1/patients/$id');
    return unwrapData(
      res,
      (json) => PatientDetailDto.fromJson(json),
    );
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
      '/api/1/patients',
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
    final created = unwrapData(
      res,
      (json) => CreatedPatientDto.fromJson(json),
    );
    return created.id;
  }
}
