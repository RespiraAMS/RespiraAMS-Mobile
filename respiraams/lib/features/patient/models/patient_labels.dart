import '../../../l10n/l10n.dart';

/// `Adhere` | `NotAdhere` | `NotAdhereValid` | `NotAdhereInvalid`.
String adherenceStateLabel(String state, AppLocalizations l10n) =>
    switch (state) {
      'Adhere' => l10n.adherenceAdhere,
      'NotAdhere' => l10n.adherenceNotAdhere,
      'NotAdhereValid' => l10n.adherenceNotAdhereValid,
      'NotAdhereInvalid' => l10n.adherenceNotAdhereInvalid,
      _ => state,
    };

/// `TreatmentPlanStatus` has no string converter on the backend:
/// `0` = InProgress, `1` = Closed.
String treatmentPlanStatusLabel(int status, AppLocalizations l10n) =>
    status == 1
        ? l10n.treatmentPlanStatusClosed
        : l10n.treatmentPlanStatusInProgress;
