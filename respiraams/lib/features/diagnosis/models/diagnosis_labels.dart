import '../../../l10n/l10n.dart';

/// `InfectionType` values accepted by `POST /diagnose.otherInfections`.
const infectionTypes = <String>[
  'SkinAndSoftTissueInfection',
  'SepticArthritis',
  'Osteomyelitis',
  'BacterialMyositisOrMuscleAbscess',
  'InfectedGoutyTophus',
  'PyelonephritisOrRenalAbscess',
  'AcuteCystitis',
  'AcuteNonGonococcalUrethritis',
  'BacterialVaginourethritis',
  'BacterialEndometritis',
  'PurulentMeningitis',
  'BacterialEncephalitis',
  'PleuralEmpyema',
  'MediastinalAbscess',
  'InfectiveEndocarditis',
  'BacterialMyocarditis',
  'BacterialPericarditis',
  'PulmonaryTuberculosis',
  'ExtrapulmonaryTuberculosis',
  'BiliaryTractInfection',
  'BacterialLiverAbscess',
  'InfectedAcutePancreatitis',
  'BacterialPeritonitis',
  'BacterialDiarrhea',
  'HelicobacterPyloriInfection',
  'Sepsis',
  'OrbitalCellulitis',
  'Conjunctivitis',
  'Keratitis',
  'Dacryocystitis',
  'MaxillofacialAbscess',
  'Other',
];

String infectionTypeLabel(String type, AppLocalizations l10n) => switch (type) {
      'SkinAndSoftTissueInfection' => l10n.infectionSkinSoftTissue,
      'SepticArthritis' => l10n.infectionSepticArthritis,
      'Osteomyelitis' => l10n.infectionOsteomyelitis,
      'BacterialMyositisOrMuscleAbscess' => l10n.infectionBacterialMyositis,
      'InfectedGoutyTophus' => l10n.infectionInfectedGoutyTophus,
      'PyelonephritisOrRenalAbscess' => l10n.infectionPyelonephritis,
      'AcuteCystitis' => l10n.infectionAcuteCystitis,
      'AcuteNonGonococcalUrethritis' =>
        l10n.infectionAcuteNonGonococcalUrethritis,
      'BacterialVaginourethritis' => l10n.infectionBacterialVaginourethritis,
      'BacterialEndometritis' => l10n.infectionBacterialEndometritis,
      'PurulentMeningitis' => l10n.infectionPurulentMeningitis,
      'BacterialEncephalitis' => l10n.infectionBacterialEncephalitis,
      'PleuralEmpyema' => l10n.infectionPleuralEmpyema,
      'MediastinalAbscess' => l10n.infectionMediastinalAbscess,
      'InfectiveEndocarditis' => l10n.infectionInfectiveEndocarditis,
      'BacterialMyocarditis' => l10n.infectionBacterialMyocarditis,
      'BacterialPericarditis' => l10n.infectionBacterialPericarditis,
      'PulmonaryTuberculosis' => l10n.infectionPulmonaryTuberculosis,
      'ExtrapulmonaryTuberculosis' => l10n.infectionExtrapulmonaryTuberculosis,
      'BiliaryTractInfection' => l10n.infectionBiliaryTract,
      'BacterialLiverAbscess' => l10n.infectionBacterialLiverAbscess,
      'InfectedAcutePancreatitis' => l10n.infectionInfectedAcutePancreatitis,
      'BacterialPeritonitis' => l10n.infectionBacterialPeritonitis,
      'BacterialDiarrhea' => l10n.infectionBacterialDiarrhea,
      'HelicobacterPyloriInfection' => l10n.infectionHelicobacterPylori,
      'Sepsis' => l10n.infectionSepsis,
      'OrbitalCellulitis' => l10n.infectionOrbitalCellulitis,
      'Conjunctivitis' => l10n.infectionConjunctivitis,
      'Keratitis' => l10n.infectionKeratitis,
      'Dacryocystitis' => l10n.infectionDacryocystitis,
      'MaxillofacialAbscess' => l10n.infectionMaxillofacialAbscess,
      'Other' => l10n.infectionOther,
      _ => type,
    };

/// `MicrobialSampleType` values accepted by `POST /diagnose.microbialSamples`.
const microbialSampleTypes = <String>[
  'Sputum',
  'BronchoalveolarLavageFluid',
  'PleuralFluid',
  'Urine',
  'Blood',
  'AbdominalFluid',
  'CerebrospinalFluid',
  'WoundExudate',
  'Other',
];

String microbialSampleTypeLabel(String type, AppLocalizations l10n) =>
    switch (type) {
      'Sputum' => l10n.sampleSputum,
      'BronchoalveolarLavageFluid' => l10n.sampleBronchoalveolarLavageFluid,
      'PleuralFluid' => l10n.samplePleuralFluid,
      'Urine' => l10n.sampleUrine,
      'Blood' => l10n.sampleBlood,
      'AbdominalFluid' => l10n.sampleAbdominalFluid,
      'CerebrospinalFluid' => l10n.sampleCerebrospinalFluid,
      'WoundExudate' => l10n.sampleWoundExudate,
      'Other' => l10n.sampleOther,
      _ => type,
    };

/// `MicCategory` values accepted by `POST /diagnose.microbialSamples`.
const micCategories = <String>['Susceptible', 'Intermediate', 'Resistant'];

String micCategoryLabel(String category, AppLocalizations l10n) =>
    switch (category) {
      'Susceptible' => l10n.micSusceptible,
      'Intermediate' => l10n.micIntermediate,
      'Resistant' => l10n.micResistant,
      _ => category,
    };
