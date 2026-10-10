enum DiseaseSeverity { mild, moderate, severe, unknown }
enum TreatmentSite { outpatient, inpatient, intensiveCareUnit, unknown }

class SuspectedCause {
  final String id;
  final String pathogenId;
  final String pathogenName;
  final DiseaseSeverity severity;
  final TreatmentSite treatmentSite;

  const SuspectedCause({
    required this.id,
    required this.pathogenId,
    required this.pathogenName,
    required this.severity,
    required this.treatmentSite,
  });

  factory SuspectedCause.fromJson(Map<String, dynamic> json) {
    return SuspectedCause(
      id: json['id'] ?? '',
      pathogenId: json['pathogenId'] ?? '',
      pathogenName: json['pathogenName'] ?? '',
      severity: _parseSeverity(json['severity']),
      treatmentSite: _parseSite(json['treatmentSite']),
    );
  }

  static DiseaseSeverity _parseSeverity(String? sev) {
    switch (sev) {
      case 'Mild': return DiseaseSeverity.mild;
      case 'Moderate': return DiseaseSeverity.moderate;
      case 'Severe': return DiseaseSeverity.severe;
      default: return DiseaseSeverity.unknown;
    }
  }

  static TreatmentSite _parseSite(String? site) {
    switch (site) {
      case 'Outpatient': return TreatmentSite.outpatient;
      case 'Inpatient': return TreatmentSite.inpatient;
      case 'IntensiveCareUnit': return TreatmentSite.intensiveCareUnit;
      default: return TreatmentSite.unknown;
    }
  }
}
