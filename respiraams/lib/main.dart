import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/api_client.dart';
import 'core/router/app_router.dart';
import 'core/theme/theme_mode_provider.dart';
import 'design_system/design_system.dart';
import 'features/settings/providers/app_settings_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Load `.env` (bundled asset) so `kApiBaseUrl` can read API_BASE_URL.
  // Missing/misconfigured file must not crash the app; the getter falls
  // back to its built-in gateway default.
  try {
    await dotenv.load();
  } catch (_) {}
  final prefs = await SharedPreferences.getInstance();
  runApp(ProviderScope(
    overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
    child: const RespiraMobileApp(),
  ));
}

/// App root: Riverpod scope + Material 3 router with light/dark themes.
class RespiraMobileApp extends ConsumerWidget {
  const RespiraMobileApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeControllerProvider);
    final textScale = ref.watch(appTextScaleControllerProvider);

    return MaterialApp.router(
      title: 'RespiraAMS',
      debugShowCheckedModeBanner: false,
      theme: lightThemeData,
      darkTheme: darkThemeData,
      themeMode: themeMode,
      builder: (context, child) {
        // Multiply the OS accessibility scale by the in-app "Cỡ chữ" preset.
        final systemFactor = MediaQuery.textScalerOf(context).scale(16) / 16;
        final factor = (systemFactor * textScale.factor).clamp(0.8, 2.0);
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.linear(factor.toDouble()),
          ),
          child: child ?? const SizedBox.shrink(),
        );
      },
      routerConfig: ref.watch(appRouterProvider),
    );
  }
}
