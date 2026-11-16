import '../../../../l10n/l10n.dart';

/// Stable identifiers for the demo "recent items" strip.
enum RecentItemId { ceftriaxone, communityPneumonia }

extension RecentItemIdL10n on RecentItemId {
  String title(AppLocalizations l10n) => switch (this) {
        RecentItemId.ceftriaxone => l10n.recentItemDrugTitle,
        RecentItemId.communityPneumonia => l10n.recentItemDiseaseTitle,
      };

  String subtitle(AppLocalizations l10n) => switch (this) {
        RecentItemId.ceftriaxone => l10n.recentItemDrugSubtitle,
        RecentItemId.communityPneumonia => l10n.recentItemDiseaseSubtitle,
      };

  String tag(AppLocalizations l10n) => switch (this) {
        RecentItemId.ceftriaxone => l10n.recentItemDrugTag,
        RecentItemId.communityPneumonia => l10n.recentItemDiseaseTag,
      };
}

class RecentItem {
  final RecentItemId id;

  const RecentItem({required this.id});
}
