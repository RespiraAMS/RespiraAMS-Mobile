class PathogenSummary {
  final String id;
  final String name;

  const PathogenSummary({required this.id, required this.name});

  factory PathogenSummary.fromJson(Map<String, dynamic> json) {
    return PathogenSummary(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
    );
  }
}