import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../primitives/app_icon.dart';
import '../../tokens/sizes.dart';

/// Top-level hamburger menu button used across the workspace tab headers
/// (Bệnh nhân · Tra cứu · Máy tính · Thống kê).
///
/// Icon-only, so it exposes a semantic label (§12).
class AppMenuButton extends StatelessWidget {
  const AppMenuButton({
    super.key,
    this.onTap,
    this.semanticLabel = 'Mở menu',
  });

  final VoidCallback? onTap;
  final String semanticLabel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () {},
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 40,
        height: 40,
        alignment: Alignment.center,
        child: AppIcon(
          LucideIcons.menu,
          size: ControlSize.iconBase,
          semanticLabel: semanticLabel,
        ),
      ),
    );
  }
}
