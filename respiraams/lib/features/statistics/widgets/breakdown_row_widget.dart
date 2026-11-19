import 'package:flutter/material.dart';

import 'package:respiraams/design_system/design_system.dart';

import '../models/statistics_view.dart';

/// One breakdown row: label · progress track · bold count.
/// Fill width is proportional to the max count; color follows the rank.
class BreakdownRowWidget extends StatelessWidget {
  const BreakdownRowWidget({
    super.key,
    required this.stat,
    required this.label,
    required this.maxCount,
  });

  final BreakdownStat stat;
  final String label;
  final int maxCount;

  @override
  Widget build(BuildContext context) {
    final c = context.respiraColors;
    final fillColor = switch (stat.rank) {
      0 => c.primary,
      1 => c.warning,
      _ => c.success,
    };

    final fraction =
        maxCount <= 0 ? 0.0 : (stat.count / maxCount).clamp(0.0, 1.0);

    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TypographyTokens.label(context)
                .copyWith(color: c.textSecondary),
          ),
        ),
        const SizedBox(width: Spacing.control),
        Expanded(
          flex: 5,
          child: Stack(
            children: [
              Container(
                height: 12,
                decoration: BoxDecoration(
                  color: c.surfaceSecondary,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              FractionallySizedBox(
                widthFactor: fraction,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOut,
                  height: 12,
                  decoration: BoxDecoration(
                    color: fillColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: Spacing.control),
        SizedBox(
          width: 32,
          child: Text(
            '${stat.count}',
            textAlign: TextAlign.right,
            style: TypographyTokens.label(context)
                .copyWith(fontWeight: FontWeight.w700, color: c.textPrimary),
          ),
        ),
      ],
    );
  }
}
