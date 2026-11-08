import 'package:flutter/widgets.dart';

import 'generated/app_localizations.dart';

export 'generated/app_localizations.dart';
export 'l10n_labels.dart';

/// Ergonomic access to the generated [AppLocalizations].
///
/// Usage: `context.l10n.settingsTitle`.
extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
