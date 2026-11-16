import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../network/api_client.dart';

part 'theme_mode_provider.g.dart';

/// App brightness mode (guidelines §2.1 Riverpod codegen).
///
/// App-wide singleton (`keepAlive`) — defaults to [ThemeMode.system] and is
/// persisted under `settings.themeMode`, so the settings sheet can switch
/// light/dark/system at runtime and keep the choice across restarts.
@Riverpod(keepAlive: true)
class ThemeModeController extends _$ThemeModeController {
  static const _storageKey = 'settings.themeMode';

  SharedPreferences get _prefs => ref.read(sharedPreferencesProvider);

  @override
  ThemeMode build() {
    final stored = _prefs.getString(_storageKey);
    return ThemeMode.values.firstWhere(
      (mode) => mode.name == stored,
      orElse: () => ThemeMode.system,
    );
  }

  void setMode(ThemeMode mode) {
    state = mode;
    _prefs.setString(_storageKey, mode.name);
  }

  void setLight() => setMode(ThemeMode.light);

  void setDark() => setMode(ThemeMode.dark);

  void setSystem() => setMode(ThemeMode.system);
}
