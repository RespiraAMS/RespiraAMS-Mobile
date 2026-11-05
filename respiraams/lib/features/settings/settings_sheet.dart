import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../core/theme/theme_mode_provider.dart';
import '../../design_system/design_system.dart';
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
  ).push<bool>(_SettingsDrawerRoute());
  if (loggedOut == true && context.mounted) {
    context.go(AuthenticationRoutes.login);
  }
}

class _SettingsDrawerRoute extends PopupRoute<bool> {
  @override
  Color? get barrierColor => Colors.black.withValues(alpha: 0.32);

  @override
  bool get barrierDismissible => true;

  @override
  String? get barrierLabel => 'Đóng cài đặt';

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
    final themeMode = ref.watch(themeModeControllerProvider);
    final textScale = ref.watch(appTextScaleControllerProvider);
    final session = ref.watch(sessionDoctorProvider);
    final name = (session?.name.trim().isNotEmpty ?? false)
        ? session!.name.trim()
        : 'Bác sĩ';

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
                  _ProfileCard(name: name),
                  const SizedBox(height: Spacing.section),
                  const _SectionTitle('Giao diện'),
                  const SizedBox(height: Spacing.inline),
                  _SettingsGroup(
                    children: [
                      _SettingsRow(
                        icon: LucideIcons.monitor,
                        title: 'Giao diện',
                        subtitle: 'Sáng hoặc tối',
                        trailing: _ThemePill(themeMode),
                        onTap: () => _selectTheme(context, ref, themeMode),
                      ),
                      const _GroupDivider(),
                      _SettingsRow(
                        icon: LucideIcons.type,
                        title: 'Cỡ chữ',
                        subtitle: textScale.label,
                        trailing: const _Chevron(),
                        onTap: () => _selectTextScale(context, ref, textScale),
                      ),
                      const _GroupDivider(),
                      _SettingsRow(
                        icon: LucideIcons.languages,
                        title: 'Ngôn ngữ',
                        subtitle: 'Tiếng Việt',
                        trailing: const _Chevron(),
                        onTap: () => _showLanguageInfo(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: Spacing.section),
                  AppButton(
                    label: 'Đăng xuất',
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
  final selected = await _showOptionSheet<ThemeMode>(
    context,
    title: 'Chế độ hiển thị',
    selected: current,
    options: const [
      _SettingsOption(
        value: ThemeMode.system,
        label: 'Hệ thống',
        icon: LucideIcons.monitor,
      ),
      _SettingsOption(
        value: ThemeMode.light,
        label: 'Sáng',
        icon: LucideIcons.sun,
      ),
      _SettingsOption(
        value: ThemeMode.dark,
        label: 'Tối',
        icon: LucideIcons.moon,
      ),
    ],
  );
  if (selected != null) {
    ref.read(themeModeControllerProvider.notifier).setMode(selected);
  }
}

Future<void> _selectTextScale(
  BuildContext context,
  WidgetRef ref,
  AppTextScale current,
) async {
  final selected = await _showOptionSheet<AppTextScale>(
    context,
    title: 'Cỡ chữ',
    selected: current,
    options: [
      for (final scale in AppTextScale.values)
        _SettingsOption(
          value: scale,
          label: scale.label,
          icon: LucideIcons.type,
        ),
    ],
  );
  if (selected != null) {
    ref.read(appTextScaleControllerProvider.notifier).setScale(selected);
  }
}

Future<void> _showLanguageInfo(BuildContext context) async {
  await _showOptionSheet<String>(
    context,
    title: 'Ngôn ngữ',
    selected: 'vi',
    note: 'Hiện chỉ hỗ trợ tiếng Việt.',
    options: const [
      _SettingsOption(
        value: 'vi',
        label: 'Tiếng Việt',
        icon: LucideIcons.languages,
      ),
    ],
  );
}

Future<void> _confirmLogout(BuildContext context, WidgetRef ref) async {
  final confirmed = await showAppConfirmDialog(
    context,
    title: 'Đăng xuất?',
    description: 'Bạn sẽ cần đăng nhập lại để tiếp tục sử dụng RespiraAMS.',
    icon: LucideIcons.logOut,
    confirmLabel: 'Đăng xuất',
  );
  if (confirmed != true) return;

  await ref.read(sessionControllerProvider.notifier).logout();
  if (context.mounted) Navigator.of(context).pop(true);
}

class _SheetHeader extends StatelessWidget {
  const _SheetHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              AppText(
                'Cài đặt',
                type: AppTextType.h3,
                fontWeight: FontWeight.w700,
                maxLines: 1,
              ),
              SizedBox(height: 2),
              AppText(
                'Cá nhân hóa trải nghiệm',
                type: AppTextType.caption,
                maxLines: 1,
              ),
            ],
          ),
        ),
        const SizedBox(width: Spacing.control),
        _CloseButton(),
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
      label: 'Đóng cài đặt',
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

class _ProfileCard extends StatelessWidget {
  const _ProfileCard({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return AppSurface(
      padding: const EdgeInsets.all(Spacing.group),
      child: Row(
        children: [
          AvatarGlyphWidget(glyph: _initialsFor(name), size: 50),
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
                const AppText(
                  'Chuyên khoa Hô hấp',
                  type: AppTextType.caption,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
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
    final (icon, label) = switch (mode) {
      ThemeMode.system => (LucideIcons.monitor, 'Hệ thống'),
      ThemeMode.light => (LucideIcons.sun, 'Sáng'),
      ThemeMode.dark => (LucideIcons.moon, 'Tối'),
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

/// Builds an avatar glyph from the session name.
///
/// The local auth flow stores the email as the doctor name, so e-mails are
/// reduced to their local part (e.g. `bs.minh@respira.vn` → `BM`).
String _initialsFor(String name) {
  var value = name.trim();
  if (value.isEmpty) return 'BS';
  if (value.contains('@')) {
    value = value.split('@').first.replaceAll(RegExp(r'[._-]+'), ' ');
  }

  final parts = value
      .split(RegExp(r'\s+'))
      .where((part) => part.isNotEmpty)
      .toList();
  if (parts.isEmpty) return 'BS';

  String firstChar(String part) =>
      String.fromCharCode(part.runes.first).toUpperCase();

  if (parts.length == 1) {
    final part = parts.first;
    return part.runes.length >= 2
        ? String.fromCharCodes(part.runes.take(2)).toUpperCase()
        : firstChar(part);
  }
  return '${firstChar(parts.last)}${firstChar(parts.first)}';
}
