/// CAP severity of a treatment protocol (`Severity` on the wire). Display
/// labels are provided by `l10n_labels.dart`.
enum ProtocolSeverity { mild, moderate, severe, unknown }

/// Treatment site of a treatment protocol (`TreatmentSite` on the wire).
enum ProtocolTreatmentSite {
  outpatient,
  inpatient,
  intensiveCareUnit,
  unknown,
}

extension ProtocolSeverityWire on ProtocolSeverity {
  /// PascalCase value expected by the API query string.
  String? get wireValue => switch (this) {
        ProtocolSeverity.mild => 'Mild',
        ProtocolSeverity.moderate => 'Moderate',
        ProtocolSeverity.severe => 'Severe',
        ProtocolSeverity.unknown => null,
      };
}

extension ProtocolTreatmentSiteWire on ProtocolTreatmentSite {
  /// PascalCase value expected by the API query string.
  String? get wireValue => switch (this) {
        ProtocolTreatmentSite.outpatient => 'Outpatient',
        ProtocolTreatmentSite.inpatient => 'Inpatient',
        ProtocolTreatmentSite.intensiveCareUnit => 'IntensiveCareUnit',
        ProtocolTreatmentSite.unknown => null,
      };
}

/// Pathogen referenced by a treatment protocol (`PathogenResult`).
class ProtocolPathogen {
  final String id;
  final String name;

  const ProtocolPathogen({required this.id, required this.name});

  factory ProtocolPathogen.fromJson(Map<String, dynamic> json) {
    return ProtocolPathogen(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
    );
  }
}

/// Criterion attached to a treatment protocol (`CriterionResult`).
class ProtocolCriterion {
  final String id;
  final String name;
  final String formula;

  const ProtocolCriterion({
    required this.id,
    required this.name,
    required this.formula,
  });

  factory ProtocolCriterion.fromJson(Map<String, dynamic> json) {
    return ProtocolCriterion(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      formula: json['formula'] ?? '',
    );
  }
}

/// Antibiotic of a protocol combination (`AntibioticResult`).
class ProtocolAntibiotic {
  final String id;
  final String name;
  final String antibioticGroupId;
  final String antibioticGroupName;

  /// AWaRe classification (`Access` | `Watch` | `Reserve`).
  final String classification;

  const ProtocolAntibiotic({
    required this.id,
    required this.name,
    required this.antibioticGroupId,
    required this.antibioticGroupName,
    required this.classification,
  });

  factory ProtocolAntibiotic.fromJson(Map<String, dynamic> json) {
    return ProtocolAntibiotic(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      antibioticGroupId: json['antibioticGroupId'] ?? '',
      antibioticGroupName: json['antibioticGroupName'] ?? '',
      classification: json['classification'] ?? '',
    );
  }
}

/// Row of `GET /treatment-protocols` (`TreatmentProtocolItem`).
class TreatmentProtocol {
  final String id;
  final ProtocolSeverity severity;
  final ProtocolTreatmentSite treatmentSite;

  /// Each inner list is one antibiotic combination of the protocol.
  final List<List<ProtocolAntibiotic>> treatments;
  final List<ProtocolPathogen> pathogens;
  final List<ProtocolCriterion> criteria;
  final String version;
  final String publisher;
  final bool isApplied;

  const TreatmentProtocol({
    required this.id,
    required this.severity,
    required this.treatmentSite,
    required this.treatments,
    required this.pathogens,
    required this.criteria,
    required this.version,
    required this.publisher,
    required this.isApplied,
  });

  factory TreatmentProtocol.fromJson(Map<String, dynamic> json) {
    final rawTreatments = json['treatments'] as List<dynamic>? ?? [];
    final rawPathogens = json['pathogens'] as List<dynamic>? ?? [];
    final rawCriteria = json['criteria'] as List<dynamic>? ?? [];

    return TreatmentProtocol(
      id: json['id'] ?? '',
      severity: _parseSeverity(json['severity']),
      treatmentSite: _parseSite(json['treatmentSite']),
      treatments: rawTreatments
          .map(
            (combination) => (combination as List<dynamic>)
                .map(
                  (medicine) => ProtocolAntibiotic.fromJson(
                    medicine as Map<String, dynamic>,
                  ),
                )
                .toList(),
          )
          .toList(),
      pathogens: rawPathogens
          .map((e) => ProtocolPathogen.fromJson(e as Map<String, dynamic>))
          .toList(),
      criteria: rawCriteria
          .map((e) => ProtocolCriterion.fromJson(e as Map<String, dynamic>))
          .toList(),
      version: json['version'] ?? '',
      publisher: json['publisher'] ?? '',
      isApplied: json['isApplied'] ?? false,
    );
  }

  static ProtocolSeverity _parseSeverity(String? value) {
    switch (value) {
      case 'Mild':
        return ProtocolSeverity.mild;
      case 'Moderate':
        return ProtocolSeverity.moderate;
      case 'Severe':
        return ProtocolSeverity.severe;
      default:
        return ProtocolSeverity.unknown;
    }
  }

  static ProtocolTreatmentSite _parseSite(String? value) {
    switch (value) {
      case 'Outpatient':
        return ProtocolTreatmentSite.outpatient;
      case 'Inpatient':
        return ProtocolTreatmentSite.inpatient;
      case 'IntensiveCareUnit':
        return ProtocolTreatmentSite.intensiveCareUnit;
      default:
        return ProtocolTreatmentSite.unknown;
    }
  }
}
