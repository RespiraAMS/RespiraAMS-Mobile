import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/context_extensions.dart';
import '../../../../design_system/design_system.dart';
import '../../../../l10n/l10n.dart';
import 'package:respiraams/features/diagnosis/models/microbiology_result.dart';
import 'package:respiraams/features/diagnosis/providers/microbiology_provider.dart';
import 'package:respiraams/features/diagnosis/routes.dart';
import 'package:respiraams/features/diagnosis/widgets/microbiology_banner.dart';
import '../models/add_progress_form_state.dart';
import '../models/patient.dart';
import '../providers/add_progress_controller.dart';
import '../providers/current_patient_provider.dart';
import '../routes.dart';
import '../widgets/section_label_widget.dart';
import '../widgets/selection_row_widget.dart';

/// Route `/patient/progress` — record a treatment change. The form
/// switches between the empirical variant (reason checkboxes) and the
/// targeted variant (microbiology-based) via the treatment-type tabs.
class AddProgressScreen extends ConsumerStatefulWidget {
  const AddProgressScreen({super.key});

  @override
  ConsumerState<AddProgressScreen> createState() => _AddProgressScreenState();
}

class _AddProgressScreenState extends ConsumerState<AddProgressScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final form = ref.watch(addProgressControllerProvider);
    final controller = ref.read(addProgressControllerProvider.notifier);
    final patient = ref.watch(currentPatientProvider);
    final isTargeted = form.treatmentType == TreatmentType.targeted;

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
                        title: l10n.progressTitle,
                        subtitle: isTargeted
                            ? l10n.progressSubtitleTargeted
                            : l10n.progressSubtitleEmpirical,
                        onBack: () => context.goBackOr(PatientRoutes.detail),
                      ),
                      const SizedBox(height: Spacing.section),
                      PatientHeader(
                        variant: PatientHeaderVariant.nested,
                        name: patient?.name ?? l10n.patientNoSelection,
                        metadata: patient?.code ?? '',
                        avatarGlyph: patient?.gender == Gender.nu ? '👩🏾' : '👨🏻',
                      ),
                      const SizedBox(height: Spacing.section),
                      SectionLabelWidget(
                        isTargeted
                            ? l10n.progressTreatmentTypeNext
                            : l10n.progressTreatmentType,
                      ),
                      const SizedBox(height: Spacing.xxxs),
                      AppSegmentedTabs<TreatmentType>(
                        segments: [
                          (
                            TreatmentType.empirical,
                            TreatmentType.empirical.label(l10n),
                          ),
                          (
                            TreatmentType.targeted,
                            TreatmentType.targeted.label(l10n),
                          ),
                        ],
                        selected: form.treatmentType,
                        onChanged: controller.selectTreatment,
                      ),
                      const SizedBox(height: Spacing.section),
                      if (isTargeted)
                        _TargetedBody(micro: ref.watch(microbiologyResultProvider))
                      else
                        _EmpiricalBody(
                          form: form,
                          controller: controller,
                        ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: Spacing.lg,
                        ),
                        child: AppButton(
                          label: isTargeted
                              ? l10n.progressContinueTargeted
                              : l10n.progressSave,
                          expand: true,
                          onPressed: () => context.push(
                            isTargeted
                                ? DiagnosisRoutes.targetedTreatment
                                : DiagnosisRoutes.wizard,
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

/// Empirical variant: reason checkboxes + editability warning.
class _EmpiricalBody extends StatelessWidget {
  const _EmpiricalBody({required this.form, required this.controller});

  final AddProgressFormState form;
  final AddProgressController controller;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionLabelWidget(l10n.progressReason),
        const SizedBox(height: Spacing.xxxs),
        SelectionRowWidget(
          title: l10n.progressHasMicro,
          description: l10n.progressHasMicroDesc,
          selected: form.microbiologyResult,
          onTap: controller.toggleMicrobiologyResult,
        ),
        const SizedBox(height: Spacing.control),
        SelectionRowWidget(
          title: l10n.progressPoorResponse,
          description: l10n.progressPoorResponseDesc,
          selected: form.poorResponse,
          onTap: controller.togglePoorResponse,
        ),
        const SizedBox(height: Spacing.section),
        ClinicalAlert(
          severity: ClinicalSeverity.needsAttention,
          title: l10n.progressLockTitle,
          description: l10n.progressLockDesc,
        ),
      ],
    );
  }
}

/// Targeted variant: identified bacteria + latest antibiogram + warning
/// to verify the antibiogram before choosing drugs.
class _TargetedBody extends StatelessWidget {
  const _TargetedBody({required this.micro});

  final MicrobiologyResult micro;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BacteriaDisplayField(bacteria: micro.bacteria),
        const SizedBox(height: Spacing.control),
        AntibiogramBanner(line: micro.antibiogramLine),
        const SizedBox(height: Spacing.section),
        ClinicalAlert(
          severity: ClinicalSeverity.needsAttention,
          title: l10n.progressTargetedAlertTitle,
          description: l10n.progressTargetedAlertDesc,
        ),
      ],
    );
  }
}
