// DTOs of `GET /analysis/reports` (Respira.Analysis).
//
// A report is an immutable snapshot: every number below was computed once
// when the report was created, so it never drifts when patients change.

DateTime? _parseDate(Object? value) {
  if (value is! String || value.isEmpty) return null;
  return DateTime.tryParse(value)?.toLocal();
}

int _int(Object? value) => value is num ? value.toInt() : 0;

double _rate(int numerator, int denominator) =>
    denominator <= 0 ? 0 : numerator / denominator;

/// `dd/MM/yyyy`, or a dash when the value is missing.
String analysisDate(DateTime? value) {
  if (value == null) return '—';
  final dd = value.day.toString().padLeft(2, '0');
  final mm = value.month.toString().padLeft(2, '0');
  return '$dd/$mm/${value.year}';
}

/// `dd/MM/yyyy · HH:mm`, or a dash when the value is missing.
String analysisDateTime(DateTime? value) {
  if (value == null) return '—';
  final hh = value.hour.toString().padLeft(2, '0');
  final min = value.minute.toString().padLeft(2, '0');
  return '${analysisDate(value)} · $hh:$min';
}

/// Row of `GET /analysis/reports` (`AnalysisReportListItem`).
class AnalysisReportListItem {
  const AnalysisReportListItem({
    required this.analysisId,
    required this.doctorId,
    required this.start,
    required this.end,
    required this.totalTreatmentPlans,
    required this.totalPatients,
    required this.totalAdherentPlans,
    required this.totalNonAdherentPlans,
    required this.totalPendingReviewPlans,
    required this.totalDeceasedPatients,
    required this.totalRecoveredPatients,
    required this.totalOtherOutcomePatients,
    required this.createdAt,
  });

  factory AnalysisReportListItem.fromJson(Map<String, dynamic> json) {
    return AnalysisReportListItem(
      analysisId: json['analysisId'] as String? ?? '',
      doctorId: json['doctorId'] as String?,
      start: _parseDate(json['start']),
      end: _parseDate(json['end']),
      totalTreatmentPlans: _int(json['totalTreatmentPlans']),
      totalPatients: _int(json['totalPatients']),
      totalAdherentPlans: _int(json['totalAdherentPlans']),
      totalNonAdherentPlans: _int(json['totalNonAdherentPlans']),
      totalPendingReviewPlans: _int(json['totalPendingReviewPlans']),
      totalDeceasedPatients: _int(json['totalDeceasedPatients']),
      totalRecoveredPatients: _int(json['totalRecoveredPatients']),
      totalOtherOutcomePatients: _int(json['totalOtherOutcomePatients']),
      createdAt: _parseDate(json['createdAt']),
    );
  }

  final String analysisId;

  /// `null` for a system-wide report (all doctors).
  final String? doctorId;
  final DateTime? start;
  final DateTime? end;
  final int totalTreatmentPlans;
  final int totalPatients;
  final int totalAdherentPlans;
  final int totalNonAdherentPlans;
  final int totalPendingReviewPlans;
  final int totalDeceasedPatients;
  final int totalRecoveredPatients;
  final int totalOtherOutcomePatients;
  final DateTime? createdAt;

  double get adherentRate => _rate(totalAdherentPlans, totalTreatmentPlans);
  double get pendingRate =>
      _rate(totalPendingReviewPlans, totalTreatmentPlans);
}

/// Medicine aggregate of one doctor (`MedicineAnalysisSummary`).
class AnalysisMedicineSummary {
  const AnalysisMedicineSummary({
    required this.medicineId,
    required this.name,
    required this.classification,
    required this.totalTreatmentPlans,
    required this.totalAdherentPlans,
    required this.totalNonAdherentPlans,
    required this.totalPendingReviewPlans,
  });

  factory AnalysisMedicineSummary.fromJson(Map<String, dynamic> json) {
    return AnalysisMedicineSummary(
      medicineId: json['medicineId'] as String? ?? '',
      name: json['name'] as String? ?? '',
      classification: json['classification'] as String? ?? '',
      totalTreatmentPlans: _int(json['totalTreatmentPlans']),
      totalAdherentPlans: _int(json['totalAdherentPlans']),
      totalNonAdherentPlans: _int(json['totalNonAdherentPlans']),
      totalPendingReviewPlans: _int(json['totalPendingReviewPlans']),
    );
  }

  final String medicineId;
  final String name;
  final String classification;
  final int totalTreatmentPlans;
  final int totalAdherentPlans;
  final int totalNonAdherentPlans;
  final int totalPendingReviewPlans;

  double get adherentRate => _rate(totalAdherentPlans, totalTreatmentPlans);
}

/// Per-doctor aggregate (`DoctorMedicineAnalysisSummary`).
class AnalysisDoctorSummary {
  const AnalysisDoctorSummary({
    required this.doctorId,
    required this.totalPatients,
    required this.totalTreatmentPlans,
    required this.totalAdherentPlans,
    required this.totalNonAdherentPlans,
    required this.totalPendingReviewPlans,
    required this.medicines,
  });

  factory AnalysisDoctorSummary.fromJson(Map<String, dynamic> json) {
    final rawMedicines = json['medicines'] as List<dynamic>? ?? [];
    return AnalysisDoctorSummary(
      doctorId: json['doctorId'] as String? ?? '',
      totalPatients: _int(json['totalPatients']),
      totalTreatmentPlans: _int(json['totalTreatmentPlans']),
      totalAdherentPlans: _int(json['totalAdherentPlans']),
      totalNonAdherentPlans: _int(json['totalNonAdherentPlans']),
      totalPendingReviewPlans: _int(json['totalPendingReviewPlans']),
      medicines: rawMedicines
          .map(
            (item) =>
                AnalysisMedicineSummary.fromJson(item as Map<String, dynamic>),
          )
          .toList(),
    );
  }

  final String doctorId;
  final int totalPatients;
  final int totalTreatmentPlans;
  final int totalAdherentPlans;
  final int totalNonAdherentPlans;
  final int totalPendingReviewPlans;
  final List<AnalysisMedicineSummary> medicines;

  double get adherentRate => _rate(totalAdherentPlans, totalTreatmentPlans);
}

/// `GET /analysis/reports/{analysisId}` (`AnalysisReportResult`).
class AnalysisReport {
  const AnalysisReport({
    required this.analysisId,
    required this.doctorId,
    required this.start,
    required this.end,
    required this.totalTreatmentPlans,
    required this.totalPatients,
    required this.totalAdherentPlans,
    required this.totalNonAdherentPlans,
    required this.totalPendingReviewPlans,
    required this.totalDeceasedPatients,
    required this.totalRecoveredPatients,
    required this.totalOtherOutcomePatients,
    required this.doctors,
  });

  factory AnalysisReport.fromJson(Map<String, dynamic> json) {
    final rawDoctors = json['doctors'] as List<dynamic>? ?? [];
    return AnalysisReport(
      analysisId: json['analysisId'] as String? ?? '',
      doctorId: json['doctorId'] as String?,
      start: _parseDate(json['start']),
      end: _parseDate(json['end']),
      totalTreatmentPlans: _int(json['totalTreatmentPlans']),
      totalPatients: _int(json['totalPatients']),
      totalAdherentPlans: _int(json['totalAdherentPlans']),
      totalNonAdherentPlans: _int(json['totalNonAdherentPlans']),
      totalPendingReviewPlans: _int(json['totalPendingReviewPlans']),
      totalDeceasedPatients: _int(json['totalDeceasedPatients']),
      totalRecoveredPatients: _int(json['totalRecoveredPatients']),
      totalOtherOutcomePatients: _int(json['totalOtherOutcomePatients']),
      doctors: rawDoctors
          .map(
            (item) =>
                AnalysisDoctorSummary.fromJson(item as Map<String, dynamic>),
          )
          .toList(),
    );
  }

  final String analysisId;
  final String? doctorId;
  final DateTime? start;
  final DateTime? end;
  final int totalTreatmentPlans;
  final int totalPatients;
  final int totalAdherentPlans;
  final int totalNonAdherentPlans;
  final int totalPendingReviewPlans;
  final int totalDeceasedPatients;
  final int totalRecoveredPatients;
  final int totalOtherOutcomePatients;
  final List<AnalysisDoctorSummary> doctors;

  double get adherentRate => _rate(totalAdherentPlans, totalTreatmentPlans);
  double get nonAdherentRate =>
      _rate(totalNonAdherentPlans, totalTreatmentPlans);
  double get pendingRate =>
      _rate(totalPendingReviewPlans, totalTreatmentPlans);
}
