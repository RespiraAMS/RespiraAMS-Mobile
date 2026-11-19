import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../core/utils/date_picker.dart';
import '../../../l10n/l10n.dart';
import '../../theme/theme_extensions.dart';
import '../../tokens/sizes.dart';

/// Calendar affordance of a `dd/MM/yyyy` field.
///
/// Opens the platform date picker, writes the chosen date back into
/// [controller] and reports it through [onPicked] (so the screen can mirror it
/// into its own state).
class DatePickerButton extends StatelessWidget {
  const DatePickerButton({
    super.key,
    required this.controller,
    required this.onPicked,
    this.firstDate,
    this.lastDate,
  });

  final TextEditingController controller;
  final ValueChanged<String> onPicked;
  final DateTime? firstDate;
  final DateTime? lastDate;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: context.l10n.commonPickDate,
      visualDensity: VisualDensity.compact,
      padding: EdgeInsets.zero,
      iconSize: ControlSize.iconLg,
      color: context.respiraColors.iconDefault,
      icon: const Icon(LucideIcons.calendar),
      onPressed: () async {
        final picked = await pickDateAsDdMmYyyy(
          context,
          currentValue: controller.text,
          firstDate: firstDate,
          lastDate: lastDate,
        );
        if (picked == null) return;
        controller.text = picked;
        onPicked(picked);
      },
    );
  }
}
