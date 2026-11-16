import 'package:flutter/material.dart';

import 'package:respiraams/design_system/design_system.dart';

/// AWaRe colour pair used to tag an antibiotic (Access / Watch / Reserve).
class AwarePalette {
  const AwarePalette({required this.background, required this.foreground});

  final Color background;
  final Color foreground;
}

/// Maps the BE `AwareClassification` value to the app's semantic colours.
AwarePalette awarePalette(BuildContext context, String classification) {
  final c = context.respiraColors;
  return switch (classification.trim().toLowerCase()) {
    'access' => AwarePalette(background: c.successSoft, foreground: c.success),
    'watch' => AwarePalette(background: c.warningSoft, foreground: c.warning),
    _ => AwarePalette(background: c.errorSoft, foreground: c.error),
  };
}

/// Antibiotic name wrapped in its AWaRe background colour.
class AwareDrugChip extends StatelessWidget {
  const AwareDrugChip({
    super.key,
    required this.name,
    required this.classification,
    this.maxWidth = 260,
  });

  final String name;

  /// `Access` | `Watch` | `Reserve` (empty when unknown).
  final String classification;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    final palette = awarePalette(context, classification);
    final label = name.isEmpty
        ? classification
        : (classification.isEmpty ? name : '$name · $classification');

    return Container(
      constraints: BoxConstraints(maxWidth: maxWidth),
      padding: const EdgeInsets.symmetric(
        horizontal: Spacing.control,
        vertical: Spacing.xxxs + 2,
      ),
      decoration: BoxDecoration(
        color: palette.background,
        borderRadius: AppRadius.full,
      ),
      child: AppText(
        label,
        type: AppTextType.label,
        color: palette.foreground,
        maxLines: 2,
      ),
    );
  }
}
