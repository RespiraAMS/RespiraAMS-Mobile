class Pathogen {
  final String id;
  final String name;
  final String description;
  final bool isAtypical;
  const Pathogen({
    required this.id,
    required this.name,
    required this.description,
    required this.isAtypical,
  });

  factory Pathogen.fromJson(Map<String, dynamic> json) {
    return Pathogen(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      isAtypical: json['isAtypical'] ?? false,
    );
  }
}