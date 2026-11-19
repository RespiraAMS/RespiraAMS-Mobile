import 'package:flutter/material.dart';

import 'package:respiraams/design_system/design_system.dart';
import 'package:respiraams/features/diagnosis/widgets/risk_pill_widget.dart';
import 'package:respiraams/features/diagnosis/widgets/selection_row_widget.dart';
import 'package:respiraams/features/patient/widgets/gender_option_widget.dart';
import 'package:respiraams/l10n/l10n.dart';

import '../models/calculator.dart';

/// Shared "Tính" button + result card plumbing for the simple calculators.
class _CalculatorScaffold extends StatelessWidget {
  const _CalculatorScaffold({
    required this.fields,
    required this.result,
    required this.onCalculate,
  });

  final List<Widget> fields;
  final Widget? result;
  final VoidCallback onCalculate;

  @override
  Widget build(BuildContext context) {
    final c = context.respiraColors;
    final l10n = context.l10n;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(Spacing.control),
            decoration: BoxDecoration(
              color: c.surface,
              borderRadius: AppRadius.md,
              border: Border.all(color: c.borderSubtle),
            ),
            child: Column(children: fields),
          ),
          if (result != null) ...[
            const SizedBox(height: Spacing.section),
            result!,
          ],
          const SizedBox(height: Spacing.section),
          AppButton(label: l10n.calcCalculate, expand: true, onPressed: onCalculate),
          const SizedBox(height: Spacing.section),
        ],
      ),
    );
  }
}

class _FieldCard extends StatelessWidget {
  const _FieldCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final c = context.respiraColors;

    return Container(
      padding: const EdgeInsets.all(Spacing.control),
      decoration: BoxDecoration(
        color: c.surface,
        borderRadius: AppRadius.sm,
        border: Border.all(color: c.borderSubtle),
      ),
      child: child,
    );
  }
}

/// Result card shared by the creatinine/BMI/qSOFA calculators.
class CalculatorResultCard extends StatelessWidget {
  const CalculatorResultCard({
    super.key,
    required this.title,
    required this.value,
    this.unit,
    required this.band,
    required this.advice,
    this.highRisk = false,
  });

  final String title;
  final String value;
  final String? unit;
  final String band;
  final String advice;
  final bool highRisk;

  @override
  Widget build(BuildContext context) {
    final c = context.respiraColors;

    return Container(
      padding: const EdgeInsets.all(Spacing.control + 2),
      decoration: BoxDecoration(
        color: c.surface,
        borderRadius: AppRadius.md,
        border: Border.all(color: c.borderSubtle),
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
                      .copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              Text(
                unit == null ? value : '$value $unit',
                style: TypographyTokens.h3(context).copyWith(
                  fontWeight: FontWeight.w700,
                  color: highRisk ? c.warning : c.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: Spacing.inline),
          RiskPillWidget(label: band, isHigh: highRisk),
          const SizedBox(height: Spacing.inline),
          AppText(advice, type: AppTextType.caption, maxLines: 3),
        ],
      ),
    );
  }
}

// ── eGFR (CKD-EPI 2021) ────────────────────────────────────────────────

class EgfrForm extends StatefulWidget {
  const EgfrForm({super.key});

  @override
  State<EgfrForm> createState() => _EgfrFormState();
}

class _EgfrFormState extends State<EgfrForm> {
  final _age = TextEditingController();
  final _creatinine = TextEditingController();
  CalcSex _sex = CalcSex.male;
  CreatinineUnit _unit = CreatinineUnit.umolL;
  bool _visible = false;

  @override
  void dispose() {
    _age.dispose();
    _creatinine.dispose();
    super.dispose();
  }

  EgfrInput get _input => EgfrInput(
        age: _age.text,
        creatinine: _creatinine.text,
        sex: _sex,
        unit: _unit,
      );

  void _calculate() {
    if (_input.value == null) {
      showAppToast(context, context.l10n.calcInvalidInput);
      return;
    }
    setState(() => _visible = true);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final input = _input;
    final egfr = input.value;

    return _CalculatorScaffold(
      onCalculate: _calculate,
      fields: [
        _FieldCard(
          child: AppUnitField(
            label: l10n.calcAge,
            unit: l10n.calcAgeUnit,
            initialValue: _age.text,
            onChanged: (value) => setState(() => _age.text = value),
          ),
        ),
        const SizedBox(height: Spacing.inline),
        _FieldCard(child: _SexPicker(sex: _sex, onChanged: (s) => setState(() => _sex = s))),
        const SizedBox(height: Spacing.inline),
        _FieldCard(
          child: AppUnitField(
            label: l10n.calcCreatinine,
            unit: _unit == CreatinineUnit.umolL ? 'µmol/L' : 'mg/dL',
            initialValue: _creatinine.text,
            onChanged: (value) => setState(() => _creatinine.text = value),
          ),
        ),
        const SizedBox(height: Spacing.inline),
        _FieldCard(
          child: _CreatinineUnitPicker(
            unit: _unit,
            onChanged: (u) => setState(() => _unit = u),
          ),
        ),
      ],
      result: !_visible || egfr == null
          ? null
          : CalculatorResultCard(
              title: 'eGFR',
              value: egfr.toStringAsFixed(0),
              unit: l10n.calcEgfrUnit,
              band: _egfrBand(input.stage, l10n),
              advice: l10n.calcEgfrNote,
              highRisk: (input.stage ?? '').startsWith('G4') ||
                  input.stage == 'G5',
            ),
    );
  }
}

String _egfrBand(String? stage, AppLocalizations l10n) => switch (stage) {
      'G1' => l10n.calcEgfrG1,
      'G2' => l10n.calcEgfrG2,
      'G3a' => l10n.calcEgfrG3a,
      'G3b' => l10n.calcEgfrG3b,
      'G4' => l10n.calcEgfrG4,
      'G5' => l10n.calcEgfrG5,
      _ => '',
    };

// ── CrCl (Cockcroft-Gault) ─────────────────────────────────────────────

class CrclForm extends StatefulWidget {
  const CrclForm({super.key});

  @override
  State<CrclForm> createState() => _CrclFormState();
}

class _CrclFormState extends State<CrclForm> {
  final _age = TextEditingController();
  final _weight = TextEditingController();
  final _creatinine = TextEditingController();
  CalcSex _sex = CalcSex.male;
  CreatinineUnit _unit = CreatinineUnit.umolL;
  bool _visible = false;

  @override
  void dispose() {
    _age.dispose();
    _weight.dispose();
    _creatinine.dispose();
    super.dispose();
  }

  CrclInput get _input => CrclInput(
        age: _age.text,
        weightKg: _weight.text,
        creatinine: _creatinine.text,
        sex: _sex,
        unit: _unit,
      );

  void _calculate() {
    if (_input.value == null) {
      showAppToast(context, context.l10n.calcInvalidInput);
      return;
    }
    setState(() => _visible = true);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final input = _input;
    final crcl = input.value;

    return _CalculatorScaffold(
      onCalculate: _calculate,
      fields: [
        _FieldCard(
          child: AppUnitField(
            label: l10n.calcAge,
            unit: l10n.calcAgeUnit,
            initialValue: _age.text,
            onChanged: (value) => setState(() => _age.text = value),
          ),
        ),
        const SizedBox(height: Spacing.inline),
        _FieldCard(
          child: AppUnitField(
            label: l10n.calcWeight,
            unit: l10n.calcWeightUnit,
            initialValue: _weight.text,
            onChanged: (value) => setState(() => _weight.text = value),
          ),
        ),
        const SizedBox(height: Spacing.inline),
        _FieldCard(child: _SexPicker(sex: _sex, onChanged: (s) => setState(() => _sex = s))),
        const SizedBox(height: Spacing.inline),
        _FieldCard(
          child: AppUnitField(
            label: l10n.calcCreatinine,
            unit: _unit == CreatinineUnit.umolL ? 'µmol/L' : 'mg/dL',
            initialValue: _creatinine.text,
            onChanged: (value) => setState(() => _creatinine.text = value),
          ),
        ),
        const SizedBox(height: Spacing.inline),
        _FieldCard(
          child: _CreatinineUnitPicker(
            unit: _unit,
            onChanged: (u) => setState(() => _unit = u),
          ),
        ),
      ],
      result: !_visible || crcl == null
          ? null
          : CalculatorResultCard(
              title: 'CrCl',
              value: crcl.toStringAsFixed(1),
              unit: l10n.calcCrclUnit,
              band: _crclBand(input.band, l10n),
              advice: l10n.calcCrclNote,
              highRisk: input.band == 'severe' || input.band == 'failure',
            ),
    );
  }
}

String _crclBand(String? band, AppLocalizations l10n) => switch (band) {
      'normal' => l10n.calcCrclNormal,
      'mild' => l10n.calcCrclMild,
      'moderate' => l10n.calcCrclModerate,
      'severe' => l10n.calcCrclSevere,
      'failure' => l10n.calcCrclFailure,
      _ => '',
    };

// ── BMI ────────────────────────────────────────────────────────────────

class BmiForm extends StatefulWidget {
  const BmiForm({super.key});

  @override
  State<BmiForm> createState() => _BmiFormState();
}

class _BmiFormState extends State<BmiForm> {
  final _height = TextEditingController();
  final _weight = TextEditingController();
  bool _visible = false;

  @override
  void dispose() {
    _height.dispose();
    _weight.dispose();
    super.dispose();
  }

  BmiInput get _input => BmiInput(
        heightCm: _height.text,
        weightKg: _weight.text,
      );

  void _calculate() {
    if (_input.value == null) {
      showAppToast(context, context.l10n.calcInvalidInput);
      return;
    }
    setState(() => _visible = true);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final input = _input;
    final bmi = input.value;

    return _CalculatorScaffold(
      onCalculate: _calculate,
      fields: [
        _FieldCard(
          child: AppUnitField(
            label: l10n.calcHeight,
            unit: l10n.calcHeightUnit,
            initialValue: _height.text,
            onChanged: (value) => setState(() => _height.text = value),
          ),
        ),
        const SizedBox(height: Spacing.inline),
        _FieldCard(
          child: AppUnitField(
            label: l10n.calcWeight,
            unit: l10n.calcWeightUnit,
            initialValue: _weight.text,
            onChanged: (value) => setState(() => _weight.text = value),
          ),
        ),
      ],
      result: !_visible || bmi == null
          ? null
          : CalculatorResultCard(
              title: 'BMI',
              value: bmi.toStringAsFixed(1),
              unit: l10n.calcBmiUnit,
              band: _bmiBand(input.band, l10n),
              advice: l10n.calcBmiNote,
              highRisk: input.band == 'obese',
            ),
    );
  }
}

String _bmiBand(String? band, AppLocalizations l10n) => switch (band) {
      'underweight' => l10n.calcBmiUnderweight,
      'normal' => l10n.calcBmiNormal,
      'overweight' => l10n.calcBmiOverweight,
      'obese' => l10n.calcBmiObese,
      _ => '',
    };

// ── qSOFA ──────────────────────────────────────────────────────────────

class QsofaForm extends StatefulWidget {
  const QsofaForm({super.key});

  @override
  State<QsofaForm> createState() => _QsofaFormState();
}

class _QsofaFormState extends State<QsofaForm> {
  QsofaInput _input = const QsofaInput();
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return _CalculatorScaffold(
      onCalculate: () => setState(() => _visible = true),
      fields: [
        _FieldCard(
          child: Column(
            children: [
              SelectionRowWidget(
                title: l10n.calcQsofaRespRate,
                description: l10n.calcQsofaRespRateDesc,
                selected: _input.respRate22,
                onTap: () => setState(
                  () => _input = QsofaInput(
                    respRate22: !_input.respRate22,
                    sbp100: _input.sbp100,
                    gcs15: _input.gcs15,
                  ),
                ),
              ),
              const SizedBox(height: Spacing.inline),
              SelectionRowWidget(
                title: l10n.calcQsofaSbp,
                description: l10n.calcQsofaSbpDesc,
                selected: _input.sbp100,
                onTap: () => setState(
                  () => _input = QsofaInput(
                    respRate22: _input.respRate22,
                    sbp100: !_input.sbp100,
                    gcs15: _input.gcs15,
                  ),
                ),
              ),
              const SizedBox(height: Spacing.inline),
              SelectionRowWidget(
                title: l10n.calcQsofaGcs,
                description: l10n.calcQsofaGcsDesc,
                selected: _input.gcs15,
                onTap: () => setState(
                  () => _input = QsofaInput(
                    respRate22: _input.respRate22,
                    sbp100: _input.sbp100,
                    gcs15: !_input.gcs15,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
      result: !_visible
          ? null
          : CalculatorResultCard(
              title: 'qSOFA',
              value: '${_input.score}/3',
              band: _input.highRisk ? l10n.calcQsofaHigh : l10n.calcQsofaLow,
              advice: l10n.calcQsofaNote,
              highRisk: _input.highRisk,
            ),
    );
  }
}

// ── Shared pickers ─────────────────────────────────────────────────────

class _SexPicker extends StatelessWidget {
  const _SexPicker({required this.sex, required this.onChanged});

  final CalcSex sex;
  final ValueChanged<CalcSex> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.calcSex,
          style: TypographyTokens.label(context)
              .copyWith(color: context.respiraColors.textPrimary),
        ),
        const SizedBox(height: Spacing.inline),
        Row(
          children: [
            GenderOptionWidget(
              label: l10n.genderMale,
              selected: sex == CalcSex.male,
              onTap: () => onChanged(CalcSex.male),
            ),
            const SizedBox(width: Spacing.inline),
            GenderOptionWidget(
              label: l10n.genderFemale,
              selected: sex == CalcSex.female,
              onTap: () => onChanged(CalcSex.female),
            ),
          ],
        ),
      ],
    );
  }
}

class _CreatinineUnitPicker extends StatelessWidget {
  const _CreatinineUnitPicker({required this.unit, required this.onChanged});

  final CreatinineUnit unit;
  final ValueChanged<CreatinineUnit> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.calcCreatinineUnit,
          style: TypographyTokens.label(context)
              .copyWith(color: context.respiraColors.textPrimary),
        ),
        const SizedBox(height: Spacing.inline),
        AppSegmentedTabs<CreatinineUnit>(
          segments: [
            (CreatinineUnit.umolL, l10n.calcUnitUmol),
            (CreatinineUnit.mgDl, l10n.calcUnitMgDl),
          ],
          selected: unit,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
