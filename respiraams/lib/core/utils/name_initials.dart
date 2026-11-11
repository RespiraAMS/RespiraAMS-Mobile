/// Builds a short avatar glyph from a person's display name.
///
/// The local auth flow stores the email as the doctor name, so e-mails are
/// reduced to their local part (e.g. `bs.minh@respira.vn` → `BM`). Names
/// without spaces fall back to their first two runes (`Minh` → `MI`).
String initialsFor(String name) {
  var value = name.trim();
  if (value.isEmpty) return 'BS';
  if (value.contains('@')) {
    value = value.split('@').first.replaceAll(RegExp(r'[._-]+'), ' ');
  }

  final parts = value
      .split(RegExp(r'\s+'))
      .where((part) => part.isNotEmpty)
      .toList();
  if (parts.isEmpty) return 'BS';

  String firstChar(String part) =>
      String.fromCharCode(part.runes.first).toUpperCase();

  if (parts.length == 1) {
    final part = parts.first;
    return part.runes.length >= 2
        ? String.fromCharCodes(part.runes.take(2)).toUpperCase()
        : firstChar(part);
  }
  return '${firstChar(parts.last)}${firstChar(parts.first)}';
}
