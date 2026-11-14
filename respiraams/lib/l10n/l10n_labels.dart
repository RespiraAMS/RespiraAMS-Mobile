import '../core/network/api_response.dart';
import '../features/calculator/models/calculator.dart';
import '../features/antibiogram/models/antibiogram.dart';
import '../features/clinical_variables/models/clinical_variable.dart';
import '../features/diagnosis/models/diagnosis_result.dart';
import '../features/patient/models/patient.dart';
import '../features/patient/models/patient_summary.dart';
import '../features/statistics/models/statistics_view.dart';
import '../features/suspected_causes/models/suspected_cause.dart';
import '../features/treatment_protocol/models/treatment_protocol.dart';
import 'generated/app_localizations.dart';

/// Localized display labels for enums and value objects that live outside
/// the widget layer. Keeping them here (instead of on the models) lets every
/// label retranslate immediately when the language changes.

extension PatientStatusL10n on PatientStatus {
  String label(AppLocalizations l10n) => switch (this) {
        PatientStatus.treating => l10n.patientStatusTreating,
        PatientStatus.recovered => l10n.patientStatusRecovered,
        PatientStatus.deceased => l10n.patientStatusDeceased,
      };
}

extension GenderL10n on Gender {
  String label(AppLocalizations l10n) => switch (this) {
        Gender.nam => l10n.genderMale,
        Gender.nu => l10n.genderFemale,
      };
}

extension CalculatorIdL10n on CalculatorId {
  String description(AppLocalizations l10n) => switch (this) {
        CalculatorId.curb65 => l10n.calcCurb65Desc,
        CalculatorId.egfr => l10n.calcEgfrDesc,
        CalculatorId.crcl => l10n.calcCrclDesc,
        CalculatorId.bmi => l10n.calcBmiDesc,
        CalculatorId.qsofa => l10n.calcQsofaDesc,
      };
}

extension PeriodRangeL10n on PeriodRange {
  String label(AppLocalizations l10n) => switch (this) {
        PeriodRange.last30Days => l10n.periodLast30Days,
        PeriodRange.thisQuarter => l10n.periodThisQuarter,
        PeriodRange.thisYear => l10n.periodThisYear,
      };
}

extension KpiIdL10n on KpiId {
  String label(AppLocalizations l10n) => switch (this) {
        KpiId.diagnoses => l10n.kpiDiagnoses,
        KpiId.saved => l10n.kpiSaved,
        KpiId.microbiology => l10n.kpiMicrobiology,
      };
}

extension DiagnosisTabL10n on DiagnosisTab {
  String label(AppLocalizations l10n) => switch (this) {
        DiagnosisTab.result => l10n.diagnosisTabResult,
        DiagnosisTab.suspected => l10n.diagnosisTabSuspected,
        DiagnosisTab.evidences => l10n.diagnosisTabEvidences,
        DiagnosisTab.protocols => l10n.diagnosisTabProtocols,
      };
}

extension DiseaseSeverityL10n on DiseaseSeverity {
  String label(AppLocalizations l10n) => switch (this) {
        DiseaseSeverity.mild => l10n.severityMild,
        DiseaseSeverity.moderate => l10n.severityModerate,
        DiseaseSeverity.severe => l10n.severitySevere,
        DiseaseSeverity.unknown => l10n.commonOther,
      };
}

extension TreatmentSiteL10n on TreatmentSite {
  String label(AppLocalizations l10n) => switch (this) {
        TreatmentSite.outpatient => l10n.siteOutpatient,
        TreatmentSite.inpatient => l10n.siteInpatient,
        TreatmentSite.intensiveCareUnit => l10n.siteIcu,
        TreatmentSite.unknown => l10n.commonOther,
      };
}

extension MicCategoryL10n on MicCategory {
  String label(AppLocalizations l10n) => switch (this) {
        MicCategory.susceptible => l10n.micSusceptible,
        MicCategory.intermediate => l10n.micIntermediate,
        MicCategory.resistant => l10n.micResistant,
        MicCategory.unknown => l10n.commonOther,
      };
}

extension ProtocolSeverityL10n on ProtocolSeverity {
  String label(AppLocalizations l10n) => switch (this) {
        ProtocolSeverity.mild => l10n.severityMild,
        ProtocolSeverity.moderate => l10n.severityModerate,
        ProtocolSeverity.severe => l10n.severitySevere,
        ProtocolSeverity.unknown => l10n.commonOther,
      };
}

extension ProtocolTreatmentSiteL10n on ProtocolTreatmentSite {
  String label(AppLocalizations l10n) => switch (this) {
        ProtocolTreatmentSite.outpatient => l10n.siteOutpatient,
        ProtocolTreatmentSite.inpatient => l10n.siteInpatient,
        ProtocolTreatmentSite.intensiveCareUnit => l10n.siteIcu,
        ProtocolTreatmentSite.unknown => l10n.commonOther,
      };
}

extension ValueTypeL10n on ValueType {
  String label(AppLocalizations l10n) => switch (this) {
        ValueType.numeric => l10n.valueTypeNumeric,
        ValueType.boolean => l10n.valueTypeBoolean,
        ValueType.categorical => l10n.valueTypeCategorical,
        ValueType.unknown => l10n.valueTypeOther,
      };
}

extension VariableCategoryL10n on VariableCategory {
  String label(AppLocalizations l10n) => switch (this) {
        VariableCategory.personalInformation => l10n.variableCategoryPersonal,
        VariableCategory.medicalHistory => l10n.variableCategoryMedicalHistory,
        VariableCategory.paraclinical => l10n.variableCategoryParaclinical,
        VariableCategory.clinical => l10n.variableCategoryClinical,
        VariableCategory.unknown => l10n.variableCategoryOther,
      };

  /// Shorter variant used on list cards and filter chips.
  String shortLabel(AppLocalizations l10n) => switch (this) {
        VariableCategory.personalInformation =>
          l10n.variableCategoryPersonalShort,
        VariableCategory.medicalHistory => l10n.variableCategoryMedicalHistory,
        VariableCategory.paraclinical => l10n.variableCategoryParaclinical,
        VariableCategory.clinical => l10n.variableCategoryClinical,
        VariableCategory.unknown => l10n.variableCategoryOther,
      };
}

extension VariableRangeL10n on VariableRange {
  String formatDisplay(AppLocalizations l10n) {
    final minSymbol = isMinExclusive ? '>' : '≥';
    final maxSymbol = isMaxExclusive ? '<' : '≤';
    final unitStr = (unit != null && unit!.isNotEmpty) ? ' $unit' : '';

    final hasNoMax = max >= 7e28;
    final hasNoMin = min <= -7e28;

    if (hasNoMin && hasNoMax) return l10n.rangeUnlimited(unitStr);
    if (hasNoMin) return l10n.rangeSingle(maxSymbol, _fmt(max), unitStr);
    if (hasNoMax) return l10n.rangeSingle(minSymbol, _fmt(min), unitStr);
    return l10n.rangeBetween(
      minSymbol,
      _fmt(min),
      unitStr,
      maxSymbol,
      _fmt(max),
    );
  }

  static String _fmt(num value) {
    if (value is int || value == value.roundToDouble()) {
      return value.toInt().toString();
    }
    return value.toString();
  }
}

/// Maps a route value from the API ("Intravenous", "oral", …) to a
/// localized full label. Unknown values pass through unchanged.
String routeLabel(String route, AppLocalizations l10n) {
  switch (route.toLowerCase()) {
    case 'oral':
      return l10n.routeOral;
    case 'intravenous':
      return l10n.routeIntravenous;
    case 'intramuscular':
      return l10n.routeIntramuscular;
    default:
      return route;
  }
}

/// Short route label for selection chips ("IV", "Oral", …).
String routeAbbrev(String route, AppLocalizations l10n) {
  switch (route.toLowerCase()) {
    case 'oral':
      return l10n.routeAbbrevOral;
    case 'intravenous':
      return l10n.routeAbbrevIv;
    default:
      return route;
  }
}

/// Weekly chart labels are stored as stable tokens ("T1"…"T6") so they can
/// be rendered as "T1" (vi) or "W1" (en).
String localizedWeekLabel(String raw, AppLocalizations l10n) {
  final match = RegExp(r'^T(\d+)$').firstMatch(raw);
  if (match != null) {
    return l10n.statisticsWeek(int.parse(match.group(1)!));
  }
  return raw;
}

/// Translates an app-generated error token; backend messages pass through.
extension LocalizedApiErrorX on String {
  String localizedError(AppLocalizations l10n) {
    if (this == LocalApiError.connectivity) {
      return l10n.commonServerUnreachable;
    }
    if (this == LocalApiError.loadData) {
      return l10n.commonLoadDataError;
    }
    if (this == LocalApiError.noPatient) {
      return l10n.diagnosisFlowNoPatient;
    }
    if (this == LocalApiError.formLoadFailed) {
      return l10n.diagnosisFlowFormError;
    }
    if (startsWith(LocalApiError.badRequestPrefix)) {
      final status = int.tryParse(
        substring(LocalApiError.badRequestPrefix.length),
      );
      return l10n.commonBadRequest(status ?? 0);
    }
    if (startsWith(LocalApiError.missingRequiredPrefix)) {
      return l10n.diagnosisFlowMissing(
        substring(LocalApiError.missingRequiredPrefix.length),
      );
    }
    if (startsWith(LocalApiError.invalidNumberPrefix)) {
      return l10n.diagnosisInvalidNumber(
        substring(LocalApiError.invalidNumberPrefix.length),
      );
    }
    if (startsWith(LocalApiError.invalidObservationsPrefix)) {
      return l10n.diagnosisInvalidFields(
        substring(LocalApiError.invalidObservationsPrefix.length),
      );
    }
    if (this == LocalApiError.allergyRequired) {
      return l10n.diagnosisAllergyRequired;
    }
    if (this == LocalApiError.allergyYesRequired) {
      return l10n.diagnosisAllergyYesRequired;
    }
    if (this == LocalApiError.allergyOtherRequired) {
      return l10n.diagnosisAllergyOtherRequired;
    }
    if (this == LocalApiError.microbialPathogenRequired) {
      return l10n.diagnosisMicrobialPathogenRequired;
    }
    if (this == LocalApiError.noResultToSave) {
      return l10n.diagnosisConfirmMissingResult;
    }
    if (this == LocalApiError.noProtocolToSave) {
      return l10n.diagnosisNoProtocolToSave;
    }
    if (this == LocalApiError.selectMedicineRequired) {
      return l10n.diagnosisSelectMedicineRequired;
    }
    return this;
  }
}
