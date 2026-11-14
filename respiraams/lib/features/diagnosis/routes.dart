import 'package:go_router/go_router.dart';

import 'models/clinical_dtos.dart';
import 'screens/confirm_treatment_screen.dart';
import 'screens/diagnosis_result_screen.dart';
import 'screens/diagnosis_wizard_screen.dart';
import 'screens/targeted_treatment_screen.dart';

class DiagnosisRoutes {
  static const wizard = '/diagnosis';
  static const diagnosisResult = '/diagnosis-result';
  static const confirmTreatment = '/diagnosis/confirm-treatment';
  static const targetedTreatment = '/targeted-treatment';
}

final List<RouteBase> diagnosisRoutes = [
  GoRoute(
    path: DiagnosisRoutes.wizard,
    builder: (c, s) => const DiagnosisWizardScreen(),
  ),
  GoRoute(
    path: DiagnosisRoutes.diagnosisResult,
    builder: (c, s) => const DiagnosisResultScreen(),
  ),
  GoRoute(
    path: DiagnosisRoutes.confirmTreatment,
    builder: (c, s) => ConfirmTreatmentScreen(
      result: s.extra is DiagnoseResultDto ? s.extra as DiagnoseResultDto : null,
    ),
  ),
  GoRoute(
    path: DiagnosisRoutes.targetedTreatment,
    builder: (c, s) => const TargetedTreatmentScreen(),
  ),
];
