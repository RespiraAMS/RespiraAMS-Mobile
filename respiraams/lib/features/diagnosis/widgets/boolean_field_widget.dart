import 'package:flutter/material.dart';

import 'package:respiraams/design_system/design_system.dart';
import 'package:respiraams/l10n/l10n.dart';

import '../../patient/widgets/section_label_widget.dart';

/// Boolean field of the diagnose wizard.
///
/// Mirrors the web `diagnose.html` segmented toggle: the field name occupies
/// its own line and the `Không | Có` tabs sit underneath, styled with the app
/// palette. Tapping a tab selects that answer; there is no neutral state
/// because the request payload always sends a boolean (untouched = `false`).
class BooleanFieldWidget extends StatelessWidget {
  const BooleanFieldWidget({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;

  /// `false` = "Không", `true` = "Có".
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final c = context.respiraColors;
    final l10n = context.l10n;

    return Semantics(
      container: true,
      label: label,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          SectionLabelWidget(label),
          const SizedBox(height: Spacing.inline),
          Container(
            height: ControlSize.touchTargetMin,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: AppRadius.md,
              border: Border.all(color: c.borderSubtle),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: _BooleanSegment(
                    label: l10n.commonNo,
                    active: !value,
                    onTap: () => onChanged(false),
                  ),
                ),
                Container(width: 1, color: c.borderSubtle),
                Expanded(
                  child: _BooleanSegment(
                    label: l10n.commonYes,
                    active: value,
                    onTap: () => onChanged(true),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BooleanSegment extends StatelessWidget {
  const _BooleanSegment({
    required this.label,
    required this.active,
    required this.onTap,
  });

  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.respiraColors;

    return Semantics(
      button: true,
      selected: active,
      label: label,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOut,
        color: active ? c.primary : c.surface,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Center(
              child: AppText(
                label,
                type: AppTextType.label,
                color: active ? c.onPrimary : c.textPrimary,
                fontWeight: active ? FontWeight.w600 : FontWeight.w400,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
