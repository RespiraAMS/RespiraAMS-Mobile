import 'package:flutter/material.dart';

import 'package:respiraams/design_system/design_system.dart';
import 'package:respiraams/features/diagnosis/widgets/risk_pill_widget.dart';
import 'package:respiraams/l10n/l10n.dart';

/// Result card of the CURB-65 calculator: title · score (0–5) · risk pill
/// · advice line. Band mapping: 0–1 low, 2 watch, 3–5 high (inpatient
/// consideration) — color always paired with the pill's label (§12).
class Curb65ResultCard extends StatelessWidget {
  const Curb65ResultCard({super.key, required this.score});

  final int score;

  String _riskLabel(AppLocalizations l10n) => score >= 3
      ? l10n.riskHigh
      : score == 2
          ? l10n.riskWatch
          : l10n.riskLow;

  String _advice(AppLocalizations l10n) => score >= 3
      ? l10n.calcAdviceHigh(score)
      : score == 2
          ? l10n.calcAdviceMedium(score)
          : l10n.calcAdviceLow(score);

  @override
  Widget build(BuildContext context) {
    final c = context.respiraColors;
    final l10n = context.l10n;

    return Container(
      padding: const EdgeInsets.all(Spacing.control + 2),
      decoration: BoxDecoration(
        color: c.surface,
        borderRadius: AppRadius.md,
        border: Border.all(color: c.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'CURB-65',
                  style: TypographyTokens.body(context)
                      .copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              Text(
                l10n.calcScorePoints(score),
                style: TypographyTokens.h3(context).copyWith(
                  fontWeight: FontWeight.w700,
                  color: score >= 3 ? c.warning : c.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: Spacing.inline),
          RiskPillWidget(label: _riskLabel(l10n), isHigh: score >= 3),
          const SizedBox(height: Spacing.inline),
          AppText(_advice(l10n), type: AppTextType.caption, maxLines: 2),
        ],
      ),
    );
  }
}
