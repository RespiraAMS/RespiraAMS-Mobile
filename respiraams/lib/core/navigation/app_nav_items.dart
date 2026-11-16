import 'package:flutter/widgets.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../design_system/design_system.dart';
import '../../l10n/l10n.dart';

/// Shared bottom-navigation destinations used by every workspace tab.
///
/// Keeping the list in one place means the labels only have to be translated
/// once and all four tabs stay in sync.
List<AppBottomNavItem> appBottomNavItems(BuildContext context) {
  final l10n = context.l10n;
  return [
    AppBottomNavItem(icon: LucideIcons.users, label: l10n.navPatients),
    AppBottomNavItem(icon: LucideIcons.search, label: l10n.navLookup),
    AppBottomNavItem(
      icon: LucideIcons.stethoscope,
      label: l10n.navDiagnosis,
    ),
    AppBottomNavItem(
      icon: LucideIcons.calculator,
      label: l10n.navCalculators,
    ),
    AppBottomNavItem(
      icon: LucideIcons.barChart2,
      label: l10n.navStatistics,
    ),
  ];
}
