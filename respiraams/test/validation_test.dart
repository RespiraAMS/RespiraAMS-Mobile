import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:respiraams/core/validation/input_formatters.dart';
import 'package:respiraams/core/validation/validators.dart';

/// The formatters and validators must mirror the backend rules
/// (`PhoneNumberValidator`, `HealthInsuranceCardValidator`) so the app never
/// sends a value the API would reject.
void main() {
  TextEditingValue typeInto(TextInputFormatter formatter, String text) =>
      formatter.formatEditUpdate(
        TextEditingValue.empty,
        TextEditingValue(
          text: text,
          selection: TextSelection.collapsed(offset: text.length),
        ),
      );

  group('date mask', () {
    final formatter = DateInputFormatter();

    test('inserts the slashes as the user types', () {
      expect(typeInto(formatter, '1').text, '1');
      expect(typeInto(formatter, '12').text, '12');
      expect(typeInto(formatter, '120').text, '12/0');
      expect(typeInto(formatter, '1204').text, '12/04');
      expect(typeInto(formatter, '12042000').text, '12/04/2000');
    });

    test('drops letters and caps at 8 digits', () {
      expect(typeInto(formatter, '12a04').text, '12/04');
      expect(typeInto(formatter, '120420009999').text, '12/04/2000');
    });
  });

  group('phone formatter', () {
    final formatter = PhoneInputFormatter();

    test('keeps digits and a leading plus', () {
      expect(typeInto(formatter, '0901234567').text, '0901234567');
      expect(typeInto(formatter, '+84901234567').text, '+84901234567');
      expect(typeInto(formatter, '090 123-4567').text, '0901234567');
    });

    test('drops a plus that is not leading', () {
      expect(typeInto(formatter, '090+123').text, '090123');
    });

    test('caps at 12 characters', () {
      expect(typeInto(formatter, '+8490123456789').text, '+84901234567');
    });
  });

  group('validators', () {
    test('accepts the Vietnamese mobile prefixes only', () {
      expect(isValidVietnamesePhone('0901234567'), isTrue);
      expect(isValidVietnamesePhone('0351234567'), isTrue);
      expect(isValidVietnamesePhone('+84901234567'), isTrue);
      expect(isValidVietnamesePhone('84901234567'), isTrue);

      expect(isValidVietnamesePhone('0201234567'), isFalse); // 02 is not mobile
      expect(isValidVietnamesePhone('090123456'), isFalse); // 9 digits
      expect(isValidVietnamesePhone('090 123 4567'), isFalse);
    });

    test('health insurance card is exactly 10 digits', () {
      expect(isValidHealthInsuranceCard('0123456789'), isTrue);
      expect(isValidHealthInsuranceCard('012345678'), isFalse);
      expect(isValidHealthInsuranceCard('01234567890'), isFalse);
      expect(isValidHealthInsuranceCard('01234567ab'), isFalse);
    });

    test('citizen id is exactly 12 digits', () {
      expect(isValidCitizenId('079123456789'), isTrue);
      expect(isValidCitizenId('07912345678'), isFalse);
    });

    test('rejects future dates of birth', () {
      final today = DateTime.now();
      final future = DateTime(today.year + 1, today.month, today.day);
      final past = DateTime(today.year - 30, today.month, today.day);

      String iso(DateTime value) =>
          '${value.year}-${value.month.toString().padLeft(2, '0')}-'
          '${value.day.toString().padLeft(2, '0')}';

      expect(isNotFutureDate(iso(past)), isTrue);
      expect(isNotFutureDate(iso(today)), isTrue);
      expect(isNotFutureDate(iso(future)), isFalse);
    });
  });
}
