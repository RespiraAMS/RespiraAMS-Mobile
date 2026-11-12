/// MIC (Minimum Inhibitory Concentration) category of an antibiogram
/// (`MicCategory` on the wire). Display labels are provided by
/// `l10n_labels.dart`.
enum MicCategory { susceptible, intermediate, resistant, unknown }

extension MicCategoryWire on MicCategory {
  /// PascalCase value expected by the API query string.
  String? get wireValue => switch (this) {
        MicCategory.susceptible => 'Susceptible',
        MicCategory.intermediate => 'Intermediate',
        MicCategory.resistant => 'Resistant',
        MicCategory.unknown => null,
      };
}

/// Pathogen referenced by an antibiogram (`PathogenResult`).
class AntibiogramPathogen {
  final String id;
  final String name;

  const AntibiogramPathogen({required this.id, required this.name});

  factory AntibiogramPathogen.fromJson(Map<String, dynamic> json) {
    return AntibiogramPathogen(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
    );
  }
}

/// Antibiotic referenced by an antibiogram (`AntibioticResult`).
class AntibiogramAntibiotic {
  final String id;
  final String name;
  final String antibioticGroupId;
  final String antibioticGroupName;

  /// AWaRe classification (`Access` | `Watch` | `Reserve`).
  final String classification;

  const AntibiogramAntibiotic({
    required this.id,
    required this.name,
    required this.antibioticGroupId,
    required this.antibioticGroupName,
    required this.classification,
  });

  factory AntibiogramAntibiotic.fromJson(Map<String, dynamic> json) {
    return AntibiogramAntibiotic(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      antibioticGroupId: json['antibioticGroupId'] ?? '',
      antibioticGroupName: json['antibioticGroupName'] ?? '',
      classification: json['classification'] ?? '',
    );
  }
}

/// Row of `GET /antibiograms` (`PagedAntibiogramItem`).
class Antibiogram {
  final String id;
  final AntibiogramPathogen pathogen;
  final MicCategory micCategory;
  final List<AntibiogramAntibiotic> antibiotics;

  const Antibiogram({
    required this.id,
    required this.pathogen,
    required this.micCategory,
    required this.antibiotics,
  });

  factory Antibiogram.fromJson(Map<String, dynamic> json) {
    final rawAntibiotics = json['antibiotics'] as List<dynamic>? ?? [];
    return Antibiogram(
      id: json['id'] ?? '',
      pathogen: AntibiogramPathogen.fromJson(
        json['pathogen'] as Map<String, dynamic>? ?? {},
      ),
      micCategory: _parseMic(json['micCategory']),
      antibiotics: rawAntibiotics
          .map((e) => AntibiogramAntibiotic.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  static MicCategory _parseMic(String? value) {
    switch (value) {
      case 'Susceptible':
        return MicCategory.susceptible;
      case 'Intermediate':
        return MicCategory.intermediate;
      case 'Resistant':
        return MicCategory.resistant;
      default:
        return MicCategory.unknown;
    }
  }
}
