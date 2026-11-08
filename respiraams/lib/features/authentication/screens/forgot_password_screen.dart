import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/utils/context_extensions.dart';
import '../../../../design_system/design_system.dart';
import '../../../../l10n/l10n.dart';
import '../providers/forgot_password_controller.dart';
import '../widgets/brand_header_widget.dart';
import '../routes.dart';

/// Route `/forgot-password` — request a 6-digit verification code.
class ForgotPasswordScreen extends ConsumerWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = ref.watch(forgotPasswordControllerProvider);
    final controller = ref.read(forgotPasswordControllerProvider.notifier);
    final c = context.respiraColors;
    final l10n = context.l10n;

    void submit() {
      if (controller.submit()) {
        context.push(AuthenticationRoutes.otpVerification);
      }
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
                      Align(
                        alignment: Alignment.centerLeft,
                        child: _BackButton(
                          onTap: () =>
                              context.goBackOr(AuthenticationRoutes.login),
                        ),
                      ),
                      const SizedBox(height: Spacing.block),
                      const Center(child: RespiraLogoMarkWidget(size: 48)),
                      const SizedBox(height: Spacing.section),
                      Text(
                        l10n.authForgotTitle,
                        style: TypographyTokens.h1(
                          context,
                        ).copyWith(color: c.textPrimary),
                      ),
                      const SizedBox(height: Spacing.inline),
                      AppText(
                        l10n.authForgotBody,
                      ),
                      const SizedBox(height: Spacing.section + 4),
                      AppTextField(
                        label: l10n.authWorkEmailLabel,
                        initialValue: form.email,
                        onChanged: controller.setEmail,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.done,
                        hintText: 'bs.minh@respira.vn',
                        errorText:
                            form.emailInvalid ? l10n.authEmailInvalid : null,
                      ),
                      const SizedBox(height: Spacing.section),
                      AppButton(
                        label: l10n.authSendCode,
                        expand: true,
                        onPressed: submit,
                      ),
                      const SizedBox(height: Spacing.control),
                      AppButton(
                        label: l10n.authBackToLogin,
                        type: AppButtonType.secondary,
                        expand: true,
                        onPressed: () =>
                            context.goBackOr(AuthenticationRoutes.login),
                      ),
                      const SizedBox(height: Spacing.section),
                      AppSurface(
                        radius: AppRadius.lgValue - 4,
                        padding: const EdgeInsets.all(Spacing.group),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.authNoEmailTitle,
                              style: TypographyTokens.bodyMedium(
                                context,
                              ).copyWith(fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(height: Spacing.inline - 4),
                            AppText(
                              l10n.authNoEmailBody,
                              type: AppTextType.caption,
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
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

class _BackButton extends StatelessWidget {
  const _BackButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.respiraColors;

    return Material(
      color: c.surfaceSecondary,
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        width: ControlSize.touchTargetMin,
        height: ControlSize.touchTargetMin,
        child: InkWell(
          onTap: onTap,
          child: Icon(
            LucideIcons.arrowLeft,
            size: ControlSize.iconLg,
            color: c.iconDefault,
          ),
        ),
      ),
    );
  }
}
