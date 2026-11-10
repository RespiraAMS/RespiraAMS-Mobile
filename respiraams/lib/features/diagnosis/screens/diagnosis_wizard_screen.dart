import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/utils/context_extensions.dart';
import '../../../../design_system/design_system.dart';
import '../../../../l10n/l10n.dart';
import '../../patient/models/patient.dart';
import '../../patient/providers/current_patient_provider.dart';
import '../../patient/routes.dart';
import '../../patient/widgets/section_label_widget.dart';
import '../models/clinical_dtos.dart';
import '../models/diagnosis_labels.dart';
import '../providers/diagnosis_controller.dart';
import '../providers/diagnosis_flow_provider.dart';
import '../routes.dart';
import '../widgets/selection_row_widget.dart';

/// Route `/diagnosis` — dynamic empirical-diagnosis wizard. Its steps and
/// inputs are derived from the variable catalog returned by
/// `GET /diagnose`.
class DiagnosisWizardScreen extends ConsumerStatefulWidget {
  const DiagnosisWizardScreen({super.key});

  @override
  ConsumerState<DiagnosisWizardScreen> createState() =>
      _DiagnosisWizardScreenState();
}

class _DiagnosisWizardScreenState extends ConsumerState<DiagnosisWizardScreen> {
  int _step = 0;
  bool _prefilled = false;

  @override
  Widget build(BuildContext context) {
    final formAsync = ref.watch(diagnosisFormProvider);
    final l10n = context.l10n;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Spacing.group),
          child: formAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (_, _) => _ErrorView(
              onBack: () => context.goBackOr(PatientRoutes.progress),
              onRetry: () => ref.invalidate(diagnosisFormProvider),
            ),
            data: (form) {
              if (!_prefilled) {
                _prefilled = true;
                WidgetsBinding.instance.addPostFrameCallback(
                  (_) => _prefill(form.variables),
                );
              }
              final steps = _buildSteps(form, l10n);
              if (steps.isEmpty) {
                return Center(child: Text(l10n.diagnosisEmptyForm));
              }
              final step = steps[_step.clamp(0, steps.length - 1)];
              final isLast = _step >= steps.length - 1;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppAppBar(
                    title: l10n.diagnosisTitle,
                    subtitle: l10n.diagnosisStepProgress(
                      _step + 1,
                      steps.length,
                      step.title,
                    ),
                    onBack: () => _back(steps.length),
                  ),
                  const SizedBox(height: Spacing.section),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          for (final variable in step.variables) ...[
                            _VariableField(variable: variable),
                            const SizedBox(height: Spacing.group),
                          ],
                          if (step.kind == _StepKind.allergy)
                            _AllergySection(antibiotics: step.antibiotics),
                          if (step.kind == _StepKind.specialHistory)
                            const _SpecialHistorySection(),
                          if (step.kind == _StepKind.otherInfections)
                            const _OtherInfectionsSection(),
                          if (step.kind == _StepKind.microbialSamples)
                            _MicrobialSamplesSection(
                              pathogens: step.pathogens,
                            ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: Spacing.lg),
                    child: Row(
                      children: [
                        if (_step > 0) ...[
                          Expanded(
                            child: AppButton(
                              label: l10n.diagnosisBack,
                              type: AppButtonType.secondary,
                              onPressed: () => setState(() => _step -= 1),
                            ),
                          ),
                          const SizedBox(width: Spacing.group),
                        ],
                        Expanded(
                          child: AppButton(
                            label: isLast
                                ? l10n.diagnosisRun
                                : l10n.diagnosisContinue,
                            loading:
                                ref.watch(diagnosisFlowControllerProvider)
                                    .diagnosing,
                            onPressed: isLast
                                ? () => _diagnose(context, step)
                                : () => _continue(context, step),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void _back(int stepCount) {
    if (_step > 0) {
      setState(() => _step -= 1);
    } else {
      context.goBackOr(PatientRoutes.progress);
    }
  }

  void _continue(BuildContext context, _Step step) {
    final error = _validateStep(step, context.l10n);
    if (error != null) {
      showAppToast(context, error);
      return;
    }
    setState(() => _step += 1);
  }

  void _prefill(List<ClinicalVariableDto> variables) {
    final patient = ref.read(currentPatientProvider);
    if (patient == null) return;
    final controller = ref.read(diagnosisControllerProvider.notifier);
    final state = ref.read(diagnosisControllerProvider);
    for (final variable in variables) {
      if (state.valueOf(variable.id) != null) continue;
      switch (variable.code) {
        case 'AGE':
          final age = _ageFromDob(patient.dob);
          if (age != null) controller.setValue(variable.id, '$age');
        case 'GENDER':
          controller.setValue(
            variable.id,
            patient.gender == Gender.nam ? 'Male' : 'Female',
          );
        case 'HEIGHT':
          if (patient.heightCm != null) {
            controller.setValue(variable.id, '${patient.heightCm}');
          }
        case 'WEIGHT':
          if (patient.weightKg != null) {
            controller.setValue(variable.id, '${patient.weightKg}');
          }
      }
    }
  }

  Future<void> _diagnose(BuildContext context, _Step step) async {
    final error = _validateStep(step, context.l10n);
    if (error != null) {
      showAppToast(context, error);
      return;
    }

    await ref
        .read(diagnosisFlowControllerProvider.notifier)
        .runEmpiricalDiagnosis();
    if (!context.mounted) return;
    final flow = ref.read(diagnosisFlowControllerProvider);
    if (flow.result != null) {
      context.push(DiagnosisRoutes.diagnosisResult);
    } else if (flow.errorMessage != null) {
      showAppToast(context, flow.errorMessage!.localizedError(context.l10n));
    }
  }

  String? _validateStep(_Step step, AppLocalizations l10n) {
    final form = ref.read(diagnosisControllerProvider);

    if (step.kind == _StepKind.allergy) {
      if (!form.hasAllergySelection) return l10n.diagnosisAllergyRequired;
      if (form.hasAntibioticAllergy &&
          form.allergicAntibioticIds.isEmpty) {
        return l10n.diagnosisAllergyYesRequired;
      }
      if (form.needsOtherAllergy && form.otherAllergy.trim().isEmpty) {
        return l10n.diagnosisAllergyOtherRequired;
      }
    }

    if (step.kind == _StepKind.microbialSamples &&
        form.microbialSamples.any((s) => s.pathogenId.trim().isEmpty)) {
      return l10n.diagnosisMicrobialPathogenRequired;
    }

    if (step.kind == _StepKind.variables) {
      for (final variable in step.variables) {
        if (!variable.isRequired || variable.valueType == 'Boolean') continue;
        final raw = form.valueOf(variable.id)?.trim() ?? '';
        if (raw.isEmpty) return l10n.diagnosisFlowMissing(variable.name);
        if (variable.valueType == 'Numeric' && double.tryParse(raw) == null) {
          return l10n.diagnosisInvalidNumber(variable.name);
        }
      }
    }

    return null;
  }

  List<_Step> _buildSteps(
    DiagnosisFormDto form,
    AppLocalizations l10n,
  ) {
    final variables = form.variables;

    List<ClinicalVariableDto> where(bool Function(ClinicalVariableDto) test) =>
        variables.where(test).toList();

    // FiO₂ lives in the Clinical category but is only meaningful next to
    // PaO₂ (the P/F ratio), so it is moved into the paraclinical step and
    // placed immediately before PaO₂.
    final clinicalNumeric = where(
      (v) =>
          v.valueType == 'Numeric' &&
          v.category == 'Clinical' &&
          v.code != 'FIO2',
    );
    final paraclinicalNumeric = where(
      (v) => v.valueType == 'Numeric' && v.category == 'Paraclinical',
    );
    final fio2 = variables.where((v) => v.code == 'FIO2').toList();
    if (fio2.isNotEmpty) {
      final pao2Index = paraclinicalNumeric.indexWhere(
        (v) => v.code == 'PAO2',
      );
      paraclinicalNumeric.insert(
        pao2Index < 0 ? 0 : pao2Index,
        fio2.first,
      );
    }

    final personal = where((v) => v.category == 'PersonalInformation');
    final medicalHistory = where((v) => v.category == 'MedicalHistory');
    final otherVariables = where(
      (v) =>
          v.category != 'PersonalInformation' &&
          v.category != 'MedicalHistory' &&
          v.valueType != 'Numeric',
    );

    // Safety net: never silently drop a variable the backend expects.
    final assignedIds = {
      ...personal.map((v) => v.id),
      ...medicalHistory.map((v) => v.id),
      ...clinicalNumeric.map((v) => v.id),
      ...paraclinicalNumeric.map((v) => v.id),
      ...otherVariables.map((v) => v.id),
    };
    final leftovers =
        variables.where((v) => !assignedIds.contains(v.id)).toList();

    final steps = <_Step>[
      _Step.variables(l10n.diagnosisPersonalInfo, personal),
      _Step.variables(l10n.diagnosisVitalSigns, clinicalNumeric),
      _Step.variables(l10n.diagnosisLabResults, paraclinicalNumeric),
      _Step.variables(l10n.diagnosisMedicalHistory, medicalHistory),
      _Step.variables(l10n.diagnosisComorbidities, [
        ...otherVariables,
        ...leftovers,
      ]),
      _Step.specialHistory(l10n.diagnosisSpecialHistory),
      _Step.otherInfections(l10n.diagnosisOtherInfections),
      if (form.pathogens.isNotEmpty)
        _Step.microbialSamples(
          l10n.diagnosisMicrobialSamples,
          form.pathogens,
        ),
      _Step.allergy(l10n.diagnosisAllergy, form.antibiotics),
    ];
    return steps
        .where(
          (s) => s.kind != _StepKind.variables || s.variables.isNotEmpty,
        )
        .toList();
  }
}

/// Enum-free placeholder used to resolve the progress route without
/// importing the patient routes (avoids a feature cycle).
class PatientProgressRoute {
  static const value = '/patient/progress';
}

enum _StepKind {
  variables,
  allergy,
  specialHistory,
  otherInfections,
  microbialSamples,
}

class _Step {
  const _Step.variables(this.title, this.variables)
      : kind = _StepKind.variables,
        antibiotics = const [],
        pathogens = const [];

  const _Step.allergy(this.title, this.antibiotics)
      : kind = _StepKind.allergy,
        variables = const [],
        pathogens = const [];

  const _Step.specialHistory(this.title)
      : kind = _StepKind.specialHistory,
        variables = const [],
        antibiotics = const [],
        pathogens = const [];

  const _Step.otherInfections(this.title)
      : kind = _StepKind.otherInfections,
        variables = const [],
        antibiotics = const [],
        pathogens = const [];

  const _Step.microbialSamples(this.title, this.pathogens)
      : kind = _StepKind.microbialSamples,
        variables = const [],
        antibiotics = const [];

  final String title;
  final _StepKind kind;
  final List<ClinicalVariableDto> variables;
  final List<AntibioticFormDto> antibiotics;
  final List<NamedRefDto> pathogens;
}

/// Allergy step: `AllergyType` selector plus the antibiotic multi-select /
/// free-text fallback, matching `POST /diagnose`'s `AllergyQuery`.
class _AllergySection extends ConsumerWidget {
  const _AllergySection({required this.antibiotics});

  final List<AntibioticFormDto> antibiotics;

  static const _types = [
    'No',
    'Yes',
    'NonRegisteredAntibiotic',
    'Unknown',
  ];

  String _typeLabel(String type, AppLocalizations l10n) => switch (type) {
        'No' => l10n.diagnosisAllergyNo,
        'Yes' => l10n.diagnosisAllergyYes,
        'NonRegisteredAntibiotic' => l10n.diagnosisAllergyNonRegistered,
        _ => l10n.diagnosisAllergyUnknown,
      };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final form = ref.watch(diagnosisControllerProvider);
    final controller = ref.read(diagnosisControllerProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionLabelWidget(l10n.diagnosisAllergyType),
        const SizedBox(height: Spacing.inline),
        Wrap(
          spacing: Spacing.inline,
          runSpacing: Spacing.inline,
          children: [
            for (final type in _types)
              _ChoiceChip(
                label: _typeLabel(type, l10n),
                selected: form.allergyType == type,
                onTap: () => controller.setAllergyType(type),
              ),
          ],
        ),
        if (form.hasAntibioticAllergy) ...[
          const SizedBox(height: Spacing.section),
          SectionLabelWidget(l10n.diagnosisAllergySelect),
          const SizedBox(height: Spacing.inline),
          if (antibiotics.isEmpty)
            Text(
              l10n.diagnosisNoData,
              style: TypographyTokens.caption(context),
            )
          else
            for (final antibiotic in antibiotics)
              Padding(
                padding: const EdgeInsets.only(bottom: Spacing.inline),
                child: SelectionRowWidget(
                  title: antibiotic.name,
                  selected:
                      form.allergicAntibioticIds.contains(antibiotic.id),
                  onTap: () => controller.toggleAllergy(antibiotic.id),
                ),
              ),
        ],
        if (form.needsOtherAllergy) ...[
          const SizedBox(height: Spacing.section),
          AppTextField(
            label: l10n.diagnosisAllergyOther,
            initialValue: form.otherAllergy,
            onChanged: controller.setOtherAllergy,
          ),
        ],
      ],
    );
  }
}

class _SpecialHistorySection extends ConsumerStatefulWidget {
  const _SpecialHistorySection();

  @override
  ConsumerState<_SpecialHistorySection> createState() =>
      _SpecialHistorySectionState();
}

class _SpecialHistorySectionState
    extends ConsumerState<_SpecialHistorySection> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final form = ref.watch(diagnosisControllerProvider);
    final controller = ref.read(diagnosisControllerProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppTextField(
          label: l10n.diagnosisSpecialHistory,
          controller: _controller,
          hintText: l10n.diagnosisSpecialHistoryHint,
        ),
        const SizedBox(height: Spacing.control),
        AppButton(
          label: l10n.diagnosisAdd,
          type: AppButtonType.outline,
          size: AppButtonSize.medium,
          onPressed: () {
            controller.addSpecialHistory(_controller.text);
            _controller.clear();
          },
        ),
        if (form.specialMedicalHistory.isNotEmpty) ...[
          const SizedBox(height: Spacing.section),
          AppCard.divided([
            for (var i = 0; i < form.specialMedicalHistory.length; i++)
              _RemovableRow(
                title: form.specialMedicalHistory[i],
                onRemove: () => controller.removeSpecialHistory(i),
              ),
          ]),
        ],
      ],
    );
  }
}

class _RemovableRow extends StatelessWidget {
  const _RemovableRow({required this.title, required this.onRemove});

  final String title;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final c = context.respiraColors;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Spacing.control,
        vertical: Spacing.inline,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TypographyTokens.body(context),
            ),
          ),
          IconButton(
            onPressed: onRemove,
            icon: Icon(LucideIcons.x, size: ControlSize.iconMd),
            color: c.textSecondary,
            tooltip: context.l10n.diagnosisRemove,
          ),
        ],
      ),
    );
  }
}

class _OtherInfectionsSection extends ConsumerWidget {
  const _OtherInfectionsSection();

  Future<void> _openPicker(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: context.respiraColors.surface,
      builder: (_) => const _InfectionPickerSheet(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final form = ref.watch(diagnosisControllerProvider);
    final controller = ref.read(diagnosisControllerProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (form.otherInfections.isEmpty)
          AppText(l10n.diagnosisNoData, type: AppTextType.caption)
        else
          Wrap(
            spacing: Spacing.inline,
            runSpacing: Spacing.inline,
            children: [
              for (final type in form.otherInfections)
                _ChoiceChip(
                  label: infectionTypeLabel(type, l10n),
                  selected: true,
                  onTap: () => controller.toggleOtherInfection(type),
                ),
            ],
          ),
        const SizedBox(height: Spacing.group),
        AppButton(
          label: l10n.diagnosisOtherInfectionsSelect,
          type: AppButtonType.outline,
          size: AppButtonSize.medium,
          onPressed: () => _openPicker(context),
        ),
      ],
    );
  }
}

class _InfectionPickerSheet extends ConsumerWidget {
  const _InfectionPickerSheet();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final form = ref.watch(diagnosisControllerProvider);
    final controller = ref.read(diagnosisControllerProvider.notifier);

    return SafeArea(
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.82,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(Spacing.group),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      l10n.diagnosisOtherInfectionsSelect,
                      style: TypographyTokens.h2(context),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(LucideIcons.x),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(
                  horizontal: Spacing.group,
                  vertical: Spacing.inline,
                ),
                itemCount: infectionTypes.length,
                separatorBuilder: (_, _) =>
                    const SizedBox(height: Spacing.inline),
                itemBuilder: (context, index) {
                  final type = infectionTypes[index];
                  return SelectionRowWidget(
                    title: infectionTypeLabel(type, l10n),
                    selected: form.otherInfections.contains(type),
                    onTap: () => controller.toggleOtherInfection(type),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MicrobialSamplesSection extends ConsumerWidget {
  const _MicrobialSamplesSection({required this.pathogens});

  final List<NamedRefDto> pathogens;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final form = ref.watch(diagnosisControllerProvider);
    final controller = ref.read(diagnosisControllerProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (form.microbialSamples.isEmpty)
          AppText(l10n.diagnosisNoData, type: AppTextType.caption),
        for (var i = 0; i < form.microbialSamples.length; i++) ...[
          _MicrobialSampleCard(
            index: i,
            sample: form.microbialSamples[i],
            pathogens: pathogens,
          ),
          const SizedBox(height: Spacing.group),
        ],
        AppButton(
          label: l10n.diagnosisMicrobialAdd,
          type: AppButtonType.outline,
          size: AppButtonSize.medium,
          onPressed: controller.addMicrobialSample,
        ),
      ],
    );
  }
}

class _MicrobialSampleCard extends ConsumerWidget {
  const _MicrobialSampleCard({
    required this.index,
    required this.sample,
    required this.pathogens,
  });

  final int index;
  final MicrobialSampleInputDto sample;
  final List<NamedRefDto> pathogens;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final controller = ref.read(diagnosisControllerProvider.notifier);

    return AppCard(
      padding: const EdgeInsets.all(Spacing.control),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  '${l10n.diagnosisMicrobialSamples} ${index + 1}',
                  style: TypographyTokens.label(context),
                ),
              ),
              IconButton(
                onPressed: () => controller.removeMicrobialSample(index),
                icon: const Icon(LucideIcons.x),
                tooltip: l10n.diagnosisRemove,
              ),
            ],
          ),
          const SizedBox(height: Spacing.inline),
          _DropdownField<String>(
            label: l10n.diagnosisMicrobialSampleType,
            value: sample.sampleType,
            items: [
              for (final type in microbialSampleTypes)
                (type, microbialSampleTypeLabel(type, l10n)),
            ],
            onChanged: (value) {
              if (value != null) {
                controller.updateMicrobialSample(index, sampleType: value);
              }
            },
          ),
          const SizedBox(height: Spacing.control),
          _DropdownField<String>(
            label: l10n.diagnosisMicrobialMicCategory,
            value: sample.micCategory,
            items: [
              for (final category in micCategories)
                (category, micCategoryLabel(category, l10n)),
            ],
            onChanged: (value) {
              if (value != null) {
                controller.updateMicrobialSample(index, micCategory: value);
              }
            },
          ),
          const SizedBox(height: Spacing.control),
          _DropdownField<String>(
            label: l10n.diagnosisMicrobialPathogen,
            value: sample.pathogenId,
            items: [
              ('', l10n.diagnosisMicrobialPathogenHint),
              for (final pathogen in pathogens) (pathogen.id, pathogen.name),
            ],
            onChanged: (value) {
              if (value != null) {
                controller.updateMicrobialSample(index, pathogenId: value);
              }
            },
          ),
        ],
      ),
    );
  }
}

class _DropdownField<T> extends StatelessWidget {
  const _DropdownField({
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  final String label;
  final T value;
  final List<(T, String)> items;
  final ValueChanged<T?> onChanged;

  @override
  Widget build(BuildContext context) {
    final c = context.respiraColors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TypographyTokens.label(context),
        ),
        const SizedBox(height: Spacing.inline),
        Container(
          height: ControlSize.inputDefault,
          padding: const EdgeInsets.symmetric(horizontal: Spacing.control),
          decoration: BoxDecoration(
            color: c.surface,
            borderRadius: AppRadius.md,
            border: Border.all(color: c.borderSubtle),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              value: value,
              isExpanded: true,
              icon: Icon(LucideIcons.chevronDown, color: c.iconDefault),
              items: [
                for (final (itemValue, itemLabel) in items)
                  DropdownMenuItem<T>(
                    value: itemValue,
                    child: Text(
                      itemLabel,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
              ],
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}

class _VariableField extends ConsumerWidget {
  const _VariableField({required this.variable});

  final ClinicalVariableDto variable;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = ref.watch(diagnosisControllerProvider);
    final controller = ref.read(diagnosisControllerProvider.notifier);

    switch (variable.valueType) {
      case 'Boolean':
        return SelectionRowWidget(
          title: _label(variable),
          selected: form.isTrue(variable.id),
          onTap: () => controller.setBool(
            variable.id,
            !form.isTrue(variable.id),
          ),
        );
      case 'Categorical':
        final selected = form.valueOf(variable.id);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionLabelWidget(_label(variable)),
            const SizedBox(height: Spacing.inline),
            Wrap(
              spacing: Spacing.inline,
              runSpacing: Spacing.inline,
              children: [
                for (final option in variable.acceptedValues)
                  _ChoiceChip(
                    label: option,
                    selected: selected == option,
                    onTap: () => controller.setValue(variable.id, option),
                  ),
              ],
            ),
          ],
        );
      default:
        return AppUnitField(
          label: _label(variable),
          unit: _unit(variable),
          initialValue: form.valueOf(variable.id) ?? '',
          onChanged: (value) => controller.setValue(variable.id, value),
        );
    }
  }
}

class _ChoiceChip extends StatelessWidget {
  const _ChoiceChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.respiraColors;
    return Material(
      color: selected ? c.primarySoft : c.surface,
      borderRadius: AppRadius.full,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: Spacing.group,
            vertical: Spacing.control,
          ),
          decoration: BoxDecoration(
            borderRadius: AppRadius.full,
            border: Border.all(
              color: selected ? c.primary : c.borderSubtle,
            ),
          ),
          child: AppText(
            label,
            type: AppTextType.label,
            color: selected ? c.primary : c.textSecondary,
          ),
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.onBack, required this.onRetry});

  final VoidCallback onBack;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final c = context.respiraColors;
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppAppBar(title: l10n.diagnosisTitle, subtitle: '', onBack: onBack),
        const Spacer(),
        Center(
          child: Text(
            l10n.diagnosisFormLoadFailed,
            style: TypographyTokens.caption(context).copyWith(color: c.error),
          ),
        ),
        const SizedBox(height: Spacing.group),
        AppButton(label: l10n.commonTryAgain, expand: true, onPressed: onRetry),
        const Spacer(),
      ],
    );
  }
}

/// Short display labels for variables whose API name is a long Vietnamese
/// phrase carrying the abbreviation in parentheses.
const _labelOverrides = {
  'FIO2': 'FiO2',
  'PAO2': 'PaO2',
  'SPO2': 'SpO2',
};

/// Canonical units missing from the seed data, sourced from the PSI
/// reference (Hct %, Na⁺ mmol/L, glucose mg/dl).
const _unitOverrides = {
  'HEMATOCRIT': '%',
  'NA+': 'mmol/L',
  'BLOOD-GLUCOSE': 'mg/dl',
};

String _label(ClinicalVariableDto variable) =>
    _labelOverrides[variable.code] ?? variable.name;

String _unit(ClinicalVariableDto variable) =>
    _unitOverrides[variable.code] ?? variable.canonicalUnit ?? '';

int? _ageFromDob(String dob) {
  final parts = dob.split('/');
  if (parts.length != 3) return null;
  final day = int.tryParse(parts[0]);
  final month = int.tryParse(parts[1]);
  final year = int.tryParse(parts[2]);
  if (day == null || month == null || year == null) return null;
  final birth = DateTime(year, month, day);
  final now = DateTime.now();
  var age = now.year - birth.year;
  if (now.month < birth.month ||
      (now.month == birth.month && now.day < birth.day)) {
    age -= 1;
  }
  return age < 0 ? null : age;
}
