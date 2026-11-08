import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/context_extensions.dart';
import '../../../../design_system/design_system.dart';
import '../../../../l10n/l10n.dart';
import '../models/new_password_form_state.dart';
import '../providers/new_password_controller.dart';
import '../widgets/brand_header_widget.dart';
import '../widgets/password_requirement_widget.dart';
import '../routes.dart';

/// Route `/new-password` — password-reset step 2/2: set a new password.
class NewPasswordScreen extends ConsumerWidget {
  const NewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = ref.watch(newPasswordControllerProvider);
    final controller = ref.read(newPasswordControllerProvider.notifier);
    final c = context.respiraColors;
    final l10n = context.l10n;

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
                        l10n.authNewPasswordTitle,
                        style: TypographyTokens.h1(
                          context,
                        ).copyWith(color: c.textPrimary),
                      ),
                      const SizedBox(height: Spacing.inline),
                      AppText(
                        l10n.authNewPasswordBody,
                      ),
                      const SizedBox(height: Spacing.section),
                      AppTextField(
                        label: l10n.authNewPasswordLabel,
                        initialValue: form.password,
                        onChanged: controller.setPassword,
                        obscureText: true,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: Spacing.group),
                      AppTextField(
                        label: l10n.authConfirmPasswordLabel,
                        initialValue: form.confirmPassword,
                        onChanged: controller.setConfirmPassword,
                        obscureText: true,
                        textInputAction: TextInputAction.done,
                      ),
                      const SizedBox(height: Spacing.section),
                      AppSurface(
                        radius: AppRadius.lgValue,
                        color: c.surfaceSecondary,
                        borderColor: Colors.transparent,
                        padding: const EdgeInsets.all(Spacing.group),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.authPasswordRequirements,
                              style: TypographyTokens.body(
                                context,
                              ).copyWith(fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(height: Spacing.control - 4),
                            PasswordRequirementWidget(
                              label: l10n.authMinLength,
                              met: form.hasMinLength,
                            ),
                            const SizedBox(height: Spacing.inline - 4),
                            PasswordRequirementWidget(
                              label: l10n.authUppercase,
                              met: form.hasUppercase,
                            ),
                            const SizedBox(height: Spacing.inline - 4),
                            PasswordRequirementWidget(
                              label: l10n.authDigitOrSpecial,
                              met: form.hasDigitOrSpecial,
                            ),
                          ],
                        ),
                      ),
                      if (!form.passwordsMatch &&
                          form.confirmPassword.isNotEmpty) ...[
                        const SizedBox(height: Spacing.control),
                        // Error never relies on color alone (§12).
                        Text(
                          l10n.authPasswordMismatch,
                          style: TypographyTokens.caption(
                            context,
                          ).copyWith(color: c.error),
                        ),
                      ],
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(bottom: Spacing.inline),
                        child: Column(
                          children: [
                            AppButton(
                              label: l10n.authUpdatePassword,
                              expand: true,
                              onPressed: form.canSubmit
                                  ? () => context.push(
                                      AuthenticationRoutes.passwordResetSuccess,
                                    )
                                  : null,
                            ),
                            const SizedBox(height: Spacing.control),
                            AppButton(
                              label: l10n.authCancelBack,
                              type: AppButtonType.secondary,
                              expand: true,
                              onPressed: () =>
                                  context.goBackOr(AuthenticationRoutes.login),
                            ),
                          ],
                        ),
                      ),
                      AppText(
                        l10n.authStepPassword,
                        type: AppTextType.caption,
                        color: c.textTertiary,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: Spacing.inline),
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
