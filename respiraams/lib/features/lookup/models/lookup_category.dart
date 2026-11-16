import 'package:flutter/material.dart';

import '../../../../l10n/l10n.dart';

/// Stable identifiers for the lookup catalogue entries.
///
/// Routing and l10n keys are driven by this id rather than the Vietnamese
/// title so the grid keeps working when the UI language changes.
enum LookupCategoryId {
  antibioticGroups,
  antibiotics,
  antibiograms,
  pathogens,
  treatmentProtocols,
  clinicalVariables,
  suspectedCauses,
  criteria,
  riskFactors,
  clinicalMetrics,
}

extension LookupCategoryIdL10n on LookupCategoryId {
  String title(AppLocalizations l10n) => switch (this) {
        LookupCategoryId.antibioticGroups => l10n.categoryAntibioticGroups,
        LookupCategoryId.antibiotics => l10n.categoryAntibiotics,
        LookupCategoryId.antibiograms => l10n.categoryAntibiograms,
        LookupCategoryId.pathogens => l10n.categoryPathogens,
        LookupCategoryId.treatmentProtocols => l10n.categoryTreatmentProtocols,
        LookupCategoryId.clinicalVariables => l10n.categoryClinicalVariables,
        LookupCategoryId.suspectedCauses => l10n.categorySuspectedCauses,
        LookupCategoryId.criteria => l10n.categoryCriteria,
        LookupCategoryId.riskFactors => l10n.categoryRiskFactors,
        LookupCategoryId.clinicalMetrics => l10n.categoryClinicalScores,
      };

  String subtitle(AppLocalizations l10n) => switch (this) {
        LookupCategoryId.antibioticGroups =>
          l10n.categoryAntibioticGroupsSub,
        LookupCategoryId.antibiotics => l10n.categoryAntibioticsSub,
        LookupCategoryId.antibiograms => l10n.categoryAntibiogramsSub,
        LookupCategoryId.pathogens => l10n.categoryPathogensSub,
        LookupCategoryId.treatmentProtocols =>
          l10n.categoryTreatmentProtocolsSub,
        LookupCategoryId.clinicalVariables =>
          l10n.categoryClinicalVariablesSub,
        LookupCategoryId.suspectedCauses => l10n.categorySuspectedCausesSub,
        LookupCategoryId.criteria => l10n.categoryCriteriaSub,
        LookupCategoryId.riskFactors => l10n.categoryRiskFactorsSub,
        LookupCategoryId.clinicalMetrics => l10n.categoryClinicalScoresSub,
      };
}

class LookupCategory {
  final LookupCategoryId id;
  final IconData icon;

  const LookupCategory({required this.id, required this.icon});
}
