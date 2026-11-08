import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:respiraams/features/patient/routes.dart';

import '../../../../design_system/design_system.dart';
import '../../../../l10n/l10n.dart';
import '../widgets/brand_header_widget.dart';

/// Route `/welcome` — post-login landing page with workspace summary.
class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = context.respiraColors;
    final l10n = context.l10n;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Spacing.group),
          child: LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const BrandHeaderWidget(),
                      const SizedBox(height: Spacing.lg),
                      // Hero placeholder (offline-safe avatar glyph instead
                      // of the template's network images).
                      Center(
                        child: AvatarGlyphWidget(
                          glyph: '👨🏻‍⚕️',
                          size: 180,
                        ),
                      ),
                      const SizedBox(height: Spacing.group),
                      Center(
                        child: Container(
                          height: 32,
                          padding: const EdgeInsets.symmetric(
                            horizontal: Spacing.group,
                          ),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: c.primarySoft,
                            borderRadius:
                                BorderRadius.circular(AppRadius.mdValue),
                          ),
                          child: Text(
                            l10n.authWorkspaceEyebrow,
                            style: TypographyTokens.label(context)
                                .copyWith(color: c.primary),
                          ),
                        ),
                      ),
                      const SizedBox(height: Spacing.section),
                      AppSurface(
                        radius: AppRadius.lgValue,
                        padding: const EdgeInsets.all(Spacing.group),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AvatarGlyphWidget(glyph: '👨🏻', size: 48),
                                const SizedBox(width: Spacing.group),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        l10n.authWelcomeGreeting(
                                          l10n.authDemoDoctorName,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TypographyTokens.body(context)
                                            .copyWith(
                                                fontWeight: FontWeight.w700),
                                      ),
                                      const SizedBox(height: Spacing.xxs),
                                      AppText(
                                        l10n.authWelcomeSubtitle,
                                        type: AppTextType.caption,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: Spacing.control),
                            _BulletRow(text: l10n.authWelcomeBulletPatients),
                            const SizedBox(height: Spacing.inline - 4),
                            _BulletRow(text: l10n.authWelcomeBulletAttention),
                            const SizedBox(height: Spacing.inline - 4),
                            _BulletRow(text: l10n.authWelcomeBulletSynced),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(vertical: Spacing.lg),
                        child: Column(
                          children: [
                            AppButton(
                              label: l10n.authStart,
                              expand: true,
                              // Enters the clinical workspace, clearing the
                              // auth stack.
                              // Enters the workspace home (patient roster),
                              // clearing the auth stack.
                              onPressed: () => context.go(PatientRoutes.list),
                            ),
                            const SizedBox(height: Spacing.control),
                            AppText(
                              l10n.authPrivacyFooter,
                              type: AppTextType.caption,
                              color: c.textTertiary,
                              textAlign: TextAlign.center,
                            ),
                          ],
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

class _BulletRow extends StatelessWidget {
  const _BulletRow({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final c = context.respiraColors;

    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration:
              BoxDecoration(color: c.primary, shape: BoxShape.circle),
        ),
        const SizedBox(width: Spacing.xxs + 4),
        Expanded(
          child: AppText(text, type: AppTextType.bodyMedium),
        ),
      ],
    );
  }
}
