class AntibioticGroupSummary {
  final String id;
  final String name;

  const AntibioticGroupSummary({required this.id, required this.name});

  factory AntibioticGroupSummary.fromJson(Map<String, dynamic> json) {
    return AntibioticGroupSummary(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
    );
  }
}