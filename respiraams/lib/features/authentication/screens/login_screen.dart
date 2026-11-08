import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../design_system/design_system.dart';
import '../../../../l10n/l10n.dart';
import '../providers/login_controller.dart';
import '../widgets/brand_header_widget.dart';
import '../routes.dart';

/// Route `/login` — email/staff-code sign-in.
class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = ref.watch(loginControllerProvider);
    final controller = ref.read(loginControllerProvider.notifier);
    final c = context.respiraColors;
    final l10n = context.l10n;

    Future<void> submit() async {
      if (!controller.canSubmit) {
        showAppToast(context, l10n.authMissingCredentials);
        return;
      }
      final ok = await controller.submit();
      if (!context.mounted) return;
      if (ok) {
        // Post-login landing page.
        context.go(AuthenticationRoutes.welcome);
      }
      // Failure: errorMessage is rendered under the fields (text + color).
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Spacing.xl),
          child: LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: Spacing.xxs),
                      const BrandHeaderWidget(),
                      const SizedBox(height: Spacing.section + 4),
                      Text(
                        l10n.authLoginTitle,
                        style: TypographyTokens.h1(
                          context,
                        ).copyWith(color: c.textPrimary),
                      ),
                      const SizedBox(height: Spacing.inline),
                      AppText(l10n.authLoginSubtitle),
                      const SizedBox(height: Spacing.section),
                      AppTextField(
                        label: l10n.authEmailLabel,
                        initialValue: form.identifier,
                        onChanged: controller.setIdentifier,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        hintText: 'bs.minh@respira.vn',
                      ),
                      const SizedBox(height: Spacing.group),
                      AppTextField(
                        label: l10n.authPasswordLabel,
                        initialValue: form.password,
                        onChanged: controller.setPassword,
                        obscureText: true,
                        textInputAction: TextInputAction.done,
                        hintText: '••••••••',
                      ),
                      if (form.networkError || form.errorMessage != null) ...[
                        const SizedBox(height: Spacing.inline),
                        // Error = text + icon semantics, never color alone (§12).
                        Row(
                          children: [
                            Icon(Icons.error_outline,
                                size: 16, color: c.error),
                            const SizedBox(width: Spacing.xxs),
                            Expanded(
                              child: Text(
                                form.networkError
                                    ? l10n.authServerUnreachable
                                    : form.errorMessage!,
                                style: TypographyTokens.caption(context)
                                    .copyWith(color: c.error),
                              ),
                            ),
                          ],
                        ),
                      ],
                      const SizedBox(height: Spacing.inline),
                      Align(
                        alignment: Alignment.centerRight,
                        child: AppLinkText(
                          l10n.authForgotPassword,
                          onPressed: () =>
                              context.push(AuthenticationRoutes.forgotPassword),
                        ),
                      ),
                      const SizedBox(height: Spacing.block - 4),
                      AppButton(
                        label: l10n.authLoginButton,
                        expand: true,
                        loading: form.submitting,
                        onPressed: controller.canSubmit ? submit : null,
                      ),
                      const SizedBox(height: Spacing.section),
                      _DividerWithLabel(label: l10n.authOr),
                      const SizedBox(height: Spacing.control),
                      AppButton(
                        label: l10n.authUseStaffCode,
                        type: AppButtonType.outline,
                        expand: true,
                        // Staff-code sign-in flow is not designed yet.
                        onPressed: () => showAppToast(
                          context,
                          l10n.authStaffCodeComingSoon,
                        ),
                      ),
                      const SizedBox(height: Spacing.section),
                      AppSurface(
                        radius: AppRadius.lgValue,
                        color: c.surfaceSecondary,
                        borderColor: Colors.transparent,
                        padding: const EdgeInsets.all(Spacing.group),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: ControlSize.touchTargetMin,
                              height: ControlSize.touchTargetMin,
                              decoration: BoxDecoration(
                                color: c.primarySoft,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                LucideIcons.shieldCheck,
                                size: ControlSize.iconLg,
                                color: c.primary,
                              ),
                            ),
                            const SizedBox(width: Spacing.control + 4),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    l10n.authSecureSessionTitle,
                                    style: TypographyTokens.body(
                                      context,
                                    ).copyWith(fontWeight: FontWeight.w700),
                                  ),
                                  const SizedBox(height: Spacing.xxs - 4),
                                  AppText(
                                    l10n.authSecureSessionBody,
                                    type: AppTextType.caption,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(bottom: Spacing.inline),
                        child: AppText(
                          l10n.authSupportFooter,
                          type: AppTextType.caption,
                          color: c.textTertiary,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DividerWithLabel extends StatelessWidget {
  const _DividerWithLabel({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final c = context.respiraColors;

    return Row(
      children: [
        Expanded(child: Container(height: 1, color: c.borderSubtle)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Spacing.control),
          child: Text(
            label,
            style: TypographyTokens.caption(
              context,
            ).copyWith(color: c.textTertiary),
          ),
        ),
        Expanded(child: Container(height: 1, color: c.borderSubtle)),
      ],
    );
  }
}
