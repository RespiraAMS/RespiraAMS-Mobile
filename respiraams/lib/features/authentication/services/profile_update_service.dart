import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_client.dart';
import '../../../core/network/api_response.dart';
import '../models/doctor_profile_options.dart';

/// Thrown when the update saga is still running after the polling window.
class ProfileUpdateTimeoutException implements Exception {
  const ProfileUpdateTimeoutException();

  @override
  String toString() => 'ProfileUpdateTimeoutException';
}

/// Payload of the `request` form part of `POST /profile/update`.
///
/// Mirrors `UpdateProfileRequest` of the Saga API. The endpoint is a *full
/// replacement*, so every field of the profile has to be sent — not only the
/// ones the user edited.
class ProfileUpdatePayload {
  const ProfileUpdatePayload({
    required this.accountId,
    required this.doctorId,
    required this.email,
    required this.phone,
    required this.firstName,
    required this.lastName,
    required this.degrees,
    required this.academicTitle,
    required this.position,
    required this.gender,
    required this.citizenIdentificationNumber,
    required this.address,
    this.password,
    this.dateOfBirth,
  });

  final String accountId;
  final String doctorId;
  final String email;
  final String phone;

  /// New password, or `null` to keep the current one.
  final String? password;
  final String firstName;
  final String lastName;
  final List<DoctorDegree> degrees;
  final DoctorAcademicTitle academicTitle;
  final DoctorPosition position;
  final DoctorGender gender;
  final String citizenIdentificationNumber;

  /// `yyyy-MM-dd`, or `null` when the profile has no date of birth.
  final String? dateOfBirth;
  final String address;

  Map<String, dynamic> toJson() => {
        'accountId': accountId,
        'doctorId': doctorId,
        'email': email,
        'phone': phone,
        if (password != null && password!.isNotEmpty) 'password': password,
        'firstName': firstName,
        'lastName': lastName,
        'degrees': degrees.map((degree) => degree.wireValue).toList(),
        'academicTitle': academicTitle.wireValue,
        'position': position.wireValue,
        'gender': gender.wireValue,
        'citizenIdentificationNumber': citizenIdentificationNumber,
        'dateOfBirth': dateOfBirth,
        'address': address,
      };
}

/// Client of the profile-update saga (`/profile/update`).
///
/// `POST /profile/update` only starts the run and answers with the saga id;
/// `GET /profile/update/{id}` reports whether it is still in flight. Completed
/// runs are deleted from saga storage, so a `404` means the flow has ended
/// (successfully or not) — callers re-fetch the profile to verify.
class ProfileUpdateService {
  ProfileUpdateService(this._dio);

  final Dio _dio;

  /// Starts a run and returns its saga id.
  ///
  /// [avatarBytes] is optional; omit it to keep the current avatar.
  Future<String> start({
    required ProfileUpdatePayload payload,
    Uint8List? avatarBytes,
    String? avatarFileName,
  }) async {
    final form = FormData();
    form.fields.add(MapEntry('request', jsonEncode(payload.toJson())));
    if (avatarBytes != null && avatarBytes.isNotEmpty) {
      form.files.add(
        MapEntry(
          'avatar',
          MultipartFile.fromBytes(
            avatarBytes,
            filename: avatarFileName ?? 'avatar.jpg',
          ),
        ),
      );
    }

    final res = await _dio.post('/profile/update', data: form);
    return unwrapScalar<String>(res, (data) => data?.toString() ?? '');
  }

  /// Polls the status endpoint until the saga finishes (`404`) or [timeout]
  /// elapses. Throws [ApiException] when the run reports a failure reason and
  /// [ProfileUpdateTimeoutException] on timeout.
  ///
  /// The `POST` only publishes the start command, so the saga may not be
  /// persisted yet when the first poll happens. A 404 during [startGrace]
  /// therefore means "not visible yet", not "finished".
  Future<void> waitUntilFinished(
    String sagaId, {
    Duration timeout = const Duration(seconds: 40),
    Duration startGrace = const Duration(seconds: 5),
    Duration interval = const Duration(milliseconds: 400),
  }) async {
    final started = DateTime.now();
    final deadline = started.add(timeout);
    var sawStatus = false;

    while (DateTime.now().isBefore(deadline)) {
      try {
        final res = await _dio.get('/profile/update/$sagaId');
        final data = unwrapEnvelope(res);
        sawStatus = true;

        final step = data['step'];
        if (step == 'Failed') {
          final reason = data['failureReason'];
          throw ApiException(
            res.statusCode ?? 500,
            reason is String && reason.trim().isNotEmpty
                ? reason.trim()
                : 'The profile update failed.',
          );
        }
        if (step == 'Completed') return;
      } on DioException catch (e) {
        if (e.response?.statusCode == 404) {
          final elapsed = DateTime.now().difference(started);
          if (!sawStatus && elapsed < startGrace) {
            await Future<void>.delayed(interval);
            continue;
          }
          return;
        }
        rethrow;
      }
      await Future<void>.delayed(interval);
    }
    throw const ProfileUpdateTimeoutException();
  }
}

/// DI'd with the shared authenticated Dio.
final profileUpdateServiceProvider = Provider<ProfileUpdateService>(
  (ref) => ProfileUpdateService(ref.watch(apiClientProvider)),
);
