/// Validation rules shared by the forms. They mirror the backend validators
/// (`Respira.Patient.Domain.Utils.PhoneNumberValidator` /
/// `HealthInsuranceCardValidator`) so the app rejects exactly what the API
/// would reject, with a readable message instead of a raw problem+json error.
library;

final _vietnamesePhone = RegExp(r'^(0[35789]|84[35789]|\+84[35789])\d{8}$');
final _healthInsuranceCard = RegExp(r'^\d{10}$');
final _citizenId = RegExp(r'^\d{12}$');

/// `03/05/07/08/09xxxxxxxx`, or `84…`/`+84…` with 9 digits.
bool isValidVietnamesePhone(String value) =>
    _vietnamesePhone.hasMatch(value.trim());

/// New Vietnamese health insurance card number: exactly 10 digits.
bool isValidHealthInsuranceCard(String value) =>
    _healthInsuranceCard.hasMatch(value.trim());

/// Vietnam citizen identification number (CCCD): exactly 12 digits.
bool isValidCitizenId(String value) => _citizenId.hasMatch(value.trim());

/// `true` when the `yyyy-MM-dd` [isoDate] is a real date that is not in the
/// future (the backend rejects future dates of birth).
bool isNotFutureDate(String isoDate) {
  final parsed = DateTime.tryParse(isoDate);
  if (parsed == null) return false;
  final now = DateTime.now();
  return !parsed.isAfter(DateTime(now.year, now.month, now.day));
}
