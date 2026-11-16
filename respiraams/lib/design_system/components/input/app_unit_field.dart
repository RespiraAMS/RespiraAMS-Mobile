import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../theme/theme_extensions.dart';
import '../../../l10n/l10n.dart';
import '../../tokens/radius.dart';
import '../../tokens/sizes.dart';
import '../../tokens/spacing.dart';
import '../../tokens/typography.dart';

/// Labeled numeric input with a trailing unit suffix (§09.2): 44px, radius
/// 16, clear focus indicator, numeric keyboard. Used by the clinical
/// wizard for vitals and scoring parameters.
///
/// The unit is *always visible* (rendered as a sibling, not an InputDecoration
/// suffix — Flutter hides suffixes until the field is focused/filled).
/// Pass an empty [unit] when the quantity is unitless (e.g. PaO₂/FiO₂ ratio).
class AppUnitField extends StatefulWidget {
  const AppUnitField({
    super.key,
    required this.label,
    required this.onChanged,
    this.unit = '',
    this.initialValue = '',
    this.hintText,
    this.description,
    this.enabled = true,
    this.semanticLabel,
    this.expanded = false,
    this.warningText,
  });

  final String label;

  /// Optional supporting line under the label (e.g. "≤ 250 · Tiêu chí hỗ trợ.").
  final String? description;
  final String unit;

  /// Initial text; the field owns its editing state afterwards (parent
  /// mirrors it through [onChanged]) — avoids cursor jumps on rebuilds.
  final String initialValue;
  final ValueChanged<String> onChanged;
  final String? hintText;
  final bool enabled;

  final String? semanticLabel;

  /// When true the input takes half of the available row width (label takes
  /// the other half) instead of the default fixed 144px — used by the patient
  /// forms and by the diagnosis wizard (which mirrors the web form's
  /// info-left / input-right layout).
  final bool expanded;

  /// Non-blocking advisory rendered under the whole row (warning color). Used
  /// by the diagnosis wizard when the typed value is outside the variable's
  /// accepted range — the doctor can still continue with it.
  final String? warningText;

  @override
  State<AppUnitField> createState() => _AppUnitFieldState();
}

class _AppUnitFieldState extends State<AppUnitField> {
  late final TextEditingController _controller =
      TextEditingController(text: widget.initialValue);

  @override
  void didUpdateWidget(covariant AppUnitField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != _controller.text) {
      // External reset (e.g. controller cleared); defer to avoid notifying
      // listeners mid-layout.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && _controller.text != widget.initialValue) {
          _controller.text = widget.initialValue;
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = context.respiraColors;

    final input = Container(
      height: ControlSize.touchTargetMin,
      width: widget.expanded ? double.infinity : 144,
      padding: const EdgeInsets.symmetric(horizontal: Spacing.control),
      decoration: BoxDecoration(
        color: c.surface,
        borderRadius: AppRadius.md,
        border: Border.all(color: c.borderSubtle),
      ),
      // Centers the single-line field vertically inside the 44px box.
      alignment: Alignment.center,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              onChanged: widget.onChanged,
              enabled: widget.enabled,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
              ],
              style: TextStyle(fontSize: 15, color: c.textPrimary),
              cursorColor: c.primary,
              decoration: InputDecoration(
                isCollapsed: true,
                border: InputBorder.none,
                hintText: widget.hintText ?? context.l10n.commonEnterNumber,
                hintStyle: TextStyle(fontSize: 15, color: c.textSecondary),
              ),
            ),
          ),
          if (widget.unit.isNotEmpty) ...[
            const SizedBox(width: Spacing.xxs),
            Text(
              widget.unit,
              style: TypographyTokens.label(context)
                  .copyWith(color: c.textSecondary),
            ),
          ],
        ],
      ),
    );

    final row = Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style:
                    TypographyTokens.body(context).copyWith(color: c.textPrimary),
              ),
              if (widget.description != null) ...[
                const SizedBox(height: Spacing.xxxs),
                Text(
                  widget.description!,
                  style: TypographyTokens.caption(context)
                      .copyWith(color: c.textSecondary),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(width: Spacing.control),
        if (widget.expanded) Expanded(child: input) else input,
      ],
    );

    final warning = widget.warningText;
    if (warning == null || warning.isEmpty) return row;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        row,
        const SizedBox(height: Spacing.xxxs),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              LucideIcons.alertTriangle,
              size: ControlSize.iconSm,
              color: c.warning,
            ),
            const SizedBox(width: Spacing.xxxs),
            Expanded(
              child: Text(
                warning,
                style:
                    TypographyTokens.caption(context).copyWith(color: c.warning),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
