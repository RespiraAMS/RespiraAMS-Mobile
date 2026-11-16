class MetricCriterion {
  final String id;
  final String name;
  final String formula;

  const MetricCriterion({
    required this.id,
    required this.name,
    required this.formula,
  });

  factory MetricCriterion.fromJson(Map<String, dynamic> json) {
    return MetricCriterion(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      formula: json['formula'] ?? '',
    );
  }
}

class MetricRule {
  final String id;
  final MetricCriterion criterion;
  final String? scoreFunction;
  final bool? isMajorRule;

  const MetricRule({
    required this.id,
    required this.criterion,
    this.scoreFunction,
    this.isMajorRule,
  });

  factory MetricRule.fromJson(Map<String, dynamic> json) {
    return MetricRule(
      id: json['id'] ?? '',
      criterion: MetricCriterion.fromJson(json['criterion'] ?? {}),
      scoreFunction: json['scoreFunction'],
      isMajorRule: json['isMajorRule'],
    );
  }
}

class ClinicalMetric {
  final String id;
  final String name;
  final String code;
  final String description;
  final String version;
  final String publisher;
  final bool isApplied;

  const ClinicalMetric({
    required this.id,
    required this.name,
    required this.code,
    required this.description,
    required this.version,
    required this.publisher,
    required this.isApplied,
  });

  factory ClinicalMetric.fromJson(Map<String, dynamic> json) {
    return ClinicalMetric(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      code: json['code'] ?? '',
      description: json['description'] ?? '',
      version: json['version'] ?? '',
      publisher: json['publisher'] ?? '',
      isApplied: json['isApplied'] ?? false,
    );
  }
}

class ClinicalMetricDetail extends ClinicalMetric {
  final List<MetricRule> rules;

  const ClinicalMetricDetail({
    required super.id,
    required super.name,
    required super.code,
    required super.description,
    required super.version,
    required super.publisher,
    required super.isApplied,
    required this.rules,
  });

  factory ClinicalMetricDetail.fromJson(Map<String, dynamic> json) {
    return ClinicalMetricDetail(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      code: json['code'] ?? '',
      description: json['description'] ?? '',
      version: json['version'] ?? '',
      publisher: json['publisher'] ?? '',
      isApplied: json['isApplied'] ?? false,
      rules: (json['rules'] as List<dynamic>?)
              ?.map((e) => MetricRule.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}