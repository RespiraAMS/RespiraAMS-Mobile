class RiskFactorPathogen {
  final String id;
  final String name;
  final bool? isAtypical;

  const RiskFactorPathogen({
    required this.id,
    required this.name,
    this.isAtypical,
  });

  factory RiskFactorPathogen.fromJson(Map<String, dynamic> json) {
    return RiskFactorPathogen(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      isAtypical: json['isAtypical'],
    );
  }
}

class RiskFactorCriterion {
  final String id;
  final String name;
  final String formula;

  const RiskFactorCriterion({
    required this.id,
    required this.name,
    required this.formula,
  });

  factory RiskFactorCriterion.fromJson(Map<String, dynamic> json) {
    return RiskFactorCriterion(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      formula: json['formula'] ?? '',
    );
  }
}

class RiskFactor {
  final String id;
  final RiskFactorPathogen pathogen;
  final RiskFactorCriterion criterion;

  /// A critical factor is more credible than a non-critical one when
  /// assessing infection risk (`PagedRiskFactorItem.IsCriticalFactor`).
  final bool isCriticalFactor;

  const RiskFactor({
    required this.id,
    required this.pathogen,
    required this.criterion,
    this.isCriticalFactor = false,
  });

  factory RiskFactor.fromJson(Map<String, dynamic> json) {
    return RiskFactor(
      id: json['id'] ?? '',
      pathogen: RiskFactorPathogen.fromJson(json['pathogen'] ?? {}),
      criterion: RiskFactorCriterion.fromJson(json['criterion'] ?? {}),
      isCriticalFactor: json['isCriticalFactor'] ?? false,
    );
  }
}
