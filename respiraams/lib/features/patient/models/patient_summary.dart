import 'package:freezed_annotation/freezed_annotation.dart';

import 'patient.dart';

part 'patient_summary.freezed.dart';
part 'patient_summary.g.dart';

/// Clinical status shown on patient list cards (dot + label, never color
/// alone §12). Display labels are provided by `l10n_labels.dart`.
enum PatientStatus { treating, recovered, deceased }

/// Lightweight row model of the patient list screen.
@freezed
class PatientSummary with _$PatientSummary {
  const factory PatientSummary({
    required String id,
    required String name,
    required String code,
    required Gender gender,
    required int age,
    required PatientStatus status,
  }) = _PatientSummary;

  factory PatientSummary.fromJson(Map<String, dynamic> json) =>
      _$PatientSummaryFromJson(json);
}
