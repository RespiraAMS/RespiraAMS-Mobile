import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/context_extensions.dart';
import '../../../../design_system/design_system.dart';
import '../../../../l10n/l10n.dart';
import '../models/clinical_dtos.dart';
import '../models/diagnosis_result.dart';
import '../providers/diagnosis_flow_provider.dart';
import '../providers/diagnosis_tab_controller.dart';
import '../widgets/risk_pill_widget.dart';
import '../widgets/stat_tile_widget.dart';

import '../routes.dart';

/// Route `/diagnosis-result` — wizard output (result summary · suspected
/// pathogens · evidences), rendered from the real `POST /diagnose/empirical`
/// response.
class DiagnosisResultScreen extends ConsumerWidget {
  const DiagnosisResultScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final result = ref.watch(diagnosisFlowControllerProvider).result;
    final tab = ref.watch(diagnosisTabControllerProvider);
    final tabController = ref.read(diagnosisTabControllerProvider.notifier);
    final l10n = context.l10n;

    if (result == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

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
                      AppAppBar(
                        title: l10n.diagnosisResultTitle,
                        subtitle: l10n.diagnosisResultSubtitle,
                        onBack: () => context.goBackOr(DiagnosisRoutes.wizard),
                      ),
                      const SizedBox(height: Spacing.inline + 4),
                      AppSegmentedTabs<DiagnosisTab>(
                        segments: [
                          for (final t in DiagnosisTab.values)
                            (t, t.label(l10n)),
                        ],
                        selected: tab,
                        onChanged: tabController.select,
                      ),
                      const SizedBox(height: Spacing.section),
                      switch (tab) {
                        DiagnosisTab.result => _ResultTab(result: result),
                        DiagnosisTab.suspected =>
                          _SuspectedTab(result: result),
                        DiagnosisTab.evidences =>
                          _EvidencesTab(evidences: result.evidences),
                      },
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: Spacing.block,
                          bottom: Spacing.lg,
                        ),
                        child: AppButton(
                          label: l10n.diagnosisSaveResult,
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
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TypographyTokens.bodyLarge(
        context,
      ).copyWith(fontWeight: FontWeight.w700),
    );
  }
}

String _severityLabel(String severity, AppLocalizations l10n) =>
    switch (severity) {
      'Mild' => l10n.severityMild,
      'Moderate' => l10n.severityModerate,
      'Severe' => l10n.severitySevere,
      _ => severity,
    };

String _siteLabel(String site, AppLocalizations l10n) => switch (site) {
      'Inpatient' => l10n.siteInpatient,
      'IntensiveCareUnit' => l10n.siteIcu,
      _ => l10n.siteOutpatient,
    };

class _ResultTab extends StatelessWidget {
  const _ResultTab({required this.result});

  final DiagnoseResultDto result;

  @override
  Widget build(BuildContext context) {
    final c = context.respiraColors;
    final l10n = context.l10n;
    final severityIsHigh = result.severity == 'Severe';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _SectionTitle(l10n.diagnosisSectionDiagnosis),
        const SizedBox(height: Spacing.xxs + 4),
        AppSurface(
          radius: AppRadius.mdValue,
          color: c.surfaceSecondary,
          borderColor: Colors.transparent,
          padding: const EdgeInsets.all(Spacing.group - 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.diagnosisCommunityPneumonia,
                style:
                    TypographyTokens.h3(context).copyWith(color: c.textPrimary),
              ),
              const SizedBox(height: Spacing.xxxs),
              AppText(l10n.diagnosisEmpiricalLabel, type: AppTextType.caption),
            ],
          ),
        ),
        const SizedBox(height: Spacing.section),
        _SectionTitle(l10n.diagnosisSectionAssessment),
        const SizedBox(height: Spacing.control - 4),
        Row(
          children: [
            Expanded(
              child: StatTileWidget(
                label: l10n.diagnosisSeverity,
                value: _severityLabel(result.severity, l10n),
                tone: StatTileTone.primary,
              ),
            ),
            const SizedBox(width: Spacing.group),
            Expanded(
              child: StatTileWidget(
                label: l10n.diagnosisTreatment,
                value: _siteLabel(result.treatmentSite, l10n),
              ),
            ),
          ],
        ),
        const SizedBox(height: Spacing.block - 4),
        RiskPillWidget(
          label: severityIsHigh ? l10n.riskHigh : l10n.riskLow,
          isHigh: severityIsHigh,
        ),
        if (result.isPatientPregnantOrInLactationPhase) ...[
          const SizedBox(height: Spacing.control),
          ClinicalAlert(
            severity: ClinicalSeverity.needsAttention,
            title: l10n.alertPregnantTitle,
            description: l10n.alertPregnantDesc,
          ),
        ],
        if (result.missingVariables.isNotEmpty) ...[
          const SizedBox(height: Spacing.control),
          ClinicalAlert(
            severity: ClinicalSeverity.needsAttention,
            title: l10n.alertMissingTitle,
            description: result.missingVariables
                .map((v) => v.name)
                .take(6)
                .join(', '),
          ),
        ],
        const SizedBox(height: Spacing.control + 4),
        AppText(
          l10n.diagnosisConfirmNote,
          type: AppTextType.caption,
        ),
      ],
    );
  }
}

class _SuspectedTab extends StatelessWidget {
  const _SuspectedTab({required this.result});

  final DiagnoseResultDto result;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _SectionTitle(l10n.suspectedHeavy),
        const SizedBox(height: Spacing.control + 4),
        if (result.heavySuspected.isEmpty)
          AppText(l10n.diagnosisNoData, type: AppTextType.caption)
        else
          AppCard.divided([
            for (final pathogen in result.heavySuspected)
              _RefRow(title: pathogen.name),
          ]),
        const SizedBox(height: Spacing.section),
        _SectionTitle(l10n.suspectedWorth),
        const SizedBox(height: Spacing.control + 4),
        if (result.worthSuspected.isEmpty)
          AppText(l10n.diagnosisNoData, type: AppTextType.caption)
        else
          AppCard.divided([
            for (final pathogen in result.worthSuspected)
              _RefRow(title: pathogen.name),
          ]),
      ],
    );
  }
}

class _RefRow extends StatelessWidget {
  const _RefRow({required this.title, this.trailing});

  final String title;
  final String? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Spacing.control,
        vertical: Spacing.group,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TypographyTokens.body(context)
                  .copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          if (trailing != null)
            AppText(trailing!, type: AppTextType.caption),
        ],
      ),
    );
  }
}

class _EvidencesTab extends StatelessWidget {
  const _EvidencesTab({required this.evidences});

  final List<EvidenceDto> evidences;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    // Only criteria that actually contributed points are meaningful here.
    final scored = evidences
        .where((e) => e.score != null && e.score != 0)
        .toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _SectionTitle(l10n.evidenceSection),
        const SizedBox(height: Spacing.control + 4),
        if (scored.isEmpty)
          AppText(l10n.diagnosisNoData, type: AppTextType.caption)
        else
          AppCard.divided([
            for (final evidence in scored)
              _RefRow(
                title: evidence.source,
                trailing: _evidenceTrailing(evidence, l10n),
              ),
          ]),
      ],
    );
  }

  String? _evidenceTrailing(EvidenceDto evidence, AppLocalizations l10n) {
    if (evidence.score != null) {
      return l10n.evidencePoints(evidence.score!.toInt());
    }
    if (evidence.isMajor == true) return l10n.evidenceMajor;
    if (evidence.isMajor == false) return l10n.evidenceMinor;
    return null;
  }
}
