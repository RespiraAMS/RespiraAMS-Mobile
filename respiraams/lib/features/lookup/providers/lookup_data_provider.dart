import 'package:lucide_icons/lucide_icons.dart';

import '../models/lookup_category.dart';
import '../models/recent_item.dart';

class LookupDataProvider {
  static const List<LookupCategory> categories = [
    LookupCategory(id: LookupCategoryId.antibioticGroups, icon: LucideIcons.layers),
    LookupCategory(id: LookupCategoryId.antibiotics, icon: LucideIcons.pill),
    LookupCategory(id: LookupCategoryId.antibiograms, icon: LucideIcons.activity),
    LookupCategory(id: LookupCategoryId.pathogens, icon: LucideIcons.bug),
    LookupCategory(id: LookupCategoryId.treatmentProtocols, icon: LucideIcons.clipboardCheck),
    LookupCategory(id: LookupCategoryId.clinicalVariables, icon: LucideIcons.clipboardList),
    LookupCategory(id: LookupCategoryId.suspectedCauses, icon: LucideIcons.alertCircle),
    LookupCategory(id: LookupCategoryId.criteria, icon: LucideIcons.checkSquare),
    LookupCategory(id: LookupCategoryId.riskFactors, icon: LucideIcons.alertTriangle),
    LookupCategory(id: LookupCategoryId.clinicalMetrics, icon: LucideIcons.stethoscope),
  ];

  static const List<RecentItem> recentItems = [
    RecentItem(id: RecentItemId.ceftriaxone),
    RecentItem(id: RecentItemId.communityPneumonia),
  ];
}
