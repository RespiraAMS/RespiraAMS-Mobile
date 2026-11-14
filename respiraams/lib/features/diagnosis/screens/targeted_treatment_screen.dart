import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/context_extensions.dart';
import '../../../../design_system/design_system.dart';
import '../../../../l10n/l10n.dart';
import '../../../../features/patient/models/patient.dart';
import '../../../../features/patient/providers/current_patient_provider.dart';
import '../../../../features/patient/routes.dart';
import '../models/clinical_dtos.dart';
import '../models/microbiology_result.dart';
import '../providers/microbiology_provider.dart';
import '../providers/targeted_treatment_provider.dart';
import '../widgets/microbiology_banner.dart';
import '../widgets/treatment_option_row_widget.dart';

/// Route `/targeted-treatment` — "Chẩn đoán vi sinh": pathogen from the
/// API, then pick drug + route combinations from the targeted-diagnose
/// result and save.
class TargetedTreatmentScreen extends ConsumerWidget {
  const TargetedTreatmentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = context.respiraColors;
    final l10n = context.l10n;
    final micro = ref.watch(microbiologyResultProvider);
    final patient = ref.watch(currentPatientProvider);
    final pathogensAsync = ref.watch(pathogenListProvider);
    final pathogens = pathogensAsync.value ?? const [];
    final pathogen = pathogens.isNotEmpty ? pathogens.first : null;
    final diagnoseAsync = pathogen == null
        ? const AsyncValue<TargetedDiagnoseResultDto>.loading()
        : ref.watch(targetedDiagnoseResultProvider(pathogen.id));
    final result = diagnoseAsync.value;

    final selection = ref.watch(targetedSelectionControllerProvider);
    final selectedDrugs = result == null
        ? const []
        : result.recommendations
            .where((r) => selection.contains(r.id))
            .toList();
    String abbrev(String route) => routeAbbrev(route, l10n);
    final chips = selectedDrugs
        .asMap()
        .entries
        .map((e) =>
            'P${e.key + 1} · ${e.value.name} · ${abbrev(e.value.dosages.isEmpty ? 'Oral' : e.value.dosages.first.routeOfAdministration)}')
        .toList();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Spacing.group),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppAppBar(
                title: l10n.targetedTitle,
                subtitle: l10n.targetedSubtitle,
                onBack: () => context.goBackOr(PatientRoutes.list),
              ),
              const SizedBox(height: Spacing.section),
              Expanded(
                child: diagnoseAsync.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : diagnoseAsync.hasError
                        ? _ErrorView(
                            message: l10n.targetedLoadError)
                        : SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // Patient context.
                                Container(
                                  padding: const EdgeInsets.all(
                                      Spacing.control + 2),
                                  decoration: BoxDecoration(
                                    color: c.surfaceSecondary,
                                    borderRadius: AppRadius.md,
                                  ),
                                  child: Row(
                                    children: [
                                      AvatarGlyphWidget(
                                        glyph: patient?.gender == Gender.nu
                                            ? '👩🏾'
                                            : '👨🏻',
                                      ),
                                      const SizedBox(width: Spacing.group),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              patient?.name ??
                                                  l10n.patientNoSelection,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TypographyTokens.body(
                                                      context)
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w700),
                                            ),
                                            const SizedBox(
                                                height: Spacing.xxxs),
                                            AppText(patient?.code ?? '',
                                                type: AppTextType.caption),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: Spacing.block),
                                BacteriaDisplayField(
                                    bacteria: micro.bacteria),
                                const SizedBox(height: Spacing.control),
                                AntibiogramBanner(
                                    line: micro.antibiogramLine),
                                const SizedBox(height: Spacing.section),
                                Text(
                                  l10n.targetedSelectDrugs,
                                  style: TypographyTokens.caption(context)
                                      .copyWith(color: c.textPrimary),
                                ),
                                const SizedBox(height: Spacing.inline),
                                if (result != null)
                                  for (final recommendation
                                      in result.recommendations) ...[
                                    Builder(builder: (context) {
                                      final dosages = recommendation.dosages;
                                      final apiRoute = dosages.isEmpty
                                          ? 'Oral'
                                          : dosages.first.routeOfAdministration;
                                      final abbreviated =
                                          routeAbbrev(apiRoute, l10n);
                                      return TreatmentOptionRowWidget(
                                        option: TreatmentOption(
                                          id: recommendation.id,
                                          drug: recommendation.name,
                                          route: apiRoute,
                                          routeAbbrev: abbreviated,
                                          dosage: dosages.isEmpty
                                              ? ''
                                              : dosages.first.dose,
                                          susceptibility: Susceptibility.s,
                                        ),
                                        selected: selection
                                            .contains(recommendation.id),
                                        onToggle: () => ref
                                            .read(
                                                targetedSelectionControllerProvider
                                                    .notifier)
                                            .toggle(recommendation.id),
                                      );
                                    }),
                                    if (recommendation !=
                                        result.recommendations.last)
                                      const SizedBox(
                                          height: Spacing.inline),
                                  ],
                                const SizedBox(height: Spacing.section),
                                // Selection summary.
                                Container(
                                  padding:
                                      const EdgeInsets.all(Spacing.group),
                                  decoration: BoxDecoration(
                                    color: c.surface,
                                    borderRadius: AppRadius.md,
                                    border:
                                        Border.all(color: c.borderSubtle),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AppText(
                                          l10n.targetedSelectedSummary,
                                          type: AppTextType.caption),
                                      const SizedBox(
                                          height: Spacing.inline),
                                      Wrap(
                                        spacing: Spacing.inline,
                                        runSpacing: Spacing.inline,
                                        children: [
                                          for (final chip in chips)
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal:
                                                    Spacing.control,
                                                vertical: Spacing.xxxs + 2,
                                              ),
                                              decoration: BoxDecoration(
                                                color: c.primarySoft,
                                                borderRadius:
                                                    AppRadius.full,
                                              ),
                                              child: Text(
                                                chip,
                                                style: TypographyTokens
                                                        .label(context)
                                                    .copyWith(
                                                        color:
                                                            c.primary),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: Spacing.section),
                              ],
                            ),
                          ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: Spacing.lg),
                child: AppButton(
                  label: l10n.targetedSave,
                  expand: true,
                  onPressed: () => showAppToast(
                    context,
                    l10n.commonComingSoon,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final c = context.respiraColors;
    return Center(
      child: Text(
        message,
        style: TypographyTokens.caption(context).copyWith(color: c.error),
      ),
    );
  }
}
