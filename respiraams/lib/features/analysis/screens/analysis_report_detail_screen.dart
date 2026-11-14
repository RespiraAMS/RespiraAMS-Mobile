import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../design_system/design_system.dart';
import '../../../../l10n/l10n.dart';
import '../models/analysis_report.dart';
import '../providers/analysis_providers.dart';
import 'analysis_report_list_screen.dart';

/// Route `/analysis/detail?id=…` — snapshot breakdown of one analysis report.
class AnalysisReportDetailScreen extends ConsumerWidget {
  const AnalysisReportDetailScreen({super.key, required this.analysisId});

  final String? analysisId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = analysisId;
    if (id == null || id.isEmpty) {
      return _Shell(
        child: AppText(context.l10n.analysisLoadFailed, type: AppTextType.caption),
      );
    }

    final l10n = context.l10n;
    return ref.watch(analysisReportProvider(id)).when(
          loading: () => const _Shell(child: CircularProgressIndicator()),
          error: (_, _) => _Shell(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppText(l10n.analysisLoadFailed, type: AppTextType.caption),
                const SizedBox(height: Spacing.control),
                AppButton(
                  label: l10n.commonRetry,
                  type: AppButtonType.outline,
                  size: AppButtonSize.medium,
                  onPressed: () => ref.invalidate(analysisReportProvider(id)),
                ),
              ],
            ),
          ),
          data: (report) => _ReportView(report: report),
        );
  }
}

class _Shell extends StatelessWidget {
  const _Shell({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final c = context.respiraColors;
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: c.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Spacing.group),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppAppBar(
                title: l10n.analysisDetailTitle,
                subtitle: l10n.analysisDetailSubtitle,
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

class _ReportView extends ConsumerWidget {
  const _ReportView({required this.report});

  final AnalysisReport report;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = context.respiraColors;
    final l10n = context.l10n;
    final doctorNames = ref.watch(doctorNamesProvider).valueOrNull;
    final hasData = report.totalTreatmentPlans > 0 || report.totalPatients > 0;

    return Scaffold(
      backgroundColor: c.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Spacing.group),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppAppBar(
                title: l10n.analysisDetailTitle,
                subtitle: l10n.analysisDetailSubtitle,
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
                            AppText(
                              analysisDoctorLabel(
                                report.doctorId,
                                doctorNames,
                                l10n,
                              ),
                              type: AppTextType.bodyLarge,
                              fontWeight: FontWeight.w700,
                              maxLines: 2,
                            ),
                            const SizedBox(height: Spacing.xxs),
                            Row(
                              children: [
                                AppIcon(
                                  LucideIcons.calendarRange,
                                  size: ControlSize.iconSm,
                                  color: c.iconMuted,
                                ),
                                const SizedBox(width: Spacing.xxxs + 2),
                                Expanded(
                                  child: AppText(
                                    '${l10n.analysisPeriod}: '
                                    '${analysisDate(report.start)} → '
                                    '${analysisDate(report.end)}',
                                    type: AppTextType.caption,
                                    maxLines: 2,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: Spacing.group),
                      if (!hasData)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: Spacing.section,
                          ),
                          child: Center(
                            child: AppText(
                              l10n.analysisNoData,
                              color: c.textSecondary,
                            ),
                          ),
                        )
                      else ...[
                        Row(
                          children: [
                            Expanded(
                              child: _MetricTile(
                                label: l10n.analysisTotalPatients,
                                value: '${report.totalPatients}',
                              ),
                            ),
                            const SizedBox(width: Spacing.control),
                            Expanded(
                              child: _MetricTile(
                                label: l10n.analysisTotalPlans,
                                value: '${report.totalTreatmentPlans}',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: Spacing.control),
                        Row(
                          children: [
                            Expanded(
                              child: _MetricTile(
                                label: l10n.analysisAdherenceRate,
                                value: _percent(report.adherentRate),
                                valueColor: c.success,
                              ),
                            ),
                            const SizedBox(width: Spacing.control),
                            Expanded(
                              child: _MetricTile(
                                label: l10n.analysisPendingRate,
                                value: _percent(report.pendingRate),
                                valueColor: c.warning,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: Spacing.section),
                        _SectionLabel(l10n.analysisAdherenceRate),
                        const SizedBox(height: Spacing.xxs),
                        _AdherenceBreakdown(report: report),
                        const SizedBox(height: Spacing.section),
                        _SectionLabel(l10n.analysisOutcomes),
                        const SizedBox(height: Spacing.xxs),
                        Wrap(
                          spacing: Spacing.xxs,
                          runSpacing: Spacing.xxs,
                          children: [
                            _OutcomeChip(
                              label: l10n.analysisRecovered,
                              count: report.totalRecoveredPatients,
                              background: c.successSoft,
                              foreground: c.success,
                            ),
                            _OutcomeChip(
                              label: l10n.analysisDeceased,
                              count: report.totalDeceasedPatients,
                              background: c.errorSoft,
                              foreground: c.error,
                            ),
                            _OutcomeChip(
                              label: l10n.analysisOtherOutcome,
                              count: report.totalOtherOutcomePatients,
                              background: c.surfaceSecondary,
                              foreground: c.textSecondary,
                            ),
                          ],
                        ),
                        const SizedBox(height: Spacing.section),
                        _SectionLabel(l10n.analysisByDoctor),
                        const SizedBox(height: Spacing.xxs),
                        if (report.doctors.isEmpty)
                          AppText(
                            l10n.analysisNoDoctors,
                            type: AppTextType.caption,
                          )
                        else
                          Column(
                            children: [
                              for (var i = 0; i < report.doctors.length; i++) ...[
                                if (i > 0)
                                  const SizedBox(height: Spacing.control),
                                _DoctorCard(
                                  doctor: report.doctors[i],
                                  doctorNames: doctorNames,
                                ),
                              ],
                            ],
                          ),
                      ],
                    ],
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

String _percent(double rate) => '${(rate * 100).toStringAsFixed(0)}%';

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

class _MetricTile extends StatelessWidget {
  const _MetricTile({
    required this.label,
    required this.value,
    this.valueColor,
  });

  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return AppSurface(
      padding: const EdgeInsets.all(Spacing.control),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            label,
            type: AppTextType.caption,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: Spacing.xxs),
          AppText(
            value,
            type: AppTextType.h2,
            color: valueColor,
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}

/// Three-segment bar: adherent · non-adherent · pending.
class _AdherenceBreakdown extends StatelessWidget {
  const _AdherenceBreakdown({required this.report});

  final AnalysisReport report;

  @override
  Widget build(BuildContext context) {
    final c = context.respiraColors;
    final l10n = context.l10n;
    final total = report.totalTreatmentPlans;
    final adherent = report.totalAdherentPlans;
    final nonAdherent = report.totalNonAdherentPlans;
    final pending = report.totalPendingReviewPlans;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: AppRadius.full,
          child: SizedBox(
            height: 10,
            child: total == 0
                ? ColoredBox(color: c.surfaceSecondary)
                : Row(
                    children: [
                      if (adherent > 0)
                        Expanded(
                          flex: adherent,
                          child: ColoredBox(color: c.success),
                        ),
                      if (nonAdherent > 0)
                        Expanded(
                          flex: nonAdherent,
                          child: ColoredBox(color: c.error),
                        ),
                      if (pending > 0)
                        Expanded(
                          flex: pending,
                          child: ColoredBox(color: c.warning),
                        ),
                    ],
                  ),
          ),
        ),
        const SizedBox(height: Spacing.xxs),
        Wrap(
          spacing: Spacing.xxs,
          runSpacing: Spacing.xxxs,
          children: [
            _OutcomeChip(
              label: l10n.analysisAdherent,
              count: adherent,
              background: c.successSoft,
              foreground: c.success,
            ),
            _OutcomeChip(
              label: l10n.analysisNonAdherent,
              count: nonAdherent,
              background: c.errorSoft,
              foreground: c.error,
            ),
            _OutcomeChip(
              label: l10n.analysisPendingReview,
              count: pending,
              background: c.warningSoft,
              foreground: c.warning,
            ),
          ],
        ),
      ],
    );
  }
}

class _DoctorCard extends StatefulWidget {
  const _DoctorCard({required this.doctor, required this.doctorNames});

  final AnalysisDoctorSummary doctor;
  final Map<String, String>? doctorNames;

  @override
  State<_DoctorCard> createState() => _DoctorCardState();
}

class _DoctorCardState extends State<_DoctorCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final c = context.respiraColors;
    final l10n = context.l10n;
    final doctor = widget.doctor;

    return AppSurface(
      padding: const EdgeInsets.symmetric(
        horizontal: Spacing.group,
        vertical: Spacing.control,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => setState(() => _expanded = !_expanded),
            borderRadius: AppRadius.sm,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: AppText(
                        analysisDoctorLabel(
                          doctor.doctorId,
                          widget.doctorNames,
                          l10n,
                        ),
                        type: AppTextType.bodyMedium,
                        fontWeight: FontWeight.w600,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: Spacing.inline),
                    AnimatedRotation(
                      turns: _expanded ? 0.5 : 0,
                      duration: const Duration(milliseconds: 200),
                      child: AppIcon(
                        LucideIcons.chevronDown,
                        size: ControlSize.iconLg,
                        color: c.iconMuted,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: Spacing.xxs),
                AppText(
                  '${l10n.analysisPatientsCount(doctor.totalPatients)} · '
                  '${l10n.analysisPlansCount(doctor.totalTreatmentPlans)}',
                  type: AppTextType.caption,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: Spacing.xxs),
                Wrap(
                  spacing: Spacing.xxs,
                  runSpacing: Spacing.xxxs,
                  children: [
                    _OutcomeChip(
                      label: l10n.analysisAdherent,
                      count: doctor.totalAdherentPlans,
                      background: c.successSoft,
                      foreground: c.success,
                    ),
                    _OutcomeChip(
                      label: l10n.analysisNonAdherent,
                      count: doctor.totalNonAdherentPlans,
                      background: c.errorSoft,
                      foreground: c.error,
                    ),
                    _OutcomeChip(
                      label: l10n.analysisPendingReview,
                      count: doctor.totalPendingReviewPlans,
                      background: c.warningSoft,
                      foreground: c.warning,
                    ),
                  ],
                ),
              ],
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 200),
            alignment: Alignment.topCenter,
            child: _expanded
                ? Padding(
                    padding: const EdgeInsets.only(top: Spacing.control),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _SectionLabel(l10n.analysisByMedicine),
                        const SizedBox(height: Spacing.xxs),
                        if (doctor.medicines.isEmpty)
                          AppText(
                            l10n.analysisNoMedicines,
                            type: AppTextType.caption,
                          )
                        else
                          Column(
                            children: [
                              for (
                                var i = 0;
                                i < doctor.medicines.length;
                                i++
                              ) ...[
                                if (i > 0)
                                  const SizedBox(height: Spacing.xxs),
                                _MedicineRow(
                                  medicine: doctor.medicines[i],
                                ),
                              ],
                            ],
                          ),
                      ],
                    ),
                  )
                : const SizedBox(width: double.infinity),
          ),
        ],
      ),
    );
  }
}

class _MedicineRow extends StatelessWidget {
  const _MedicineRow({required this.medicine});

  final AnalysisMedicineSummary medicine;

  @override
  Widget build(BuildContext context) {
    final c = context.respiraColors;
    final l10n = context.l10n;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: Spacing.control,
        vertical: Spacing.xxs,
      ),
      decoration: BoxDecoration(
        color: c.surfaceSecondary,
        borderRadius: AppRadius.sm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: AppText(
                  medicine.name,
                  type: AppTextType.caption,
                  color: c.textPrimary,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: Spacing.inline),
              AppText(
                _percent(medicine.adherentRate),
                type: AppTextType.label,
                color: c.success,
                maxLines: 1,
              ),
            ],
          ),
          const SizedBox(height: Spacing.xxxs),
          AppText(
            '${l10n.analysisPlansCount(medicine.totalTreatmentPlans)} · '
            '${l10n.analysisAdherent} ${medicine.totalAdherentPlans} · '
            '${l10n.analysisPendingReview} '
            '${medicine.totalPendingReviewPlans}'
            '${medicine.classification.isEmpty ? '' : ' · ${medicine.classification}'}',
            type: AppTextType.caption,
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}

class _OutcomeChip extends StatelessWidget {
  const _OutcomeChip({
    required this.label,
    required this.count,
    required this.background,
    required this.foreground,
  });

  final String label;
  final int count;
  final Color background;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: background,
        borderRadius: AppRadius.full,
      ),
      child: AppText(
        '$label: $count',
        type: AppTextType.label,
        color: foreground,
        maxLines: 1,
      ),
    );
  }
}
