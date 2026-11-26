import 'package:flutter/material.dart';

import '../../theme/theme_extensions.dart';
import '../../tokens/radius.dart';
import '../../tokens/sizes.dart';
import '../../tokens/spacing.dart';
import '../../tokens/typography.dart';

/// One top-level destination of the bottom navigation bar.
class AppBottomNavItem {
  const AppBottomNavItem({required this.icon, required this.label});

  final IconData icon;
  final String label;
}

/// Bottom navigation (§09.6): 44px+ targets, icon + label, active shown by
/// soft-primary pill AND label color — never color alone. Flat surface with
/// a subtle border; shadows are forbidden (§14/§15).
class AppBottomNavigation extends StatelessWidget {
  const AppBottomNavigation({
    super.key,
    required this.items,
    required this.activeIndex,
    required this.onTap,
  }) : assert(items.length > 1);

  final List<AppBottomNavItem> items;
  final int activeIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.respiraColors;

    // Five labelled destinations at the OS/in-app text scale can be wider than
    // a narrow phone (e.g. a Galaxy A34 at 1.15×), which used to overflow the
    // row. The labels are therefore clamped and every destination takes an
    // equal share of the bar instead of its intrinsic width.
    return MediaQuery.withClampedTextScaling(
      maxScaleFactor: 1.3,
      child: SafeArea(
        top: false,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: Spacing.xxxs,
            vertical: Spacing.xxs,
          ),
          decoration: BoxDecoration(
            color: c.surface,
            borderRadius: AppRadius.lg,
            border: Border.all(color: c.borderSubtle),
          ),
          child: Row(
            children: [
              for (var i = 0; i < items.length; i++)
                Expanded(
                  child: _NavItem(
                    item: items[i],
                    active: i == activeIndex,
                    onTap: () => onTap(i),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({required this.item, required this.active, required this.onTap});

  final AppBottomNavItem item;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.respiraColors;

    return Semantics(
      button: true,
      selected: active,
      label: item.label,
      child: Material(
        color: active ? c.primarySoft : Colors.transparent,
        borderRadius: BorderRadius.circular(18),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              minWidth: ControlSize.touchTargetMin,
              minHeight: ControlSize.touchTargetMin,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Spacing.xxxs,
                vertical: Spacing.xxs,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    item.icon,
                    size: ControlSize.iconXl,
                    color: active ? c.primary : c.iconMuted,
                  ),
                  const SizedBox(height: Spacing.xxxs),
                  // Long labels ("Calculators") shrink to the destination
                  // width instead of pushing the bar past the screen edge.
                  SizedBox(
                    width: double.infinity,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        item.label,
                        maxLines: 1,
                        softWrap: false,
                        style: TypographyTokens.label(context).copyWith(
                          // Active keeps the Label weight; inactive relaxes it
                          // while staying inside the type scale (component
                          // impl).
                          fontWeight:
                              active ? FontWeight.w600 : FontWeight.w400,
                          color: active ? c.primary : c.textSecondary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
