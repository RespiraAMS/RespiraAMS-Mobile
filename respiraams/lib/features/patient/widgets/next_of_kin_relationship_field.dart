import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import 'package:respiraams/design_system/design_system.dart';
import 'package:respiraams/l10n/l10n.dart';

import '../models/next_of_kin_relationship.dart';
import 'section_label_widget.dart';

/// Relationship picker of the next-of-kin form.
///
/// Choosing "Khác" reveals a free-text field so the doctor can type the exact
/// relationship; the API accepts any text.
class NextOfKinRelationshipField extends StatelessWidget {
  const NextOfKinRelationshipField({
    super.key,
    required this.selected,
    required this.onChanged,
    required this.otherController,
    this.otherErrorText,
    this.onOtherChanged,
  });

  final NextOfKinRelationship? selected;
  final ValueChanged<NextOfKinRelationship?> onChanged;
  final TextEditingController otherController;
  final String? otherErrorText;
  final ValueChanged<String>? onOtherChanged;

  @override
  Widget build(BuildContext context) {
    final c = context.respiraColors;
    final l10n = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SectionLabelWidget('${l10n.nextOfKinRelationship} *'),
        const SizedBox(height: Spacing.inline),
        Container(
          height: ControlSize.inputDefault,
          padding: const EdgeInsets.symmetric(horizontal: Spacing.control),
          decoration: BoxDecoration(
            color: c.surface,
            borderRadius: AppRadius.md,
            border: Border.all(
              color: otherErrorText == null ? c.borderSubtle : c.error,
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<NextOfKinRelationship>(
              value: selected,
              isExpanded: true,
              hint: Text(
                l10n.nextOfKinRelationshipHint,
                style: TextStyle(color: c.textSecondary),
              ),
              icon: Icon(LucideIcons.chevronDown, color: c.iconDefault),
              dropdownColor: c.surface,
              borderRadius: AppRadius.md,
              items: [
                for (final relationship in nextOfKinRelationships)
                  DropdownMenuItem<NextOfKinRelationship>(
                    value: relationship,
                    child: Text(
                      relationship.label(l10n),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: c.textPrimary),
                    ),
                  ),
              ],
              onChanged: onChanged,
            ),
          ),
        ),
        if (selected == NextOfKinRelationship.other) ...[
          const SizedBox(height: Spacing.group),
          AppTextField(
            label: '${l10n.nextOfKinRelationshipOther} *',
            controller: otherController,
            hintText: l10n.nextOfKinRelationshipOtherHint,
            errorText: otherErrorText,
            onChanged: onOtherChanged,
          ),
        ],
      ],
    );
  }
}
