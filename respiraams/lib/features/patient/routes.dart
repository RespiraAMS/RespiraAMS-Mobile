import 'package:go_router/go_router.dart';

import 'screens/add_patient_screen.dart';
import 'screens/edit_patient_screen.dart';
import 'screens/next_of_kin_form_screen.dart';
import 'screens/patient_detail_screen.dart';
import 'screens/patient_list_screen.dart';
import 'screens/treatment_plan_detail_screen.dart';

/// Typed path constants for the patient feature.
class PatientRoutes {
  /// Post-login workspace home (patient roster).
  static const list = '/';
  static const addPatient = '/patient/add';
  static const edit = '/patient/edit';
  static const nextOfKin = '/patient/next-of-kin';
  static const detail = '/patient/detail';
  static const treatmentPlan = '/patient/treatment-plan';

  /// Add-patient entry launched from the 'Chẩn đoán' nav tab; after saving it
  /// continues into the empirical diagnosis wizard.
  static const addPatientForDiagnosis = '$addPatient?flow=diagnosis';
}

final List<RouteBase> patientRoutes = [
  GoRoute(
    path: PatientRoutes.list,
    builder: (context, state) => const PatientListScreen(),
  ),
  GoRoute(
    path: PatientRoutes.addPatient,
    builder: (context, state) => AddPatientScreen(
      diagnosisEntry: state.uri.queryParameters['flow'] == 'diagnosis',
    ),
  ),
  GoRoute(
    path: PatientRoutes.edit,
    builder: (context, state) {
      final id = state.uri.queryParameters['id'];
      return EditPatientScreen(patientId: id);
    },
  ),
  GoRoute(
    path: PatientRoutes.nextOfKin,
    builder: (context, state) => NextOfKinFormScreen(
      patientId: state.uri.queryParameters['patientId'],
      nextOfKinId: state.uri.queryParameters['kinId'],
    ),
  ),
  GoRoute(
    path: PatientRoutes.detail,
    builder: (context, state) {
      final id = state.uri.queryParameters['id'];
      return PatientDetailScreen(patientId: id);
    },
  ),
  GoRoute(
    path: PatientRoutes.treatmentPlan,
    builder: (context, state) => TreatmentPlanDetailScreen(
      planId: state.uri.queryParameters['id'],
    ),
  ),
];
