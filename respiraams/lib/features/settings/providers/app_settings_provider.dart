import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/network/api_client.dart';

part 'app_settings_provider.g.dart';

/// App-wide text-size presets offered by the settings sheet.
///
/// The factor is applied on top of the platform text scale in `main.dart`,
/// so the choice still respects the OS accessibility setting.
enum AppTextScale {
  small(label: 'Nhỏ', factor: 0.9),
  standard(label: 'Mặc định', factor: 1.0),
  large(label: 'Lớn', factor: 1.15);

  const AppTextScale({required this.label, required this.factor});

  final String label;
  final double factor;
}

/// Persisted `Cỡ chữ` setting (`settings.textScale`).
@Riverpod(keepAlive: true)
class AppTextScaleController extends _$AppTextScaleController {
  static const _storageKey = 'settings.textScale';

  SharedPreferences get _prefs => ref.read(sharedPreferencesProvider);

  @override
  AppTextScale build() {
    final stored = _prefs.getString(_storageKey);
    return AppTextScale.values.firstWhere(
      (scale) => scale.name == stored,
      orElse: () => AppTextScale.standard,
    );
  }

  void setScale(AppTextScale scale) {
    state = scale;
    _prefs.setString(_storageKey, scale.name);
  }
}
