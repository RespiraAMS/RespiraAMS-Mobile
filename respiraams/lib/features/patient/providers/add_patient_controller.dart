import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/api_client.dart';
import '../../../core/network/api_response.dart';
import '../models/add_patient_form_state.dart';
import '../models/patient.dart';
import '../services/patient_service.dart';
import 'active_patient_provider.dart';
import 'add_patient_saving_provider.dart';
import 'patient_list_provider.dart';

part 'add_patient_controller.g.dart';

/// Holds the "Thêm bệnh nhân" form state and submits it to
/// `POST /patients` (guidelines §2.1 Riverpod codegen).
///
/// Starts empty; every field is entered by the user.
@Riverpod(keepAlive: true)
class AddPatientController extends _$AddPatientController {
  PatientService get _service => PatientService(ref.watch(apiClientProvider));

  @override
  AddPatientFormState build() => const AddPatientFormState(
        address: 'Ninh Kiều',
        city: 'Cần Thơ',
      );

  void setLastName(String value) => state = state.copyWith(lastName: value);

  void setFirstName(String value) => state = state.copyWith(firstName: value);

  void setCode(String value) => state = state.copyWith(code: value);

  void setDob(String value) => state = state.copyWith(dob: value);

  void setInsurance(String value) => state = state.copyWith(insurance: value);

  void setPhoneNumber(String value) =>
      state = state.copyWith(phoneNumber: value);

  void setHeightCm(String value) => state = state.copyWith(heightCm: value);

  void setWeightKg(String value) => state = state.copyWith(weightKg: value);

  void setAddress(String value) => state = state.copyWith(address: value);

  void setCity(String value) => state = state.copyWith(city: value);

  void setGender(Gender gender) {
    state = state.copyWith(gender: gender);
  }

  /// Creates the patient via the API and makes them the active patient so
  /// every downstream screen (progress, wizard, detail) reflects the
  /// record just saved. Returns the new patient's ID.
  ///
  /// Throws [ApiException] on failure (guidelines Rule 3).
  Future<String> save() async {
    final saving = ref.read(addPatientSavingProvider.notifier);
    saving.set(true);
    try {
      final form = state;
      // dd/MM/yyyy (prototype format) → yyyy-MM-dd (API DateOnly).
      final dobIso = ddMmYyyyToIsoDate(form.dob) ?? form.dob;

      final height = double.tryParse(form.heightCm.trim().replaceAll(',', '.')) ?? 0;
      final weight = double.tryParse(form.weightKg.trim().replaceAll(',', '.')) ?? 0;

      final id = await _service.createPatient(
        firstName: form.firstName.trim(),
        lastName: form.lastName.trim(),
        phoneNumber: form.phoneNumber.trim(),
        dateOfBirth: dobIso,
        gender: form.gender == Gender.nam ? 'Male' : 'Female',
        height: height,
        weight: weight,
        medicalRecordCode: form.code.trim(),
        healthInsuranceCard: form.insurance.trim(),
        address: form.address.trim(),
        city: form.city.trim(),
      );

      final patient = Patient(
        id: id,
        name: '${form.lastName} ${form.firstName}'.trim(),
        code: form.code.trim(),
        dob: form.dob,
        gender: form.gender,
        insurance: form.insurance.trim(),
        address: form.address.trim(),
        heightCm: height > 0 ? height : null,
        weightKg: weight > 0 ? weight : null,
      );
      ref.read(activePatientControllerProvider.notifier).set(patient);
      // The roster is keep-alive; refresh it so the new patient appears when
      // the user returns to the list (fire-and-forget).
      ref.read(patientListControllerProvider.notifier).refresh();
      return id;
    } finally {
      saving.set(false);
    }
  }
}
