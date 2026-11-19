import 'package:flutter/material.dart';

/// Opens the platform date picker and returns the chosen date formatted as
/// `dd/MM/yyyy`, or `null` when the doctor dismisses it.
///
/// [currentValue] is parsed first so re-opening lands on the date already in
/// the field; empty or invalid values fall back to 30 years before [lastDate].
Future<String?> pickDateAsDdMmYyyy(
  BuildContext context, {
  String currentValue = '',
  DateTime? firstDate,
  DateTime? lastDate,
  String? helpText,
}) async {
  final now = DateTime.now();
  final lower = firstDate ?? DateTime(1900);
  final upper = lastDate ?? DateTime(now.year, now.month, now.day);

  var initial = _parseDdMmYyyy(currentValue) ??
      DateTime(upper.year - 30, upper.month, upper.day);
  if (initial.isBefore(lower)) initial = lower;
  if (initial.isAfter(upper)) initial = upper;

  final picked = await showDatePicker(
    context: context,
    initialDate: initial,
    firstDate: lower,
    lastDate: upper,
    helpText: helpText,
  );
  if (picked == null) return null;

  final dd = picked.day.toString().padLeft(2, '0');
  final mm = picked.month.toString().padLeft(2, '0');
  return '$dd/$mm/${picked.year}';
}

/// Strict `dd/MM/yyyy` parser: returns `null` for impossible calendar dates
/// such as `31/02/2000`.
DateTime? _parseDdMmYyyy(String value) {
  final match = RegExp(r'^(\d{1,2})/(\d{1,2})/(\d{4})$').firstMatch(value.trim());
  if (match == null) return null;

  final day = int.parse(match.group(1)!);
  final month = int.parse(match.group(2)!);
  final year = int.parse(match.group(3)!);

  final date = DateTime(year, month, day);
  if (date.year != year || date.month != month || date.day != day) return null;
  return date;
}
