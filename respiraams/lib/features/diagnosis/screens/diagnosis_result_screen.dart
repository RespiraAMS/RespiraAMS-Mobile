import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/context_extensions.dart';
import '../../../../design_system/design_system.dart';
import '../../../../l10n/l10n.dart';
import '../../patient/providers/current_patient_provider.dart';
import '../../patient/providers/patient_detail_provider.dart';
import '../../patient/routes.dart';
import '../models/clinical_dtos.dart';
import '../models/diagnosis_labels.dart';
import '../models/diagnosis_result.dart';
import '../providers/diagnosis_controller.dart';
import '../providers/diagnosis_flow_provider.dart';
import '../providers/diagnosis_tab_controller.dart';
import '../widgets/aware_chip.dart';
import '../widgets/stat_tile_widget.dart';

import '../routes.dart';

/// Route `/diagnosis-result` — wizard output (result · suspected · evidences ·
/// protocols), rendered from the real `POST /diagnose` response.
class DiagnosisResultScreen extends ConsumerWidget {
  const DiagnosisResultScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final flow = ref.watch(diagnosisFlowControllerProvider);
    final result = flow.result;
    final tab = ref.watch(diagnosisTabControllerProvider);
    final tabController = ref.read(diagnosisTabControllerProvider.notifier);
    final l10n = context.l10n;

    if (result == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final hasProtocols = result.protocols.isNotEmpty;

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
                        DiagnosisTab.protocols =>
                          _ProtocolsTab(protocols: result.protocols),
                      },
                      const Spacer(),
                      if (!hasProtocols) ...[
                        AppText(
                          l10n.diagnosisNoProtocolToSave,
                          type: AppTextType.caption,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: Spacing.inline),
                      ],
                      Padding(
                        padding: const EdgeInsets.only(
                          top: Spacing.block,
                          bottom: Spacing.lg,
                        ),
                        child: AppButton(
                          label: l10n.diagnosisSaveResult,
                          expand: true,
                          loading: flow.confirming,
                          onPressed: hasProtocols
                              ? () =>
                                  _openConfirmTreatment(context, ref, result)
                              : null,
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

  Future<void> _openConfirmTreatment(
    BuildContext context,
    WidgetRef ref,
    DiagnoseResultDto result,
  ) async {
    final saved = await context.push<bool>(
      DiagnosisRoutes.confirmTreatment,
      extra: result,
    );
    if (saved != true || !context.mounted) return;

    final patient = ref.read(currentPatientProvider);
    if (patient != null) {
      ref.invalidate(patientDetailProvider(patient.id));
    }
    ref.read(diagnosisControllerProvider.notifier).reset();
    ref.read(diagnosisFlowControllerProvider.notifier).clearResult();
    showAppToast(context, context.l10n.diagnosisConfirmSuccess);
    if (patient != null) {
      context.go('${PatientRoutes.detail}?id=${patient.id}');
    } else {
      context.go(PatientRoutes.list);
    }
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
    severityLabel(severity, l10n);

String _siteLabel(String site, AppLocalizations l10n) =>
    treatmentSiteLabel(site, l10n);

String _allergyTypeLabel(String type, AppLocalizations l10n) =>
    switch (type) {
      'No' => l10n.diagnosisAllergyNo,
      'Yes' => l10n.diagnosisAllergyYes,
      'NonRegisteredAntibiotic' => l10n.diagnosisAllergyNonRegistered,
      _ => l10n.diagnosisAllergyUnknown,
    };

String _formatValue(Object? value, AppLocalizations l10n) {
  if (value is bool) return value ? l10n.commonYes : l10n.commonNo;
  return value?.toString() ?? '';
}

class _ResultTab extends StatelessWidget {
  const _ResultTab({required this.result});

  final DiagnoseResultDto result;

  @override
  Widget build(BuildContext context) {
    final c = context.respiraColors;
    final l10n = context.l10n;
    final allergy = result.allergy;

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
              if (result.diagnosisId.isNotEmpty) ...[
                const SizedBox(height: Spacing.xxxs),
                AppText(
                  '${l10n.diagnosisDiagnosisId}: ${result.diagnosisId}',
                  type: AppTextType.caption,
                ),
              ],
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
            if (result.egfr != null) ...[
              const SizedBox(width: Spacing.group),
              Expanded(
                child: StatTileWidget(
                  label: l10n.diagnosisEgfr,
                  value: result.egfr!.toStringAsFixed(1),
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: Spacing.block - 4),
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
                .map((v) => v.displayLabel)
                .take(6)
                .join(', '),
          ),
        ],
        if (result.otherInfections.isNotEmpty) ...[
          const SizedBox(height: Spacing.section),
          _SectionTitle(l10n.diagnosisOtherInfectionsTitle),
          const SizedBox(height: Spacing.control),
          Wrap(
            spacing: Spacing.inline,
            runSpacing: Spacing.inline,
            children: [
              for (final infection in result.otherInfections)
                _InfoChip(label: infectionTypeLabel(infection, l10n)),
            ],
          ),
        ],
        if (allergy != null) ...[
          const SizedBox(height: Spacing.section),
          _SectionTitle(l10n.diagnosisAllergyTitle),
          const SizedBox(height: Spacing.control),
          AppCard(
            padding: const EdgeInsets.symmetric(
              horizontal: Spacing.control,
              vertical: Spacing.control,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _KeyValueRow(
                  label: l10n.diagnosisAllergyType,
                  value: _allergyTypeLabel(allergy.type, l10n),
                ),
                if (allergy.allergicAntibiotics.isNotEmpty)
                  _KeyValueRow(
                    label: l10n.diagnosisAllergySelect,
                    value: allergy.allergicAntibiotics
                        .map((a) => a.name)
                        .join(', '),
                  ),
                if (allergy.otherAllergy != null &&
                    allergy.otherAllergy!.isNotEmpty)
                  _KeyValueRow(
                    label: l10n.diagnosisAllergyOther,
                    value: allergy.otherAllergy!,
                  ),
              ],
            ),
          ),
        ],
        if (result.metricsSeverityDiagnosis.isNotEmpty) ...[
          const SizedBox(height: Spacing.section),
          _SectionTitle(l10n.diagnosisSectionMetrics),
          const SizedBox(height: Spacing.control),
          AppCard.divided([
            for (final metric in result.metricsSeverityDiagnosis)
              _RefRow(
                title: metric.code.isEmpty
                    ? l10n.diagnosisSectionMetrics
                    : metric.code,
                trailing: _metricTrailing(metric, l10n),
              ),
          ]),
        ],
        const SizedBox(height: Spacing.control + 4),
        AppText(
          l10n.diagnosisConfirmNote,
          type: AppTextType.caption,
        ),
      ],
    );
  }

  String? _metricTrailing(MetricsSeverityDto metric, AppLocalizations l10n) {
    if (metric.score != null) return l10n.evidencePoints(metric.score!);
    if (metric.majorMatched != null || metric.minorMatched != null) {
      return l10n.diagnosisMetricsMajorMinor(
        metric.majorMatched ?? 0,
        metric.minorMatched ?? 0,
      );
    }
    if (metric.severity.isNotEmpty) {
      return _severityLabel(metric.severity, l10n);
    }
    return null;
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
        if (result.microbialTestResults.isNotEmpty) ...[
          const SizedBox(height: Spacing.section),
          _SectionTitle(l10n.diagnosisMicrobialResultTitle),
          const SizedBox(height: Spacing.control + 4),
          for (final test in result.microbialTestResults) ...[
            _MicrobialResultCard(test: test),
            const SizedBox(height: Spacing.group),
          ],
        ],
      ],
    );
  }
}

class _MicrobialResultCard extends StatelessWidget {
  const _MicrobialResultCard({required this.test});

  final MicrobialTestResultDto test;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final pathogen = test.pathogen?.name ?? l10n.diagnosisNoData;
    return AppCard(
      padding: const EdgeInsets.all(Spacing.control),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _KeyValueRow(
            label: l10n.diagnosisMicrobialSampleType,
            value: microbialSampleTypeLabel(test.sampleType, l10n),
          ),
          _KeyValueRow(
            label: l10n.diagnosisMicrobialPathogen,
            value: pathogen,
            valueBold: true,
          ),
          _KeyValueRow(
            label: l10n.diagnosisMicrobialMicCategory,
            value: micCategoryLabel(test.category, l10n),
          ),
          if (test.antibiotics.isNotEmpty)
            _KeyValueRow(
              label: l10n.diagnosisMicrobialAntibiotics,
              value: test.antibiotics.map((a) => a.name).join(', '),
            ),
        ],
      ),
    );
  }
}

class _EvidencesTab extends ConsumerWidget {
  const _EvidencesTab({required this.evidences});

  final List<EvidenceDto> evidences;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    // Evidence rows reference variables as `VariableRef` (code only); the form
    // catalog provides the human-readable names.
    final variables =
        ref.watch(diagnosisFormProvider).valueOrNull?.variables ?? const [];
    final namesByCode = <String, String>{
      for (final variable in variables)
        if (variable.code.isNotEmpty && variable.name.isNotEmpty)
          variable.code: variable.name,
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _SectionTitle(l10n.evidenceSection),
        const SizedBox(height: Spacing.control + 4),
        if (evidences.isEmpty)
          AppText(l10n.diagnosisNoData, type: AppTextType.caption)
        else
          AppCard.divided([
            for (final evidence in evidences)
              _EvidenceRow(evidence: evidence, namesByCode: namesByCode),
          ]),
      ],
    );
  }
}

class _EvidenceRow extends StatelessWidget {
  const _EvidenceRow({required this.evidence, required this.namesByCode});

  final EvidenceDto evidence;

  /// `code → variable name`, used because evidence refs carry no name.
  final Map<String, String> namesByCode;

  String _label(VariableRefDto ref) =>
      namesByCode[ref.code] ?? ref.displayLabel;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final related = evidence.relatedObservations
        .map((o) => o.variable == null ? '' : _label(o.variable!))
        .where((name) => name.isNotEmpty)
        .join(', ');
    final missing = evidence.missingVariables.map(_label).join(', ');
    final title = evidence.source.isEmpty ? l10n.evidenceSection : evidence.source;
    final trailing = _trailing(evidence, l10n);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Spacing.control,
        vertical: Spacing.group,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TypographyTokens.body(context)
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              if (trailing != null)
                AppText(trailing, type: AppTextType.caption),
            ],
          ),
          if (evidence.evaluatedValue != null) ...[
            const SizedBox(height: Spacing.xxxs),
            AppText(
              l10n.diagnosisEvidenceValue(
                _formatValue(evidence.evaluatedValue, l10n),
              ),
              type: AppTextType.caption,
            ),
          ],
          if (related.isNotEmpty) ...[
            const SizedBox(height: Spacing.xxxs),
            AppText(
              l10n.diagnosisEvidenceRelated(related),
              type: AppTextType.caption,
            ),
          ],
          if (missing.isNotEmpty) ...[
            const SizedBox(height: Spacing.xxxs),
            AppText(
              l10n.diagnosisEvidenceMissing(missing),
              type: AppTextType.caption,
            ),
          ],
        ],
      ),
    );
  }

  String? _trailing(EvidenceDto evidence, AppLocalizations l10n) {
    if (evidence.score != null) {
      return l10n.evidencePoints(evidence.score!.toInt());
    }
    if (evidence.isMajor == true) return l10n.evidenceMajor;
    if (evidence.isMajor == false) return l10n.evidenceMinor;
    return null;
  }
}

class _ProtocolsTab extends StatelessWidget {
  const _ProtocolsTab({required this.protocols});

  final List<TreatmentProtocolDto> protocols;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _SectionTitle(l10n.diagnosisSectionProtocols),
        const SizedBox(height: Spacing.control + 4),
        if (protocols.isEmpty)
          AppText(l10n.diagnosisProtocolNoData, type: AppTextType.caption)
        else
          for (final protocol in protocols) ...[
            _ProtocolCard(protocol: protocol),
            const SizedBox(height: Spacing.group),
          ],
      ],
    );
  }
}

class _ProtocolCard extends StatelessWidget {
  const _ProtocolCard({required this.protocol});

  final TreatmentProtocolDto protocol;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return AppCard(
      padding: const EdgeInsets.all(Spacing.control),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${_severityLabel(protocol.severity, l10n)} · '
            '${_siteLabel(protocol.treatmentSite, l10n)}',
            style: TypographyTokens.body(context)
                .copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: Spacing.control),
          Text(
            l10n.diagnosisProtocolMedicines,
            style: TypographyTokens.caption(context),
          ),
          const SizedBox(height: Spacing.xxxs),
          if (protocol.medicines.isEmpty)
            AppText(l10n.diagnosisProtocolNoMedicine, type: AppTextType.caption)
          else
            for (final combination in protocol.medicines)
              Padding(
                padding: const EdgeInsets.only(bottom: Spacing.xxs),
                child: Wrap(
                  spacing: Spacing.xxxs,
                  runSpacing: Spacing.xxxs,
                  children: [
                    for (final antibiotic in combination)
                      AwareDrugChip(
                        name: antibiotic.name,
                        classification: antibiotic.classification,
                      ),
                  ],
                ),
              ),
          if (protocol.pathogens.isNotEmpty) ...[
            const SizedBox(height: Spacing.control),
            _KeyValueRow(
              label: l10n.diagnosisProtocolPathogens,
              value: protocol.pathogens.map((p) => p.name).join(', '),
            ),
          ],
          if (protocol.criteria.isNotEmpty) ...[
            const SizedBox(height: Spacing.control),
            _KeyValueRow(
              label: l10n.diagnosisProtocolCriteria,
              value: protocol.criteria.map((c) => c.name).join(', '),
            ),
          ],
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final c = context.respiraColors;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Spacing.control,
        vertical: Spacing.xs,
      ),
      decoration: BoxDecoration(
        color: c.surfaceSecondary,
        borderRadius: AppRadius.full,
      ),
      child: AppText(label, type: AppTextType.caption),
    );
  }
}

class _KeyValueRow extends StatelessWidget {
  const _KeyValueRow({
    required this.label,
    required this.value,
    this.valueBold = false,
  });

  final String label;
  final String value;
  final bool valueBold;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Spacing.xxs),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TypographyTokens.caption(context)),
          const SizedBox(height: Spacing.xxxs),
          Text(
            value,
            style: TypographyTokens.body(context).copyWith(
              fontWeight: valueBold ? FontWeight.w700 : null,
            ),
          ),
        ],
      ),
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
                  .copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          if (trailing != null)
            AppText(trailing!, type: AppTextType.caption),
        ],
      ),
    );
  }
}
