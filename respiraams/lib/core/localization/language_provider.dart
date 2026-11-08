import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../network/api_client.dart';

part 'language_provider.g.dart';

/// Languages supported by the app (settings sheet → "Ngôn ngữ").
enum AppLanguage {
  vi('vi', 'Tiếng Việt'),
  en('en', 'English');

  const AppLanguage(this.code, this.nativeName);

  final String code;

  /// Name shown in the language picker, in the language itself.
  final String nativeName;

  Locale get locale => Locale(code);
}

/// App-wide locale, persisted under `settings.language`.
///
/// Defaults to Vietnamese (the app's source language and backend content
/// language) so existing behaviour and tests stay unchanged until the user
/// picks English in the settings sheet.
@Riverpod(keepAlive: true)
class LanguageController extends _$LanguageController {
  static const _storageKey = 'settings.language';

  SharedPreferences get _prefs => ref.read(sharedPreferencesProvider);

  @override
  AppLanguage build() {
    final stored = _prefs.getString(_storageKey);
    return AppLanguage.values.firstWhere(
      (language) => language.code == stored,
      orElse: () => AppLanguage.vi,
    );
  }

  void setLanguage(AppLanguage language) {
    state = language;
    _prefs.setString(_storageKey, language.code);
  }
}
