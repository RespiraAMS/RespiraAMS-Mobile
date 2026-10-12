enum ValueType { numeric, boolean, categorical, unknown }
enum VariableCategory { personalInformation, paraclinical, clinical, unknown }

class ClinicalVariable {
  final String id;
  final String name;
  final String code;
  final bool isRequired;
  final String? canonicalUnit;
  final ValueType valueType;
  final VariableCategory category;

  const ClinicalVariable({
    required this.id,
    required this.name,
    required this.code,
    required this.isRequired,
    this.canonicalUnit,
    required this.valueType,
    required this.category,
  });

  factory ClinicalVariable.fromJson(Map<String, dynamic> json) {
    return ClinicalVariable(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      code: json['code'] ?? '',
      isRequired: json['isRequired'] ?? false,
      canonicalUnit: json['canonicalUnit'],
      valueType: ClinicalVariable.parseValueType(json['valueType']),
      category: ClinicalVariable.parseCategory(json['category']),
    );
  }

  static ValueType parseValueType(String? type) {
    switch (type) {
      case 'Numeric': return ValueType.numeric;
      case 'Boolean': return ValueType.boolean;
      case 'Categorical': return ValueType.categorical;
      default: return ValueType.unknown;
    }
  }

  static VariableCategory parseCategory(String? cat) {
    switch (cat) {
      case 'PersonalInformation': return VariableCategory.personalInformation;
      case 'Paraclinical': return VariableCategory.paraclinical;
      case 'Clinical': return VariableCategory.clinical;
      default: return VariableCategory.unknown;
    }
  }
}

class VariableRange {
  final num min;
  final bool isMinExclusive;
  final num max;
  final bool isMaxExclusive;
  final String? unit;

  VariableRange({
    required this.min,
    required this.isMinExclusive,
    required this.max,
    required this.isMaxExclusive,
    this.unit,
  });

  factory VariableRange.fromJson(Map<String, dynamic> json) {
    return VariableRange(
      min: json['min'] ?? 0,
      isMinExclusive: json['isMinExclusive'] ?? false,
      max: json['max'] ?? 0,
      isMaxExclusive: json['isMaxExclusive'] ?? false,
      unit: json['unit'],
    );
  }

  String _formatNum(num value) {
    if (value is int || value == value.roundToDouble()) {
      return value.toInt().toString();
    }
    return value.toString();
  }

  String formatDisplay() {
    final minSymbol = isMinExclusive ? '>' : '≥';
    final maxSymbol = isMaxExclusive ? '<' : '≤';
    final unitStr = (unit != null && unit!.isNotEmpty) ? ' $unit' : '';
    
    final bool hasNoMax = max >= 7e28;
    final bool hasNoMin = min <= -7e28;

    final String minText = _formatNum(min);
    final String maxText = _formatNum(max);

    if (hasNoMin && hasNoMax) {
      return 'Không giới hạn$unitStr';
    } else if (hasNoMin) {
      return 'Giá trị $maxSymbol $maxText$unitStr';
    } else if (hasNoMax) {
      return 'Giá trị $minSymbol $minText$unitStr';
    } else {
      return 'Giá trị $minSymbol $minText và $maxSymbol $maxText$unitStr';
    }
  }
}

class ClinicalVariableDetail extends ClinicalVariable {
  final String description;
  final String? prerequisite;
  final VariableRange? acceptedRange;
  final VariableRange? normalRange;
  final List<String>? acceptedValues;

  const ClinicalVariableDetail({
    required super.id,
    required super.name,
    required super.code,
    required super.isRequired,
    super.canonicalUnit,
    required super.valueType,
    required super.category,
    required this.description,
    this.prerequisite,
    this.acceptedRange,
    this.normalRange,
    this.acceptedValues,
  });

  factory ClinicalVariableDetail.fromJson(Map<String, dynamic> json) {
    return ClinicalVariableDetail(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      code: json['code'] ?? '',
      isRequired: json['isRequired'] ?? false,
      canonicalUnit: json['canonicalUnit'],
      valueType: ClinicalVariable.parseValueType(json['valueType']), 
      category: ClinicalVariable.parseCategory(json['category']),
      description: json['description'] ?? '',
      prerequisite: json['prerequisite'],
      acceptedRange: json['acceptedRange'] != null ? VariableRange.fromJson(json['acceptedRange']) : null,
      normalRange: json['normalRange'] != null ? VariableRange.fromJson(json['normalRange']) : null,
      acceptedValues: (json['acceptedValues'] as List?)?.map((e) => e.toString()).toList(),
    );
  }
}