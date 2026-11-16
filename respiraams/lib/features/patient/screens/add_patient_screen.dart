import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/context_extensions.dart';
import '../../../../design_system/design_system.dart';
import '../../../../core/network/api_response.dart';
import '../../../../l10n/l10n.dart';
import '../../diagnosis/routes.dart';
import '../models/add_patient_form_state.dart';
import '../models/patient.dart';
import '../providers/add_patient_controller.dart';
import '../providers/add_patient_saving_provider.dart';
import '../widgets/gender_option_widget.dart';
import '../widgets/section_label_widget.dart';
import '../routes.dart';

/// Route `/patient/add` — "Thêm bệnh nhân" form.
///
/// When reached with [diagnosisEntry] (query `?flow=diagnosis` from the
/// bottom-nav 'Chẩn đoán' tab), saving continues straight into the empirical
/// diagnosis wizard for the just-created patient.
class AddPatientScreen extends ConsumerWidget {
  const AddPatientScreen({super.key, this.diagnosisEntry = false});

  final bool diagnosisEntry;

  static final _phonePattern =
      RegExp(r'^(0[35789]|84[35789]|\+84[35789])\d{8}$');
  static final _insurancePattern = RegExp(r'^\d{10}$');

  String? _validate(AddPatientFormState form, AppLocalizations l10n) {
    if (form.lastName.trim().isEmpty || form.firstName.trim().isEmpty) {
      return l10n.patientErrName;
    }
    if (form.code.trim().isEmpty) {
      return l10n.patientErrCode;
    }
    if (form.dob.trim().isEmpty) {
      return l10n.patientErrDob;
    }
    if (ddMmYyyyToIsoDate(form.dob) == null) {
      return l10n.patientErrDobFormat;
    }
    if (!_phonePattern.hasMatch(form.phoneNumber.trim())) {
      return l10n.patientErrPhone;
    }
    if (!_insurancePattern.hasMatch(form.insurance.trim())) {
      return l10n.patientErrInsurance;
    }
    if ((double.tryParse(form.heightCm.trim().replaceAll(',', '.')) ?? 0) <= 0) {
      return l10n.patientErrHeight;
    }
    if ((double.tryParse(form.weightKg.trim().replaceAll(',', '.')) ?? 0) <= 0) {
      return l10n.patientErrWeight;
    }
    if (form.address.trim().isEmpty) {
      return l10n.patientErrAddress;
    }
    if (form.city.trim().isEmpty) {
      return l10n.patientErrCity;
    }
    return null;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final form = ref.watch(addPatientControllerProvider);
    final controller = ref.read(addPatientControllerProvider.notifier);
    final saving = ref.watch(addPatientSavingProvider);

    Future<void> save(BuildContext context) async {
      final error = _validate(form, l10n);
      if (error != null) {
        showAppToast(context, error);
        return;
      }
      try {
        await controller.save();
        if (!context.mounted) return;
        // Replace the form so back from the next screen returns to the
        // roster instead of the just-submitted form.
        context.pushReplacement(
          diagnosisEntry ? DiagnosisRoutes.wizard : PatientRoutes.detail,
        );
      } on ApiException catch (e) {
        showAppToast(context, e.message);
      } on DioException catch (e) {
        showAppToast(context, dioErrorMessage(e).localizedError(l10n));
      } catch (_) {
        showAppToast(context, l10n.patientCreateFailed);
      }
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Spacing.group),
          child: LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AppAppBar(
                        title: l10n.patientAddTitle,
                        subtitle: l10n.patientAddSubtitle,
                        onBack: () => context.goBackOr(PatientRoutes.list),
                      ),
                      const SizedBox(height: Spacing.section),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: AppTextField(
                              label: l10n.patientLastName,
                              initialValue: form.lastName,
                              onChanged: controller.setLastName,
                            ),
                          ),
                          const SizedBox(width: Spacing.group),
                          Expanded(
                            child: AppTextField(
                              label: l10n.patientFirstName,
                              initialValue: form.firstName,
                              onChanged: controller.setFirstName,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: Spacing.group),
                      AppTextField(
                        label: l10n.patientRecordCode,
                        initialValue: form.code,
                        hintText: l10n.patientRecordCodeHint,
                        onChanged: controller.setCode,
                      ),
                      const SizedBox(height: Spacing.group),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: AppTextField(
                              label: l10n.patientDob,
                              initialValue: form.dob,
                              onChanged: controller.setDob,
                              hintText: 'dd/MM/yyyy',
                              keyboardType: TextInputType.datetime,
                            ),
                          ),
                          const SizedBox(width: Spacing.group),
                          Expanded(
                            child: _GenderField(
                              selected: form.gender,
                              onSelect: controller.setGender,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: Spacing.group),
                      AppTextField(
                        label: l10n.patientInsuranceCard,
                        keyboardType: TextInputType.number,
                        initialValue: form.insurance,
                        onChanged: controller.setInsurance,
                      ),
                      const SizedBox(height: Spacing.group),
                      AppTextField(
                        label: l10n.patientPhone,
                        keyboardType: TextInputType.phone,
                        initialValue: form.phoneNumber,
                        onChanged: controller.setPhoneNumber,
                      ),
                      const SizedBox(height: Spacing.group),
                      AppUnitField(
                        label: l10n.patientHeight,
                        unit: 'cm',
                        initialValue: form.heightCm,
                        expanded: true,
                        onChanged: controller.setHeightCm,
                      ),
                      const SizedBox(height: Spacing.group),
                      AppUnitField(
                        label: l10n.patientWeight,
                        unit: 'kg',
                        initialValue: form.weightKg,
                        expanded: true,
                        onChanged: controller.setWeightKg,
                      ),
                      const SizedBox(height: Spacing.group),
                      AppTextField(
                        label: l10n.patientAddress,
                        initialValue: form.address,
                        onChanged: controller.setAddress,
                      ),
                      const SizedBox(height: Spacing.group),
                      AppTextField(
                        label: l10n.patientProvince,
                        initialValue: form.city,
                        onChanged: controller.setCity,
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(top: Spacing.block),
                        child: AppButton(
                          label: saving
                              ? l10n.patientSaving
                              : l10n.patientSaveRecord,
                          expand: true,
                          loading: saving,
                          onPressed: saving ? null : () => save(context),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _GenderField extends StatelessWidget {
  const _GenderField({required this.selected, required this.onSelect});

  final Gender selected;
  final ValueChanged<Gender> onSelect;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SectionLabelWidget(l10n.patientGender),
        const SizedBox(height: Spacing.inline),
        Row(
          children: [
            GenderOptionWidget(
              label: Gender.nam.label(l10n),
              selected: selected == Gender.nam,
              onTap: () => onSelect(Gender.nam),
            ),
            const SizedBox(width: Spacing.inline),
            GenderOptionWidget(
              label: Gender.nu.label(l10n),
              selected: selected == Gender.nu,
              onTap: () => onSelect(Gender.nu),
            ),
          ],
        ),
      ],
    );
  }
}
