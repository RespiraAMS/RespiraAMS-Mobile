import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/context_extensions.dart';
import '../../../../design_system/design_system.dart';
import '../../../../l10n/l10n.dart';
import '../models/otp_state.dart';
import '../providers/otp_controller.dart';
import '../widgets/brand_header_widget.dart';
import '../widgets/otp_input_widget.dart';
import '../routes.dart';

/// Route `/otp-verification` — password-reset step 1/2: verify identity.
class OtpVerificationScreen extends ConsumerWidget {
  const OtpVerificationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final otp = ref.watch(otpControllerProvider);
    final controller = ref.read(otpControllerProvider.notifier);
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
                      const Center(child: BrandHeaderWidget()),
                      const SizedBox(height: Spacing.section),
                      // Overlapping avatars inside a soft pill (template
                      // decoration; network images replaced by glyphs).
                      Center(
                        child: Container(
                          height: 64,
                          padding: const EdgeInsets.symmetric(
                            horizontal: Spacing.group,
                          ),
                          decoration: BoxDecoration(
                            color: c.primarySoft,
                            borderRadius: AppRadius.full,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AvatarGlyphWidget(glyph: '👨🏻', size: 44),
                              Transform.translate(
                                offset: const Offset(-12, 0),
                                child: AvatarGlyphWidget(
                                  glyph: '👩🏾',
                                  size: 44,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: Spacing.section),
                      Text(
                        l10n.authOtpTitle,
                        style: TypographyTokens.h1(
                          context,
                        ).copyWith(color: c.textPrimary),
                      ),
                      const SizedBox(height: Spacing.inline),
                      AppText(l10n.authOtpSentTo('bs.m***@respira.vn')),
                      const SizedBox(height: Spacing.section),
                      OtpInputWidget(
                        value: otp.digits,
                        onChanged: controller.digitChanged,
                      ),
                      const SizedBox(height: Spacing.block - 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText(
                            l10n.authResendIn(
                              otp.secondsRemaining.toString().padLeft(2, '0'),
                            ),
                            type: AppTextType.caption,
                          ),
                          if (otp.secondsRemaining == 0)
                            AppLinkText(
                              l10n.authResend,
                              onPressed: controller.resend,
                            )
                          else
                            Opacity(
                              opacity: 0.5,
                              child: AppLinkText(l10n.authResend),
                            ),
                        ],
                      ),
                      const SizedBox(height: Spacing.control + 4),
                      AppButton(
                        label: l10n.authConfirm,
                        expand: true,
                        onPressed: otp.isComplete
                            ? () =>
                                  context.push(AuthenticationRoutes.newPassword)
                            : null,
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
                              l10n.authAccountSecurityTitle,
                              style: TypographyTokens.bodyLarge(
                                context,
                              ).copyWith(fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(height: Spacing.inline - 4),
                            AppText(
                              l10n.authAccountSecurityBody,
                              type: AppTextType.caption,
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(bottom: Spacing.inline),
                        child: AppButton(
                          label: l10n.authChangeEmail,
                          type: AppButtonType.secondary,
                          expand: true,
                          onPressed: () => context.goBackOr(
                            AuthenticationRoutes.forgotPassword,
                          ),
                        ),
                      ),
                      AppText(
                        l10n.authStepIdentity,
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
