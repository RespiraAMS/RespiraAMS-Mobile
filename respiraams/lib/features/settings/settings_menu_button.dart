import 'package:flutter/material.dart';

import '../../design_system/design_system.dart';
import 'settings_sheet.dart';

/// Header hamburger that opens the left-side settings sheet.
class SettingsMenuButton extends StatelessWidget {
  const SettingsMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    return AppMenuButton(
      semanticLabel: 'Mở cài đặt',
      onTap: () => showSettingsDrawer(context),
    );
  }
}
