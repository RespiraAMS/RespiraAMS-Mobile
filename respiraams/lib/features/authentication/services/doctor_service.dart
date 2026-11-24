import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_client.dart';
import '../../../core/network/api_response.dart';

/// Doctor profile endpoints of Respira.Doctor (`/doctors/*`).
///
/// The mobile app is doctor-facing only, so the signed-in profile is always
/// resolved through `GET /doctors/me`; the roster endpoint (`GET /doctors`)
/// is Admin-only and must not be used here.
///
/// Paths are relative to [kApiRootUrl] (`/api/v1`).
class DoctorService {
  DoctorService(this._dio);

  final Dio _dio;

  /// `GET /doctors/me` — profile of the authenticated doctor.
  ///
  /// The JWT carries the *account* id; this endpoint maps it to the profile,
  /// so the app never has to walk the roster.
  ///
  /// Returns `null` when the account has no doctor profile (HTTP 404).
  Future<DoctorProfileDto?> getMe() async {
    try {
      final res = await _dio.get('/doctors/me');
      return unwrapData(res, DoctorProfileDto.fromJson);
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) return null;
      rethrow;
    }
  }

  /// `GET /doctors/{id}` — profile by its *profile* id.
  Future<DoctorProfileDto> getDoctor(String id) async {
    final res = await _dio.get('/doctors/$id');
    return unwrapData(res, DoctorProfileDto.fromJson);
  }

  /// `GET /doctors/subordinates` — paged roster of the doctors managed by the
  /// signed-in head of department.
  ///
  /// HeadDepartmentDoctor-only endpoint; used to resolve the doctor names that
  /// appear in the analysis reports (the full roster is Admin-only).
  Future<List<DoctorProfileDto>> getSubordinates({
    int page = 1,
    int size = 100,
  }) async {
    final res = await _dio.get(
      '/doctors/subordinates',
      queryParameters: {'page': page, 'size': size},
    );
    final data = unwrapEnvelope(res);
    final items = data['items'] as List<dynamic>? ?? [];
    return items
        .map((e) => DoctorProfileDto.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}

/// Mirrors `Respira.Doctor...GetById.Result.DoctorResult` /
/// `DoctorProfileItem`. Account-level fields (`email`, `phone`,
/// `avatarUrl`) are only enriched on the list endpoints.
class DoctorProfileDto {
  DoctorProfileDto({
    required this.id,
    required this.accountId,
    required this.firstName,
    required this.lastName,
    this.degrees = const [],
    this.role,
    this.academicTitle,
    this.position,
    this.gender,
    this.citizenIdentificationNumber,
    this.address,
    this.dateOfBirth,
    this.mediaId,
    this.email,
    this.phone,
    this.avatarUrl,
  });

  factory DoctorProfileDto.fromJson(Map<String, dynamic> json) {
    final first = json['firstName'] as String? ?? '';
    final last = json['lastName'] as String? ?? '';
    return DoctorProfileDto(
      id: json['id'] as String? ?? '',
      accountId: json['accountId'] as String? ?? '',
      firstName: first,
      lastName: last,
      degrees:
          (json['degrees'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      role: json['role'] as String?,
      academicTitle: json['academicTitle'] as String?,
      position: json['position'] as String?,
      gender: json['gender'] as String?,
      citizenIdentificationNumber:
          json['citizenIdentificationNumber'] as String?,
      address: json['address'] as String?,
      dateOfBirth: json['dateOfBirth'] as String?,
      mediaId: json['mediaId'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
    );
  }

  final String id;

  /// Account identifier carried by the JWT's `sub` / `nameid` claim.
  final String accountId;
  final String firstName;
  final String lastName;
  final List<String> degrees;
  final String? role;
  final String? academicTitle;
  final String? position;
  final String? gender;
  final String? citizenIdentificationNumber;
  final String? address;

  /// ISO-8601 date-time (`yyyy-MM-ddTHH:mm:ss…`) or `null`.
  final String? dateOfBirth;
  final String? mediaId;
  final String? email;
  final String? phone;
  final String? avatarUrl;

  /// Display name without academic degrees.
  String get fullName =>
      [firstName, lastName].where((p) => p.trim().isNotEmpty).join(' ');
}

/// DI'd with the shared authenticated Dio.
final doctorServiceProvider = Provider<DoctorService>(
  (ref) => DoctorService(ref.watch(apiClientProvider)),
);
