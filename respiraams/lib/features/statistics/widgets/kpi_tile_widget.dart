import 'package:flutter/material.dart';

import 'package:respiraams/design_system/design_system.dart';
import 'package:respiraams/l10n/l10n.dart';

import '../models/statistics_view.dart';

/// Headline KPI tile ("Đang điều trị · 24"): label · value.
class KpiTileWidget extends StatelessWidget {
  const KpiTileWidget({super.key, required this.stat});

  final KpiStat stat;

  @override
  Widget build(BuildContext context) {
    final c = context.respiraColors;

    return Container(
      padding: const EdgeInsets.all(Spacing.control + 2),
      decoration: BoxDecoration(
        color: c.surface,
        borderRadius: AppRadius.md,
        border: Border.all(color: c.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            stat.id.label(context.l10n),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TypographyTokens.label(context)
                .copyWith(color: c.textSecondary),
          ),
          const SizedBox(height: Spacing.xxxs),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              '${stat.value}',
              style: TypographyTokens.h2(context)
                  .copyWith(color: c.textPrimary),
            ),
          ),
        ],
      ),
    );
  }
}
