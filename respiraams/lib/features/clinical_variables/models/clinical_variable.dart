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
      valueType: _parseValueType(json['valueType']),
      category: _parseCategory(json['category']),
    );
  }

  static ValueType _parseValueType(String? type) {
    switch (type) {
      case 'Numeric': return ValueType.numeric;
      case 'Boolean': return ValueType.boolean;
      case 'Categorical': return ValueType.categorical;
      default: return ValueType.unknown;
    }
  }

  static VariableCategory _parseCategory(String? cat) {
    switch (cat) {
      case 'PersonalInformation': return VariableCategory.personalInformation;
      case 'Paraclinical': return VariableCategory.paraclinical;
      case 'Clinical': return VariableCategory.clinical;
      default: return VariableCategory.unknown;
    }
  }
}