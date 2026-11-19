import 'package:flutter_test/flutter_test.dart';

import 'package:respiraams/features/calculator/models/calculator.dart';

/// Reference values computed from the published equations:
/// * eGFR — CKD-EPI 2021 creatinine equation
/// * CrCl — Cockcroft-Gault
/// * BMI — Asia-Pacific classification
/// * qSOFA — 3 criteria, ≥ 2 = high risk
void main() {
  group('eGFR (CKD-EPI 2021)', () {
    test('matches the reference equation for a 60-year-old male', () {
      const input = EgfrInput(
        age: '60',
        creatinine: '1.0',
        unit: CreatinineUnit.mgDl,
      );

      expect(input.value, closeTo(86.2, 0.5));
      expect(input.stage, 'G2');
    });

    test('converts µmol/L to mg/dL', () {
      const umol = EgfrInput(age: '60', creatinine: '88.4');
      const mgDl = EgfrInput(
        age: '60',
        creatinine: '1.0',
        unit: CreatinineUnit.mgDl,
      );

      expect(umol.value, closeTo(mgDl.value!, 0.5));
    });

    test('applies the female coefficient', () {
      const male = EgfrInput(
        age: '50',
        creatinine: '1.0',
        unit: CreatinineUnit.mgDl,
      );
      const female = EgfrInput(
        age: '50',
        creatinine: '1.0',
        unit: CreatinineUnit.mgDl,
        sex: CalcSex.female,
      );

      // Same creatinine → lower eGFR in women (lower muscle mass).
      expect(male.value, closeTo(91.7, 0.5));
      expect(female.value, closeTo(68.6, 0.5));
      expect(female.stage, 'G2');
    });

    test('returns null while the inputs are incomplete', () {
      expect(const EgfrInput().value, isNull);
      expect(const EgfrInput(age: '60').value, isNull);
      expect(const EgfrInput(age: '60', creatinine: '0').value, isNull);
    });
  });

  group('CrCl (Cockcroft-Gault)', () {
    test('matches the reference equation', () {
      const input = CrclInput(
        age: '60',
        weightKg: '70',
        creatinine: '1.0',
        unit: CreatinineUnit.mgDl,
      );

      expect(input.value, closeTo(77.8, 0.1));
      expect(input.band, 'mild');
    });

    test('applies the 0.85 female factor', () {
      const female = CrclInput(
        age: '60',
        weightKg: '70',
        creatinine: '1.0',
        unit: CreatinineUnit.mgDl,
        sex: CalcSex.female,
      );

      expect(female.value, closeTo(77.8 * 0.85, 0.2));
    });

    test('bands severe impairment', () {
      const input = CrclInput(
        age: '80',
        weightKg: '50',
        creatinine: '3.0',
        unit: CreatinineUnit.mgDl,
      );

      expect(input.band, anyOf('severe', 'failure'));
    });
  });

  group('BMI', () {
    test('computes and classifies with Asia-Pacific cut-offs', () {
      expect(
        const BmiInput(heightCm: '170', weightKg: '60').value,
        closeTo(20.8, 0.1),
      );
      expect(
        const BmiInput(heightCm: '170', weightKg: '60').band,
        'normal',
      );
      expect(
        const BmiInput(heightCm: '170', weightKg: '50').band,
        'underweight',
      );
      expect(
        const BmiInput(heightCm: '170', weightKg: '70').band,
        'overweight',
      );
      expect(const BmiInput(heightCm: '170', weightKg: '80').band, 'obese');
    });

    test('returns null for missing values', () {
      expect(const BmiInput(heightCm: '170').value, isNull);
    });
  });

  group('qSOFA', () {
    test('counts the met criteria', () {
      expect(const QsofaInput().score, 0);
      expect(const QsofaInput(respRate22: true).score, 1);
      expect(
        const QsofaInput(respRate22: true, sbp100: true).score,
        2,
      );
      expect(
        const QsofaInput(respRate22: true, sbp100: true, gcs15: true).score,
        3,
      );
    });

    test('two criteria mean high risk', () {
      expect(const QsofaInput(respRate22: true).highRisk, isFalse);
      expect(
        const QsofaInput(respRate22: true, gcs15: true).highRisk,
        isTrue,
      );
    });
  });
}
