import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/utils/context_extensions.dart';
import '../../../../design_system/design_system.dart';
import '../../../../l10n/l10n.dart';
import '../../diagnosis/routes.dart';
import '../models/patient.dart';
import '../models/patient_dtos.dart';
import '../models/patient_labels.dart';
import '../providers/active_patient_provider.dart';
import '../providers/current_patient_provider.dart';
import '../providers/patient_detail_provider.dart';
import '../providers/patient_list_provider.dart';
import '../widgets/discharge_patient_sheet.dart';
import '../widgets/info_row_widget.dart';
import '../widgets/next_of_kin_section.dart';
import '../widgets/patient_actions_menu.dart';
import '../widgets/section_label_widget.dart';
import '../widgets/timeline_widget.dart';
import '../routes.dart';

/// Route `/patient/detail` — profile, treatment timeline and record actions.
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
              patientId: id,
              patient: Patient.fromDetail(dto),
              outcome: dto.treatmentOutcome,
              discharge: dto.discharge,
              admission: dto.admission,
              treatments: dto.treatmentPlans,
              nextOfKins: dto.nextOfKins,
            ),
          );
    }

    final patient = ref.watch(currentPatientProvider);
    if (patient == null) {
      return _StateScaffold(
        child: AppText(l10n.patientNoSelection, type: AppTextType.caption),
      );
    }
    return _ProfileView(
      patientId: patient.id.isEmpty ? null : patient.id,
      patient: patient,
    );
  }
}

String _statusLabel(PatientStatusDto outcome, AppLocalizations l10n) =>
    switch (outcome) {
      PatientStatusDto.inTreatment => l10n.patientStatusTreating,
      PatientStatusDto.recovered => l10n.patientStatusRecovered,
      PatientStatusDto.death => l10n.patientStatusDeceased,
      PatientStatusDto.outOfScope => l10n.patientStatusOutOfScope,
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

class _ProfileView extends ConsumerStatefulWidget {
  const _ProfileView({
    required this.patient,
    this.patientId,
    this.outcome,
    this.discharge,
    this.admission,
    this.treatments = const [],
    this.nextOfKins = const [],
  });

  final Patient patient;

  /// Present when the record came from `GET /patients/{id}`; enables the
  /// overflow menu and the discharge action.
  final String? patientId;
  final PatientStatusDto? outcome;
  final String? discharge;
  final String? admission;
  final List<TreatmentPlanItemDto> treatments;
  final List<NextOfKinItemDto> nextOfKins;

  @override
  ConsumerState<_ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<_ProfileView> {
  /// Local override so the banner/outcome/button update immediately after
  /// a successful discharge, without waiting for the refetch.
  PatientStatusDto? _outcomeOverride;
  String? _dischargedAt;

  bool get _isDischarged =>
      widget.discharge != null || _dischargedAt != null;

  PatientStatusDto? get _effectiveOutcome =>
      _outcomeOverride ?? widget.outcome;

  Future<void> _onDischarge() async {
    final id = widget.patientId;
    if (id == null || id.isEmpty) return;

    final l10n = context.l10n;
    final outcome = await showDischargePatientSheet(
      context,
      patientId: id,
      patientName: widget.patient.name,
      patientCode: widget.patient.code,
      admission: widget.admission ?? '',
    );
    if (outcome == null || !mounted) return;

    setState(() {
      _outcomeOverride = switch (outcome) {
        DischargeOutcome.recovered => PatientStatusDto.recovered,
        DischargeOutcome.death => PatientStatusDto.death,
        DischargeOutcome.outOfScope => PatientStatusDto.outOfScope,
      };
      _dischargedAt = _todayLabel();
    });

    showAppToast(context, l10n.patientDischargeSuccess);
    ref.invalidate(patientDetailProvider(id));
    ref.read(patientListControllerProvider.notifier).refresh();
  }

  static String _todayLabel() {
    final now = DateTime.now();
    final dd = now.day.toString().padLeft(2, '0');
    final mm = now.month.toString().padLeft(2, '0');
    return '$dd/$mm/${now.year}';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final patient = widget.patient;
    final avatarGlyph = patient.gender == Gender.nam ? '👨🏻' : '👩🏾';
    final vitals = (patient.heightCm != null && patient.weightKg != null)
        ? '${patient.weightKg!.toStringAsFixed(0)} kg · '
            '${patient.heightCm!.toStringAsFixed(0)} cm'
        : '—';
    final entries = [
      for (final plan in widget.treatments)
        TreatmentTimelineEntry(
          dateLabel: _dateLabel(plan.updatedAt),
          title: plan.treatmentPlanStatus == 1
              ? l10n.treatmentPlanClosed
              : l10n.treatmentPlanInProgress,
          status: adherenceStateLabel(plan.adherenceState, l10n),
          onTap: () =>
              context.push('${PatientRoutes.treatmentPlan}?id=${plan.id}'),
        ),
    ];
    final outcome = _effectiveOutcome;
    final statusLabel = outcome == null ? null : _statusLabel(outcome, l10n);
    final discharged = _isDischarged;
    final canDischarge = !discharged && outcome == PatientStatusDto.inTreatment;
    final patientId = widget.patientId;

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
                        onBack: () => context.goBackOr(PatientRoutes.list),
                      ),
                      if (discharged) ...[
                        const SizedBox(height: Spacing.control),
                        ClinicalAlert(
                          severity: ClinicalSeverity.stable,
                          title: l10n.patientDischargedBanner,
                          description: l10n.patientDischargedAt(
                            _dischargedAt ??
                                _dateLabel(widget.discharge ?? ''),
                            statusLabel ?? '',
                          ),
                        ),
                      ],
                      const SizedBox(height: Spacing.block),
                      PatientHeader(
                        name: patient.name,
                        metadata:
                            '${patient.code} · ${patient.gender.label(l10n)}',
                        avatarGlyph: avatarGlyph,
                        trailing: (patientId == null || patientId.isEmpty)
                            ? null
                            : PatientActionsMenu(
                                patientId: patientId,
                                patientName: patient.name,
                                patientCode: patient.code,
                              ),
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
                              value: statusLabel,
                            ),
                        ],
                        padding: const EdgeInsets.symmetric(
                          horizontal: Spacing.group,
                        ),
                      ),
                      const SizedBox(height: Spacing.section),
                      if (patientId != null && patientId.isNotEmpty) ...[
                        NextOfKinSection(
                          patientId: patientId,
                          nextOfKins: widget.nextOfKins,
                        ),
                        const SizedBox(height: Spacing.section),
                      ],
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
                            // Straight into the empirical-diagnosis wizard;
                            // the intermediate "Thêm diễn biến" page is gone.
                            Expanded(
                              child: AppButton(
                                label: l10n.patientAddTreatment,
                                size: AppButtonSize.medium,
                                onPressed: () =>
                                    context.push(DiagnosisRoutes.wizard),
                              ),
                            ),
                            if (canDischarge) ...[
                              const SizedBox(width: Spacing.control),
                              Expanded(
                                child: AppButton(
                                  label: l10n.patientDischarge,
                                  type: AppButtonType.destructive,
                                  size: AppButtonSize.medium,
                                  leadingIcon: LucideIcons.logOut,
                                  onPressed: _onDischarge,
                                ),
                              ),
                            ],
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
