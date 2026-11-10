import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/context_extensions.dart';
import '../../../../design_system/design_system.dart';
import '../../../../l10n/l10n.dart';
import '../models/patient.dart';
import '../models/patient_dtos.dart';
import '../providers/active_patient_provider.dart';
import '../providers/current_patient_provider.dart';
import '../providers/patient_detail_provider.dart';
import '../widgets/info_row_widget.dart';
import '../widgets/section_label_widget.dart';
import '../widgets/timeline_widget.dart';
import '../routes.dart';

/// Route `/patient/detail` — read-only profile and treatment timeline.
///
/// Loads the record from `GET /patients/{id}` (passed as query parameter)
/// and mirrors it into the active patient so progress/diagnosis screens
/// reflect the selection. Falls back to the active patient when no id is
/// supplied.
class PatientDetailScreen extends ConsumerWidget {
  const PatientDetailScreen({super.key, this.patientId});

  final String? patientId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = patientId;
    final l10n = context.l10n;

    if (id != null && id.isNotEmpty) {
      ref.listen(patientDetailProvider(id), (_, next) {
        next.whenData(
          (dto) => ref
              .read(activePatientControllerProvider.notifier)
              .set(Patient.fromDetail(dto)),
        );
      });

      return ref.watch(patientDetailProvider(id)).when(
            loading: () => const _StateScaffold(
              child: CircularProgressIndicator(),
            ),
            error: (_, _) => _StateScaffold(
              child: AppText(
                l10n.patientProfileError,
                type: AppTextType.caption,
              ),
            ),
            data: (dto) => _ProfileView(
              patient: Patient.fromDetail(dto),
              statusLabel: _statusLabel(dto.treatmentOutcome, l10n),
              treatments: dto.treatmentPlans,
            ),
          );
    }

    final patient = ref.watch(currentPatientProvider);
    if (patient == null) {
      return _StateScaffold(
        child: AppText(l10n.patientNoSelection, type: AppTextType.caption),
      );
    }
    return _ProfileView(patient: patient);
  }
}

String _statusLabel(PatientStatusDto outcome, AppLocalizations l10n) =>
    switch (outcome) {
      PatientStatusDto.inTreatment => l10n.patientStatusTreating,
      PatientStatusDto.recovered => l10n.patientStatusRecovered,
      PatientStatusDto.death => l10n.patientStatusDeceased,
      PatientStatusDto.outOfScope => l10n.patientStatusOutOfScope,
    };

String _adherenceLabel(String state, AppLocalizations l10n) => switch (state) {
      'Adhere' => l10n.adherenceAdhere,
      'NotAdhere' => l10n.adherenceNotAdhere,
      'NotAdhereValid' => l10n.adherenceNotAdhereValid,
      'NotAdhereInvalid' => l10n.adherenceNotAdhereInvalid,
      _ => state,
    };

String _dateLabel(String value) {
  if (value.isEmpty) return '';
  final parsed = DateTime.tryParse(value);
  if (parsed == null) return value.length >= 10 ? value.substring(0, 10) : value;
  final local = parsed.toLocal();
  final dd = local.day.toString().padLeft(2, '0');
  final mm = local.month.toString().padLeft(2, '0');
  return '$dd/$mm/${local.year}';
}

/// Shared shell for the loading / error / empty states.
class _StateScaffold extends StatelessWidget {
  const _StateScaffold({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Spacing.group),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppAppBar(
                title: l10n.patientDetailTitle,
                subtitle: l10n.patientDetailSubtitle,
                onBack: () => context.goBackOr(PatientRoutes.list),
              ),
              Expanded(child: Center(child: child)),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileView extends StatelessWidget {
  const _ProfileView({
    required this.patient,
    this.statusLabel,
    this.treatments = const [],
  });

  final Patient patient;
  final String? statusLabel;
  final List<TreatmentPlanItemDto> treatments;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final avatarGlyph = patient.gender == Gender.nam ? '👨🏻' : '👩🏾';
    final vitals = (patient.heightCm != null && patient.weightKg != null)
        ? '${patient.weightKg!.toStringAsFixed(0)} kg · '
            '${patient.heightCm!.toStringAsFixed(0)} cm'
        : '—';
    final entries = [
      for (final plan in treatments)
        TreatmentTimelineEntry(
          dateLabel: _dateLabel(plan.updatedAt),
          title: plan.treatmentPlanStatus == 1
              ? l10n.treatmentPlanClosed
              : l10n.treatmentPlanInProgress,
          status: _adherenceLabel(plan.adherenceState, l10n),
        ),
    ];

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
                        title: l10n.patientDetailTitle,
                        subtitle: l10n.patientDetailSubtitle,
                        onBack: () =>
                            context.goBackOr(PatientRoutes.list),
                      ),
                      const SizedBox(height: Spacing.block),
                      PatientHeader(
                        name: patient.name,
                        metadata:
                            '${patient.code} · ${patient.gender.label(l10n)}',
                        avatarGlyph: avatarGlyph,
                      ),
                      const SizedBox(height: Spacing.section),
                      SectionLabelWidget(l10n.patientRecordSection),
                      const SizedBox(height: Spacing.xxs),
                      AppCard.divided(
                        [
                          InfoRowWidget(
                            label: l10n.patientDobGender,
                            value:
                                '${patient.dob} · ${patient.gender.label(l10n)}',
                          ),
                          InfoRowWidget(
                            label: l10n.patientInsurance,
                            value: patient.insurance,
                          ),
                          InfoRowWidget(
                            label: l10n.patientAddress,
                            value: patient.address,
                          ),
                          InfoRowWidget(
                            label: l10n.patientVitals,
                            value: vitals,
                          ),
                          if (statusLabel != null)
                            InfoRowWidget(
                              label: l10n.patientTreatmentStatus,
                              value: statusLabel!,
                            ),
                        ],
                        padding: const EdgeInsets.symmetric(
                          horizontal: Spacing.group,
                        ),
                      ),
                      const SizedBox(height: Spacing.section),
                      SectionLabelWidget(l10n.patientProgressSection),
                      const SizedBox(height: Spacing.inline),
                      Padding(
                        padding: const EdgeInsets.only(left: Spacing.xxs),
                        child: entries.isEmpty
                            ? AppText(
                                l10n.patientNoProgress,
                                type: AppTextType.caption,
                              )
                            : TimelineWidget(entries: entries),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: Spacing.block,
                          bottom: Spacing.lg,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: AppButton(
                                label: l10n.patientAddTreatment,
                                onPressed: () =>
                                    context.push(PatientRoutes.progress),
                              ),
                            ),
                            const SizedBox(width: Spacing.control),
                            Expanded(
                              child: AppButton(
                                label: l10n.patientUpdateStatus,
                                type: AppButtonType.outline,
                                onPressed: () =>
                                    context.push(PatientRoutes.progress),
                              ),
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
