import 'package:freezed_annotation/freezed_annotation.dart';

import 'patient_dtos.dart';

part 'patient.freezed.dart';
part 'patient.g.dart';

/// Patient gender with Vietnamese display labels.
enum Gender {
  nam('Nam'),
  nu('Nữ');

  const Gender(this.displayName);

  final String displayName;
}

@freezed
class Patient with _$Patient {
  const factory Patient({
    @Default('') String id,
    required String name,
    required String code,

    /// Date of birth, formatted dd/MM/yyyy.
    required String dob,
    required Gender gender,

    /// Health insurance number (Số thẻ BHYT).
    required String insurance,
    required String address,

    /// Height in centimeters, from `GET /patients/{id}`.
    double? heightCm,

    /// Weight in kilograms, from `GET /patients/{id}`.
    double? weightKg,
  }) = _Patient;

  factory Patient.fromJson(Map<String, dynamic> json) =>
      _$PatientFromJson(json);

  /// Builds the view model from the real `GET /patients/{id}` payload.
  static Patient fromDetail(PatientDetailDto dto) => Patient(
        id: dto.id,
        name: dto.fullName,
        code: dto.medicalRecordCode,
        dob: _isoToDdMmYyyy(dto.dateOfBirth),
        gender: dto.gender == 'Male' ? Gender.nam : Gender.nu,
        insurance: dto.healthInsuranceCard,
        address: dto.address,
        heightCm: dto.height,
        weightKg: dto.weight,
      );
}

/// `yyyy-MM-dd` (API DateOnly) → `dd/MM/yyyy` (prototype format).
String _isoToDdMmYyyy(String iso) {
  final parts = iso.split('-');
  if (parts.length != 3) return iso;
  return '${parts[2].padLeft(2, '0')}/${parts[1].padLeft(2, '0')}/${parts[0]}';
}

/// Strict `dd/MM/yyyy` (prototype format) → `yyyy-MM-dd` (API DateOnly).
///
/// Returns `null` unless [input] is a real calendar date in that exact
/// format (4-digit year, no `31/02`-style overflow). This lets the form
/// reject bad input with a friendly message instead of forwarding it to
/// the backend, whose `DateOnly` binder answers with an unreadable
/// `application/problem+json` error.
String? ddMmYyyyToIsoDate(String input) {
  final match =
      RegExp(r'^(\d{1,2})/(\d{1,2})/(\d{4})$').firstMatch(input.trim());
  if (match == null) return null;

  final day = int.parse(match.group(1)!);
  final month = int.parse(match.group(2)!);
  final year = int.parse(match.group(3)!);

  final date = DateTime(year, month, day);
  if (date.year != year || date.month != month || date.day != day) return null;

  final dd = day.toString().padLeft(2, '0');
  final mm = month.toString().padLeft(2, '0');
  return '$year-$mm-$dd';
}
