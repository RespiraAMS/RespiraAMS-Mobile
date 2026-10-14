class Criterion {
  final String id;
  final String name;
  final String formula;

  const Criterion({
    required this.id,
    required this.name,
    required this.formula,
  });

  factory Criterion.fromJson(Map<String, dynamic> json) {
    return Criterion(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      formula: json['formula'] ?? '',
    );
  }
}