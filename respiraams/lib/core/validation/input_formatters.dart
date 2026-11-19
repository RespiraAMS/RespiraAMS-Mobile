import 'package:flutter/services.dart';

/// Input formatters shared by the patient, next-of-kin and doctor-profile
/// forms. They keep the typed value inside the shape the backend validates, so
/// a bad character or an over-long value can never be entered in the first
/// place.

/// `dd/MM/yyyy`: digits only, slashes inserted automatically, capped at 10.
class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    final limited = digits.length > 8 ? digits.substring(0, 8) : digits;

    final buffer = StringBuffer();
    for (var i = 0; i < limited.length; i++) {
      if (i == 2 || i == 4) buffer.write('/');
      buffer.write(limited[i]);
    }
    final text = buffer.toString();

    // Keep the caret next to the digit the user just typed.
    final rawOffset = newValue.selection.baseOffset;
    final caretDigits = rawOffset < 0
        ? limited.length
        : newValue.text
            .substring(0, rawOffset.clamp(0, newValue.text.length).toInt())
            .replaceAll(RegExp(r'\D'), '')
            .length;
    final offset = _offsetForDigits(caretDigits).clamp(0, text.length).toInt();

    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: offset),
    );
  }

  int _offsetForDigits(int digitCount) {
    if (digitCount <= 2) return digitCount;
    if (digitCount <= 4) return digitCount + 1;
    return digitCount + 2;
  }
}

/// Vietnamese phone number: digits plus an optional leading `+` (`+84…`),
/// capped at 12 characters.
class PhoneInputFormatter extends TextInputFormatter {
  static const _maxLength = 12;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var text = newValue.text.replaceAll(RegExp(r'[^0-9+]'), '');
    final hasPlus = text.startsWith('+');
    text = text.replaceAll('+', '');
    if (hasPlus) text = '+$text';
    if (text.length > _maxLength) text = text.substring(0, _maxLength);

    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}

/// `dd/MM/yyyy` mask.
List<TextInputFormatter> dateInputFormatters() => [DateInputFormatter()];

/// Vietnamese phone number (10 local digits, or `84`/`+84` + 9 digits).
List<TextInputFormatter> phoneInputFormatters() => [PhoneInputFormatter()];

/// Digits only, capped at [max] characters (health insurance card, citizen id).
List<TextInputFormatter> digitsInputFormatters(int max) => [
      FilteringTextInputFormatter.digitsOnly,
      LengthLimitingTextInputFormatter(max),
    ];

/// Person names: letters (Vietnamese diacritics included), spaces and the few
/// separators Vietnamese names use.
List<TextInputFormatter> personNameInputFormatters({int max = 50}) => [
      FilteringTextInputFormatter.allow(
        RegExp(r"[\p{L}\s.'-]", unicode: true),
      ),
      LengthLimitingTextInputFormatter(max),
    ];

/// Medical record codes: letters, digits, `-` and `_`.
List<TextInputFormatter> codeInputFormatters({int max = 30}) => [
      FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9\-_]')),
      LengthLimitingTextInputFormatter(max),
    ];

/// Free-text addresses: no character restriction, only a length cap.
List<TextInputFormatter> addressInputFormatters({int max = 255}) => [
      LengthLimitingTextInputFormatter(max),
    ];
