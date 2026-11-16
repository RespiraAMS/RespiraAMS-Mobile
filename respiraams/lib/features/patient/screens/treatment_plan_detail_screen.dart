import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../design_system/design_system.dart';
import '../../../../l10n/l10n.dart';
import '../../diagnosis/models/clinical_dtos.dart';
import '../../diagnosis/models/diagnosis_labels.dart';
import '../models/patient_dtos.dart';
import '../models/patient_labels.dart';
import '../providers/patient_detail_provider.dart';
import '../providers/treatment_plan_provider.dart';
import '../widgets/close_treatment_plan_sheet.dart';

/// Route `/patient/treatment-plan?id=…` — read-only plan detail with the
/// single write action `PUT /treatment-plans/{id}/close`.
///
/// Reviewing adherence (`/review`) is intentionally not exposed on mobile.
class TreatmentPlanDetailScreen extends ConsumerWidget {
  const TreatmentPlanDetailScreen({super.key, required this.planId});

  final String? planId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = planId;
    if (id == null || id.isEmpty) {
      return _Shell(
        child: AppText(
          context.l10n.treatmentPlanLoadFailed,
          type: AppTextType.caption,
        ),
      );
    }

    final l10n = context.l10n;
    return ref.watch(treatmentPlanProvider(id)).when(
          loading: () => const _Shell(child: CircularProgressIndicator()),
          error: (_, _) => _Shell(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppText(l10n.treatmentPlanLoadFailed, type: AppTextType.caption),
                const SizedBox(height: Spacing.control),
                AppButton(
                  label: l10n.commonRetry,
                  type: AppButtonType.outline,
                  size: AppButtonSize.medium,
                  onPressed: () => ref.invalidate(treatmentPlanProvider(id)),
                ),
              ],
            ),
          ),
          data: (plan) => _PlanView(plan: plan),
        );
  }
}

class _Shell extends StatelessWidget {
  const _Shell({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      backgroundColor: context.respiraColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Spacing.group),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppAppBar(
                title: l10n.treatmentPlanDetailTitle,
                subtitle: l10n.treatmentPlanDetailSubtitle,
                onBack: () => Navigator.pop(context),
              ),
              Expanded(child: Center(child: child)),
            ],
          ),
        ),
      ),
    );
  }
}

/// Parses the diagnosis snapshot stored with the plan.
///
/// The backend forwards the `POST /diagnose` payload verbatim, so it has the
/// same shape as [DiagnoseResultDto]. Unknown/invalid JSON degrades to `null`
/// instead of failing the whole screen.
DiagnoseResultDto? _parseDiagnosis(String raw) {
  if (raw.trim().isEmpty) return null;
  try {
    final decoded = jsonDecode(raw);
    if (decoded is Map<String, dynamic>) return DiagnoseResultDto.fromJson(decoded);
    if (decoded is Map) {
      return DiagnoseResultDto.fromJson(Map<String, dynamic>.from(decoded));
    }
  } catch (_) {
    // Snapshot from an older/unknown shape — render the rest of the plan.
  }
  return null;
}

class _PlanView extends ConsumerWidget {
  const _PlanView({required this.plan});

  final TreatmentPlanDetailDto plan;

  Future<void> _close(BuildContext context, WidgetRef ref) async {
    final l10n = context.l10n;
    final closed = await showCloseTreatmentPlanSheet(
      context,
      planId: plan.id,
      patientName: plan.patient.name,
    );
    if (closed != true || !context.mounted) return;

    showAppToast(context, l10n.treatmentPlanCloseSuccess);
    ref.invalidate(treatmentPlanProvider(plan.id));
    ref.invalidate(patientDetailProvider(plan.patient.id));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = context.respiraColors;
    final l10n = context.l10n;
    final diagnosis = _parseDiagnosis(plan.diagnosis);
    final isClosed = plan.status == 1;

    return Scaffold(
      backgroundColor: c.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Spacing.group),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppAppBar(
                title: l10n.treatmentPlanDetailTitle,
                subtitle: l10n.treatmentPlanDetailSubtitle,
                onBack: () => Navigator.pop(context),
              ),
              const SizedBox(height: Spacing.control),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: Spacing.section),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AppSurface(
                        padding: const EdgeInsets.all(Spacing.group),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: AppText(
                                    plan.patient.name,
                                    type: AppTextType.bodyLarge,
                                    fontWeight: FontWeight.w700,
                                    maxLines: 2,
                                  ),
                                ),
                                const SizedBox(width: Spacing.inline),
                                _StatusChip(closed: isClosed),
                              ],
                            ),
                            const SizedBox(height: Spacing.xxs),
                            AppText(
                              '${l10n.treatmentPlanAdherenceLabel}: '
                              '${adherenceStateLabel(plan.adherenceState, l10n)}',
                              type: AppTextType.caption,
                              maxLines: 2,
                            ),
                            if (diagnosis != null) ...[
                              const SizedBox(height: Spacing.xxs),
                              AppText(
                                '${l10n.treatmentPlanSeverity}: '
                                '${severityLabel(diagnosis.severity, l10n)}'
                                ' · ${l10n.treatmentPlanSite}: '
                                '${treatmentSiteLabel(diagnosis.treatmentSite, l10n)}',
                                type: AppTextType.caption,
                                maxLines: 2,
                              ),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(height: Spacing.section),
                      _SectionLabel(l10n.treatmentPlanMedicines),
                      const SizedBox(height: Spacing.xxs),
                      if (plan.medicines.isEmpty)
                        AppText(
                          l10n.treatmentPlanNoMedicines,
                          type: AppTextType.caption,
                        )
                      else
                        Wrap(
                          spacing: Spacing.xxs,
                          runSpacing: Spacing.xxs,
                          children: [
                            for (final medicine in plan.medicines)
                              _MedicineChip(medicine: medicine),
                          ],
                        ),
                      if (diagnosis != null &&
                          (diagnosis.worthSuspected.isNotEmpty ||
                              diagnosis.heavySuspected.isNotEmpty)) ...[
                        const SizedBox(height: Spacing.section),
                        _SectionLabel(l10n.treatmentPlanSuspected),
                        const SizedBox(height: Spacing.xxs),
                        Wrap(
                          spacing: Spacing.xxs,
                          runSpacing: Spacing.xxs,
                          children: [
                            for (final pathogen in [
                              ...diagnosis.worthSuspected,
                              ...diagnosis.heavySuspected,
                            ])
                              _PlainChip(label: pathogen.name),
                          ],
                        ),
                      ],
                      if ((plan.reasonForMedicineChoice ?? '').trim().isNotEmpty) ...[
                        const SizedBox(height: Spacing.section),
                        _SectionLabel(l10n.treatmentPlanReasonForChoice),
                        const SizedBox(height: Spacing.xxs),
                        AppText(
                          plan.reasonForMedicineChoice!.trim(),
                          type: AppTextType.body,
                        ),
                      ],
                      if (isClosed &&
                          (plan.closeReason ?? '').trim().isNotEmpty) ...[
                        const SizedBox(height: Spacing.section),
                        _SectionLabel(l10n.treatmentPlanCloseReasonLabel),
                        const SizedBox(height: Spacing.xxs),
                        AppSurface(
                          padding: const EdgeInsets.all(Spacing.control),
                          color: c.surfaceSecondary,
                          child: AppText(
                            plan.closeReason!.trim(),
                            type: AppTextType.body,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              if (!isClosed)
                Padding(
                  padding: const EdgeInsets.only(
                    top: Spacing.control,
                    bottom: Spacing.lg,
                  ),
                  child: AppButton(
                    label: l10n.treatmentPlanClose,
                    type: AppButtonType.destructive,
                    leadingIcon: LucideIcons.xCircle,
                    expand: true,
                    onPressed: () => _close(context, ref),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return AppText(
      text,
      type: AppTextType.label,
      color: context.respiraColors.textPrimary,
      maxLines: 1,
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.closed});

  final bool closed;

  @override
  Widget build(BuildContext context) {
    final c = context.respiraColors;
    final l10n = context.l10n;
    final (Color background, Color foreground) = closed
        ? (c.surfaceSecondary, c.textSecondary)
        : (c.warningSoft, c.warning);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: background,
        borderRadius: AppRadius.full,
      ),
      child: AppText(
        treatmentPlanStatusLabel(closed ? 1 : 0, l10n),
        type: AppTextType.label,
        color: foreground,
        maxLines: 1,
      ),
    );
  }
}

class _MedicineChip extends StatelessWidget {
  const _MedicineChip({required this.medicine});

  final TreatmentMedicineDto medicine;

  @override
  Widget build(BuildContext context) {
    final c = context.respiraColors;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: c.surfaceSecondary,
        borderRadius: AppRadius.full,
        border: Border.all(color: c.borderSubtle),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: AppText(
              medicine.name,
              type: AppTextType.caption,
              color: c.textPrimary,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (medicine.classification.isNotEmpty) ...[
            const SizedBox(width: Spacing.xxxs),
            AppText(
              medicine.classification,
              type: AppTextType.label,
              color: c.iconPrimary,
              maxLines: 1,
            ),
          ],
        ],
      ),
    );
  }
}

class _PlainChip extends StatelessWidget {
  const _PlainChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final c = context.respiraColors;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: c.surfaceSecondary,
        borderRadius: AppRadius.full,
      ),
      child: AppText(
        label,
        type: AppTextType.label,
        color: c.textPrimary,
        maxLines: 1,
      ),
    );
  }
}
