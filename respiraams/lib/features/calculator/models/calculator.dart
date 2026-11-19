import 'dart:math' as math;

import 'package:freezed_annotation/freezed_annotation.dart';

part 'calculator.freezed.dart';
part 'calculator.g.dart';

/// Clinical calculators offered on the 'Máy tính' tab. Descriptions are
/// provided by `l10n_labels.dart`.
enum CalculatorId {
  curb65('CURB-65'),
  egfr('eGFR'),
  crcl('CrCl'),
  bmi('BMI'),
  qsofa('qSOFA');

  const CalculatorId(this.title);

  final String title;
}

/// Raw CURB-65 inputs of the calculator. Empty fields count as unmet
/// (same semantics as the diagnosis wizard).
@freezed
class Curb65Input with _$Curb65Input {
  const factory Curb65Input({
    @Default(false) bool confusion,
    @Default('') String urea,
    @Default('') String respRate,
    @Default('') String sbp,
    @Default('') String dbp,
    @Default('') String age,
  }) = _Curb65Input;

  factory Curb65Input.fromJson(Map<String, dynamic> json) =>
      _$Curb65InputFromJson(json);
}

extension Curb65InputX on Curb65Input {
  static double? _parse(String raw) {
    final value = double.tryParse(raw.trim().replaceAll(',', '.'));
    return (value == null || value < 0) ? null : value;
  }

  bool get hasConfusion => confusion;

  bool get hasHighUrea => (_parse(urea) ?? 0) > 7;

  bool get hasTachypnea => (_parse(respRate) ?? 0) >= 30;

  bool get hasHypotension {
    final systolic = _parse(sbp);
    final diastolic = _parse(dbp);
    if (systolic == null && diastolic == null) return false;
    return (systolic != null && systolic < 90) ||
        (diastolic != null && diastolic <= 60);
  }

  bool get hasAgeOver65 => (_parse(age) ?? 0) >= 65;

  /// CURB-65 score 0–5, one point per met criterion.
  int get score => [
        hasConfusion,
        hasHighUrea,
        hasTachypnea,
        hasHypotension,
        hasAgeOver65,
      ].where((met) => met).length;
}

/// Sex input shared by the creatinine-based calculators.
enum CalcSex { male, female }

/// Creatinine unit; Vietnamese labs usually report µmol/L, international
/// references use mg/dL.
enum CreatinineUnit { umolL, mgDl }

double? _positive(String raw) {
  final value = double.tryParse(raw.trim().replaceAll(',', '.'));
  return (value == null || value <= 0) ? null : value;
}

double _toMgDl(double value, CreatinineUnit unit) =>
    unit == CreatinineUnit.umolL ? value / 88.4 : value;

/// eGFR — CKD-EPI 2021 (creatinine, no race coefficient).
class EgfrInput {
  const EgfrInput({
    this.age = '',
    this.creatinine = '',
    this.sex = CalcSex.male,
    this.unit = CreatinineUnit.umolL,
  });

  final String age;
  final String creatinine;
  final CalcSex sex;
  final CreatinineUnit unit;

  /// eGFR in mL/min/1.73 m², or `null` while the inputs are incomplete.
  double? get value {
    final years = _positive(age);
    final raw = _positive(creatinine);
    if (years == null || raw == null) return null;

    final scr = _toMgDl(raw, unit);
    final female = sex == CalcSex.female;
    final kappa = female ? 0.7 : 0.9;
    final alpha = female ? -0.241 : -0.302;
    final ratio = scr / kappa;

    final result = 142 *
        math.pow(math.min(ratio, 1), alpha) *
        math.pow(math.max(ratio, 1), -1.2) *
        math.pow(0.9938, years) *
        (female ? 1.012 : 1.0);
    return result.toDouble();
  }

  /// KDIGO stage token (`G1`…`G5`), localized by the UI.
  String? get stage {
    final egfr = value;
    if (egfr == null) return null;
    if (egfr >= 90) return 'G1';
    if (egfr >= 60) return 'G2';
    if (egfr >= 45) return 'G3a';
    if (egfr >= 30) return 'G3b';
    if (egfr >= 15) return 'G4';
    return 'G5';
  }
}

/// CrCl — Cockcroft-Gault (creatinine clearance for dose adjustment).
class CrclInput {
  const CrclInput({
    this.age = '',
    this.weightKg = '',
    this.creatinine = '',
    this.sex = CalcSex.male,
    this.unit = CreatinineUnit.umolL,
  });

  final String age;
  final String weightKg;
  final String creatinine;
  final CalcSex sex;
  final CreatinineUnit unit;

  /// CrCl in mL/min, or `null` while the inputs are incomplete.
  double? get value {
    final years = _positive(age);
    final weight = _positive(weightKg);
    final raw = _positive(creatinine);
    if (years == null || weight == null || raw == null) return null;

    final scr = _toMgDl(raw, unit);
    if (scr <= 0) return null;

    final base = ((140 - years) * weight) / (72 * scr);
    return sex == CalcSex.female ? base * 0.85 : base;
  }

  /// `normal` · `mild` · `moderate` · `severe` · `failure`, localized by the UI.
  String? get band {
    final crcl = value;
    if (crcl == null) return null;
    if (crcl >= 90) return 'normal';
    if (crcl >= 60) return 'mild';
    if (crcl >= 30) return 'moderate';
    if (crcl >= 15) return 'severe';
    return 'failure';
  }
}

/// BMI — body mass index with the Asia-Pacific classification.
class BmiInput {
  const BmiInput({this.heightCm = '', this.weightKg = ''});

  final String heightCm;
  final String weightKg;

  /// BMI in kg/m², or `null` while the inputs are incomplete.
  double? get value {
    final height = _positive(heightCm);
    final weight = _positive(weightKg);
    if (height == null || weight == null) return null;

    final metres = height / 100;
    return weight / (metres * metres);
  }

  /// `underweight` · `normal` · `overweight` · `obese` (Asia-Pacific cut-offs).
  String? get band {
    final bmi = value;
    if (bmi == null) return null;
    if (bmi < 18.5) return 'underweight';
    if (bmi < 23) return 'normal';
    if (bmi < 25) return 'overweight';
    return 'obese';
  }
}

/// qSOFA — quick sepsis-related organ failure assessment (0–3).
class QsofaInput {
  const QsofaInput({
    this.respRate22 = false,
    this.sbp100 = false,
    this.gcs15 = false,
  });

  final bool respRate22;
  final bool sbp100;
  final bool gcs15;

  int get score => [respRate22, sbp100, gcs15].where((met) => met).length;

  /// Two or more criteria mark a high risk of poor outcome.
  bool get highRisk => score >= 2;
}
