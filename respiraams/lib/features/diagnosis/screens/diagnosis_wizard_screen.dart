import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/context_extensions.dart';
import '../../../../design_system/design_system.dart';
import '../../patient/models/patient.dart';
import '../../patient/providers/current_patient_provider.dart';
import '../../patient/routes.dart';
import '../../patient/widgets/section_label_widget.dart';
import '../models/clinical_dtos.dart';
import '../providers/diagnosis_controller.dart';
import '../providers/diagnosis_flow_provider.dart';
import '../routes.dart';
import '../widgets/selection_row_widget.dart';

/// Route `/diagnosis` — dynamic empirical-diagnosis wizard. Its steps and
/// inputs are derived from the variable catalog returned by
/// `GET /diagnose/empirical`.
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
            data: (variables) {
              if (!_prefilled) {
                _prefilled = true;
                WidgetsBinding.instance.addPostFrameCallback(
                  (_) => _prefill(variables),
                );
              }
              final steps = _buildSteps(variables);
              if (steps.isEmpty) {
                return const Center(child: Text('Không có dữ liệu biểu mẫu.'));
              }
              final step = steps[_step.clamp(0, steps.length - 1)];
              final isLast = _step >= steps.length - 1;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppAppBar(
                    title: 'Chẩn đoán kinh nghiệm',
                    subtitle: 'Bước ${_step + 1}/${steps.length} · ${step.title}',
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
                              label: 'Quay lại',
                              type: AppButtonType.secondary,
                              onPressed: () => setState(() => _step -= 1),
                            ),
                          ),
                          const SizedBox(width: Spacing.group),
                        ],
                        Expanded(
                          child: AppButton(
                            label: isLast ? 'Chẩn đoán' : 'Tiếp tục',
                            loading:
                                ref.watch(diagnosisFlowControllerProvider)
                                    .diagnosing,
                            onPressed: isLast
                                ? () => _diagnose(context)
                                : () => setState(() => _step += 1),
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

  Future<void> _diagnose(BuildContext context) async {
    await ref
        .read(diagnosisFlowControllerProvider.notifier)
        .runEmpiricalDiagnosis();
    if (!context.mounted) return;
    final flow = ref.read(diagnosisFlowControllerProvider);
    if (flow.result != null) {
      context.push(DiagnosisRoutes.diagnosisResult);
    } else if (flow.errorMessage != null) {
      showAppToast(context, flow.errorMessage!);
    }
  }

  List<_Step> _buildSteps(List<ClinicalVariableDto> variables) {
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

    final steps = <_Step>[
      _Step(
        'Thông tin cá nhân',
        where((v) => v.category == 'PersonalInformation'),
      ),
      _Step('Chỉ số sinh tồn', clinicalNumeric),
      _Step('Kết quả xét nghiệm', paraclinicalNumeric),
      _Step(
        'Bệnh nền & nguy cơ',
        where((v) => v.valueType != 'Numeric' && v.category != 'PersonalInformation'),
      ),
    ];
    return steps.where((s) => s.variables.isNotEmpty).toList();
  }
}

/// Enum-free placeholder used to resolve the progress route without
/// importing the patient routes (avoids a feature cycle).
class PatientProgressRoute {
  static const value = '/patient/progress';
}

class _Step {
  const _Step(this.title, this.variables);

  final String title;
  final List<ClinicalVariableDto> variables;
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppAppBar(title: 'Chẩn đoán kinh nghiệm', subtitle: '', onBack: onBack),
        const Spacer(),
        Center(
          child: Text(
            'Không thể tải biểu mẫu chẩn đoán.',
            style: TypographyTokens.caption(context).copyWith(color: c.error),
          ),
        ),
        const SizedBox(height: Spacing.group),
        AppButton(label: 'Thử lại', expand: true, onPressed: onRetry),
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
