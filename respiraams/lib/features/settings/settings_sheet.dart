import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../core/localization/language_provider.dart';
import '../../core/theme/theme_mode_provider.dart';
import '../../core/utils/name_initials.dart';
import '../../design_system/design_system.dart';
import '../../l10n/l10n.dart';
import '../authentication/providers/session_provider.dart';
import '../authentication/routes.dart';
import 'providers/app_settings_provider.dart';

/// Opens the left-side settings sheet used by every workspace header.
///
/// Not a route/screen: a [PopupRoute] slides the panel over the current
/// screen with a dimmed barrier, mirroring the Figma "SettingsDrawerOpen"
/// frame. Returns after the sheet closes; a confirmed logout lands on the
/// login screen.
Future<void> showSettingsDrawer(BuildContext context) async {
  final loggedOut = await Navigator.of(
    context,
    rootNavigator: true,
  ).push<bool>(_SettingsDrawerRoute(context.l10n.settingsClose));
  if (loggedOut == true && context.mounted) {
    context.go(AuthenticationRoutes.login);
  }
}

class _SettingsDrawerRoute extends PopupRoute<bool> {
  _SettingsDrawerRoute(this._barrierLabel);

  final String _barrierLabel;

  @override
  Color? get barrierColor => Colors.black.withValues(alpha: 0.32);

  @override
  bool get barrierDismissible => true;

  @override
  String? get barrierLabel => _barrierLabel;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 260);

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [SettingsSheet()],
    );
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final curved = CurvedAnimation(
      parent: animation,
      curve: Curves.easeOutCubic,
    );
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-1, 0),
        end: Offset.zero,
      ).animate(curved),
      child: child,
    );
  }
}

/// Content of the settings sheet. Kept public so widget tests can target it.
class SettingsSheet extends ConsumerWidget {
  const SettingsSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = context.respiraColors;
    final l10n = context.l10n;
    final themeMode = ref.watch(themeModeControllerProvider);
    final textScale = ref.watch(appTextScaleControllerProvider);
    final language = ref.watch(languageControllerProvider);
    final session = ref.watch(sessionDoctorProvider);
    final name = (session?.name.trim().isNotEmpty ?? false)
        ? session!.name.trim()
        : l10n.settingsDoctorFallback;

    final width = math.min(MediaQuery.sizeOf(context).width * 0.9, 400.0);

    return Material(
      color: c.background,
      child: SizedBox(
        width: width,
        height: double.infinity,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: c.background,
            border: Border(right: BorderSide(color: c.borderSubtle)),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const _SheetHeader(),
                  const SizedBox(height: Spacing.section),
                  _ProfileCard(
                    name: name,
                    avatarUrl: session?.avatarUrl,
                    onTap: () => _openDoctorProfile(context),
                  ),
                  const SizedBox(height: Spacing.section),
                  _SectionTitle(l10n.settingsAppearance),
                  const SizedBox(height: Spacing.inline),
                  _SettingsGroup(
                    children: [
                      _SettingsRow(
                        icon: LucideIcons.monitor,
                        title: l10n.settingsTheme,
                        subtitle: l10n.settingsThemeSubtitle,
                        trailing: _ThemePill(themeMode),
                        onTap: () => _selectTheme(context, ref, themeMode),
                      ),
                      const _GroupDivider(),
                      _SettingsRow(
                        icon: LucideIcons.type,
                        title: l10n.settingsFontSize,
                        subtitle: textScaleLabel(l10n, textScale),
                        trailing: const _Chevron(),
                        onTap: () => _selectTextScale(context, ref, textScale),
                      ),
                      const _GroupDivider(),
                      _SettingsRow(
                        icon: LucideIcons.languages,
                        title: l10n.settingsLanguage,
                        subtitle: language.nativeName,
                        trailing: const _Chevron(),
                        onTap: () => _selectLanguage(context, ref, language),
                      ),
                    ],
                  ),
                  const SizedBox(height: Spacing.section),
                  AppButton(
                    label: l10n.settingsLogout,
                    type: AppButtonType.destructive,
                    expand: true,
                    onPressed: () => _confirmLogout(context, ref),
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

Future<void> _selectTheme(
  BuildContext context,
  WidgetRef ref,
  ThemeMode current,
) async {
  final l10n = context.l10n;
  final selected = await _showOptionSheet<ThemeMode>(
    context,
    title: l10n.settingsThemeSheetTitle,
    selected: current,
    options: [
      _SettingsOption(
        value: ThemeMode.system,
        label: l10n.settingsThemeSystem,
        icon: LucideIcons.monitor,
      ),
      _SettingsOption(
        value: ThemeMode.light,
        label: l10n.settingsThemeLight,
        icon: LucideIcons.sun,
      ),
      _SettingsOption(
        value: ThemeMode.dark,
        label: l10n.settingsThemeDark,
        icon: LucideIcons.moon,
      ),
    ],
  );
  if (selected != null) {
    ref.read(themeModeControllerProvider.notifier).setMode(selected);
  }
}

String textScaleLabel(AppLocalizations l10n, AppTextScale scale) =>
    switch (scale) {
      AppTextScale.small => l10n.settingsTextSmall,
      AppTextScale.standard => l10n.settingsTextStandard,
      AppTextScale.large => l10n.settingsTextLarge,
    };

Future<void> _selectTextScale(
  BuildContext context,
  WidgetRef ref,
  AppTextScale current,
) async {
  final l10n = context.l10n;
  final selected = await _showOptionSheet<AppTextScale>(
    context,
    title: l10n.settingsFontSize,
    selected: current,
    options: [
      for (final scale in AppTextScale.values)
        _SettingsOption(
          value: scale,
          label: textScaleLabel(l10n, scale),
          icon: LucideIcons.type,
        ),
    ],
  );
  if (selected != null) {
    ref.read(appTextScaleControllerProvider.notifier).setScale(selected);
  }
}

Future<void> _selectLanguage(
  BuildContext context,
  WidgetRef ref,
  AppLanguage current,
) async {
  final l10n = context.l10n;
  final selected = await _showOptionSheet<AppLanguage>(
    context,
    title: l10n.settingsLanguage,
    selected: current,
    options: [
      for (final language in AppLanguage.values)
        _SettingsOption(
          value: language,
          label: language.nativeName,
          icon: LucideIcons.languages,
        ),
    ],
  );
  if (selected != null) {
    ref.read(languageControllerProvider.notifier).setLanguage(selected);
  }
}

Future<void> _confirmLogout(BuildContext context, WidgetRef ref) async {
  final l10n = context.l10n;
  final confirmed = await showAppConfirmDialog(
    context,
    title: l10n.settingsLogoutConfirmTitle,
    description: l10n.settingsLogoutConfirmBody,
    icon: LucideIcons.logOut,
    confirmLabel: l10n.settingsLogout,
  );
  if (confirmed != true) return;

  await ref.read(sessionControllerProvider.notifier).logout();
  if (context.mounted) Navigator.of(context).pop(true);
}

class _SheetHeader extends StatelessWidget {
  const _SheetHeader();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              AppText(
                l10n.settingsTitle,
                type: AppTextType.h3,
                fontWeight: FontWeight.w700,
                maxLines: 1,
              ),
              const SizedBox(height: 2),
              AppText(
                l10n.settingsSubtitle,
                type: AppTextType.caption,
                maxLines: 1,
              ),
            ],
          ),
        ),
        const SizedBox(width: Spacing.control),
        const _CloseButton(),
      ],
    );
  }
}

class _CloseButton extends StatelessWidget {
  const _CloseButton();

  @override
  Widget build(BuildContext context) {
    final c = context.respiraColors;

    return Semantics(
      button: true,
      label: context.l10n.settingsClose,
      child: Material(
        color: c.surfaceSecondary,
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => Navigator.of(context).pop(false),
          child: const SizedBox(
            width: ControlSize.touchTargetMin,
            height: ControlSize.touchTargetMin,
            child: Center(
              child: AppIcon(LucideIcons.x, size: ControlSize.iconLg),
            ),
          ),
        ),
      ),
    );
  }
}

/// Closes the sheet, then opens the signed-in doctor's profile.
///
/// The router is captured first: popping the sheet deactivates its context,
/// so a later `context.push` would fail.
void _openDoctorProfile(BuildContext context) {
  final router = GoRouter.of(context);
  Navigator.of(context, rootNavigator: true).pop();
  router.push(AuthenticationRoutes.doctorProfile);
}

class _ProfileCard extends StatelessWidget {
  const _ProfileCard({required this.name, this.avatarUrl, this.onTap});

  final String name;
  final String? avatarUrl;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.respiraColors;
    return Semantics(
      button: onTap != null,
      label: context.l10n.doctorProfileOpen,
      child: Material(
        color: c.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.lgValue),
          side: BorderSide(color: c.borderSubtle),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(Spacing.group),
            child: Row(
              children: [
                AvatarGlyphWidget(
                  glyph: initialsFor(name),
                  size: 50,
                  imageUrl: avatarUrl,
                ),
                const SizedBox(width: Spacing.control),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppText(
                        name,
                        type: AppTextType.bodyLarge,
                        fontWeight: FontWeight.w700,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 3),
                      AppText(
                        context.l10n.settingsProfileSpecialty,
                        type: AppTextType.caption,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: Spacing.inline),
                const _Chevron(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppText(
      title,
      type: AppTextType.bodyLarge,
      fontWeight: FontWeight.w700,
    );
  }
}

class _SettingsGroup extends StatelessWidget {
  const _SettingsGroup({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return AppSurface(
      padding: const EdgeInsets.all(Spacing.inline),
      child: Column(mainAxisSize: MainAxisSize.min, children: children),
    );
  }
}

class _GroupDivider extends StatelessWidget {
  const _GroupDivider();

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 1,
      indent: Spacing.group,
      endIndent: Spacing.group,
      color: context.respiraColors.borderSubtle,
    );
  }
}

class _SettingsRow extends StatelessWidget {
  const _SettingsRow({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.trailing,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Widget trailing;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.respiraColors;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.md,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Spacing.group,
            vertical: 10,
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: c.primarySoft,
                  borderRadius: AppRadius.sm,
                ),
                child: AppIcon(
                  icon,
                  size: ControlSize.iconLg,
                  color: c.primary,
                ),
              ),
              const SizedBox(width: Spacing.control),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppText(
                      title,
                      type: AppTextType.body,
                      fontWeight: FontWeight.w600,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 3),
                    AppText(
                      subtitle,
                      type: AppTextType.label,
                      fontWeight: FontWeight.w400,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: Spacing.control),
              trailing,
            ],
          ),
        ),
      ),
    );
  }
}

class _ThemePill extends StatelessWidget {
  const _ThemePill(this.mode);

  final ThemeMode mode;

  @override
  Widget build(BuildContext context) {
    final c = context.respiraColors;
    final l10n = context.l10n;
    final (icon, label) = switch (mode) {
      ThemeMode.system => (LucideIcons.monitor, l10n.settingsThemeSystem),
      ThemeMode.light => (LucideIcons.sun, l10n.settingsThemeLight),
      ThemeMode.dark => (LucideIcons.moon, l10n.settingsThemeDark),
    };

    return Container(
      height: 30,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: c.primarySoft,
        borderRadius: AppRadius.full,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppIcon(icon, size: ControlSize.iconSm, color: c.primary),
          const SizedBox(width: 6),
          AppText(label, type: AppTextType.label, color: c.primary),
        ],
      ),
    );
  }
}

class _Chevron extends StatelessWidget {
  const _Chevron();

  @override
  Widget build(BuildContext context) {
    return AppIcon(
      LucideIcons.chevronRight,
      size: ControlSize.iconLg,
      color: context.respiraColors.iconMuted,
    );
  }
}

class _SettingsOption<T> {
  const _SettingsOption({
    required this.value,
    required this.label,
    required this.icon,
  });

  final T value;
  final String label;
  final IconData icon;
}

Future<T?> _showOptionSheet<T>(
  BuildContext context, {
  required String title,
  required List<_SettingsOption<T>> options,
  required T selected,
  String? note,
}) {
  return showModalBottomSheet<T>(
    context: context,
    useRootNavigator: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black.withValues(alpha: 0.32),
    builder: (_) => _OptionSheet<T>(
      title: title,
      options: options,
      selected: selected,
      note: note,
    ),
  );
}

class _OptionSheet<T> extends StatelessWidget {
  const _OptionSheet({
    required this.title,
    required this.options,
    required this.selected,
    this.note,
  });

  final String title;
  final List<_SettingsOption<T>> options;
  final T selected;
  final String? note;

  @override
  Widget build(BuildContext context) {
    final c = context.respiraColors;

    return Container(
      decoration: BoxDecoration(
        color: c.background,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppRadius.lgValue),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            Spacing.group,
            12,
            Spacing.group,
            Spacing.group,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(
                    color: c.borderStrong,
                    borderRadius: AppRadius.full,
                  ),
                ),
              ),
              const SizedBox(height: Spacing.group),
              AppText(title, type: AppTextType.h3, fontWeight: FontWeight.w700),
              const SizedBox(height: Spacing.control),
              AppSurface(
                padding: const EdgeInsets.all(Spacing.inline),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (var i = 0; i < options.length; i++) ...[
                      if (i > 0) const _GroupDivider(),
                      _OptionRow<T>(
                        option: options[i],
                        selected: options[i].value == selected,
                        onTap: () =>
                            Navigator.of(context).pop(options[i].value),
                      ),
                    ],
                  ],
                ),
              ),
              if (note != null) ...[
                const SizedBox(height: Spacing.control),
                AppText(
                  note!,
                  type: AppTextType.caption,
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _OptionRow<T> extends StatelessWidget {
  const _OptionRow({
    required this.option,
    required this.selected,
    required this.onTap,
  });

  final _SettingsOption<T> option;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.respiraColors;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.md,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Spacing.group,
            vertical: Spacing.control,
          ),
          child: Row(
            children: [
              AppIcon(
                option.icon,
                size: ControlSize.iconLg,
                color: selected ? c.primary : c.iconMuted,
              ),
              const SizedBox(width: Spacing.control),
              Expanded(
                child: AppText(
                  option.label,
                  type: AppTextType.bodyMedium,
                  color: selected ? c.primary : c.textPrimary,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
              if (selected)
                AppIcon(
                  LucideIcons.check,
                  size: ControlSize.iconLg,
                  color: c.primary,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

