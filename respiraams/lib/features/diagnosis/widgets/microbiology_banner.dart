import 'package:flutter/material.dart';

import 'package:respiraams/design_system/design_system.dart';
import 'package:respiraams/l10n/l10n.dart';

/// Read-only display field for the identified bacteria ("Vi khuẩn").
class BacteriaDisplayField extends StatelessWidget {
  const BacteriaDisplayField({super.key, required this.bacteria});

  final String bacteria;

  @override
  Widget build(BuildContext context) {
    final c = context.respiraColors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.microBacteria,
          style: TypographyTokens.label(context).copyWith(color: c.textPrimary),
        ),
        const SizedBox(height: Spacing.inline),
        Container(
          constraints: const BoxConstraints(
            minHeight: ControlSize.buttonLarge,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: Spacing.group,
            vertical: Spacing.control,
          ),
          decoration: BoxDecoration(
            color: c.surface,
            borderRadius: AppRadius.md,
            border: Border.all(color: c.borderSubtle),
          ),
          alignment: Alignment.centerLeft,
          child: AppText(
            bacteria,
            type: AppTextType.body,
            color: c.textSecondary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

/// Soft-primary banner showing the latest antibiogram line
/// ("Kháng sinh đồ gần nhất").
class AntibiogramBanner extends StatelessWidget {
  const AntibiogramBanner({super.key, required this.line});

  final String line;

  @override
  Widget build(BuildContext context) {
    final c = context.respiraColors;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Spacing.group,
        vertical: Spacing.control,
      ),
      decoration: BoxDecoration(
        color: c.primarySoft,
        borderRadius: AppRadius.md,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.microLatestAntibiogram,
            style: TypographyTokens.label(context)
                .copyWith(color: c.textSecondary),
          ),
          const SizedBox(height: Spacing.xxxs),
          Text(
            line,
            style: TypographyTokens.body(context).copyWith(
              fontWeight: FontWeight.w700,
              color: c.primary,
            ),
          ),
        ],
      ),
    );
  }
}
