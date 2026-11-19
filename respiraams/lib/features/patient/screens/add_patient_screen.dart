import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/network/api_response.dart';
import '../../../../core/utils/context_extensions.dart';
import '../../../../core/validation/input_formatters.dart';
import '../../../../core/validation/validators.dart';
import '../../../../design_system/design_system.dart';
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
///
/// Inputs are constrained by [input_formatters] and validated inline so the
/// doctor sees the problem on the field itself, not only as a toast.
class AddPatientScreen extends ConsumerStatefulWidget {
  const AddPatientScreen({super.key, this.diagnosisEntry = false});

  final bool diagnosisEntry;

  @override
  ConsumerState<AddPatientScreen> createState() => _AddPatientScreenState();
}

class _AddPatientScreenState extends ConsumerState<AddPatientScreen> {
  /// Field key → error message (null = valid).
  final Map<String, String?> _errors = {};

  /// Owns the date-of-birth text so the picker can write into the same field
  /// the keyboard edits.
  late final TextEditingController _dobController;

  @override
  void initState() {
    super.initState();
    _dobController = TextEditingController(
      text: ref.read(addPatientControllerProvider).dob,
    );
  }

  @override
  void dispose() {
    _dobController.dispose();
    super.dispose();
  }

  void _clearError(String key) {
    if (_errors[key] == null) return;
    setState(() => _errors.remove(key));
  }

  /// Validates every field, stores the messages and returns the first one.
  String? _validate(AddPatientFormState form, AppLocalizations l10n) {
    final dobIso = ddMmYyyyToIsoDate(form.dob);
    final height = double.tryParse(form.heightCm.trim().replaceAll(',', '.'));
    final weight = double.tryParse(form.weightKg.trim().replaceAll(',', '.'));

    final errors = <String, String?>{
      'lastName': form.lastName.trim().isEmpty ? l10n.patientErrName : null,
      'firstName': form.firstName.trim().isEmpty ? l10n.patientErrName : null,
      'code': form.code.trim().isEmpty ? l10n.patientErrCode : null,
      'dob': form.dob.trim().isEmpty
          ? l10n.patientErrDob
          : dobIso == null
              ? l10n.patientErrDobFormat
              : isNotFutureDate(dobIso)
                  ? null
                  : l10n.patientErrDobFuture,
      'insurance': isValidHealthInsuranceCard(form.insurance)
          ? null
          : l10n.patientErrInsurance,
      'phone': isValidVietnamesePhone(form.phoneNumber)
          ? null
          : l10n.patientErrPhone,
      'height': (height ?? 0) <= 0 ? l10n.patientErrHeight : null,
      'weight': (weight ?? 0) <= 0 ? l10n.patientErrWeight : null,
      'address': form.address.trim().isEmpty ? l10n.patientErrAddress : null,
      'city': form.city.trim().isEmpty ? l10n.patientErrCity : null,
    };

    setState(() {
      _errors
        ..clear()
        ..addAll(errors);
    });

    for (final message in errors.values) {
      if (message != null) return message;
    }
    return null;
  }

  Future<void> _save(AddPatientFormState form) async {
    final l10n = context.l10n;
    final firstError = _validate(form, l10n);
    if (firstError != null) {
      showAppToast(context, firstError);
      return;
    }

    try {
      await ref.read(addPatientControllerProvider.notifier).save();
      if (!mounted) return;
      // Replace the form so back from the next screen returns to the roster
      // instead of the just-submitted form.
      context.pushReplacement(
        widget.diagnosisEntry ? DiagnosisRoutes.wizard : PatientRoutes.detail,
      );
    } on ApiException catch (e) {
      if (mounted) showAppToast(context, e.message);
    } on DioException catch (e) {
      if (mounted) {
        showAppToast(context, dioErrorMessage(e).localizedError(l10n));
      }
    } catch (_) {
      if (mounted) showAppToast(context, l10n.patientCreateFailed);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final form = ref.watch(addPatientControllerProvider);
    final controller = ref.read(addPatientControllerProvider.notifier);
    final saving = ref.watch(addPatientSavingProvider);

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
                              errorText: _errors['lastName'],
                              inputFormatters: personNameInputFormatters(),
                              onChanged: (value) {
                                controller.setLastName(value);
                                _clearError('lastName');
                              },
                            ),
                          ),
                          const SizedBox(width: Spacing.group),
                          Expanded(
                            child: AppTextField(
                              label: l10n.patientFirstName,
                              initialValue: form.firstName,
                              errorText: _errors['firstName'],
                              inputFormatters: personNameInputFormatters(),
                              onChanged: (value) {
                                controller.setFirstName(value);
                                _clearError('firstName');
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: Spacing.group),
                      AppTextField(
                        label: l10n.patientRecordCode,
                        initialValue: form.code,
                        hintText: l10n.patientRecordCodeHint,
                        errorText: _errors['code'],
                        inputFormatters: codeInputFormatters(),
                        onChanged: (value) {
                          controller.setCode(value);
                          _clearError('code');
                        },
                      ),
                      const SizedBox(height: Spacing.group),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: AppTextField(
                              label: l10n.patientDob,
                              controller: _dobController,
                              onChanged: (value) {
                                controller.setDob(value);
                                _clearError('dob');
                              },
                              hintText: 'dd/MM/yyyy',
                              errorText: _errors['dob'],
                              keyboardType: TextInputType.datetime,
                              inputFormatters: dateInputFormatters(),
                              suffixIcon: DatePickerButton(
                                controller: _dobController,
                                onPicked: (value) {
                                  controller.setDob(value);
                                  _clearError('dob');
                                },
                              ),
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
                        errorText: _errors['insurance'],
                        inputFormatters: digitsInputFormatters(10),
                        onChanged: (value) {
                          controller.setInsurance(value);
                          _clearError('insurance');
                        },
                      ),
                      const SizedBox(height: Spacing.group),
                      AppTextField(
                        label: l10n.patientPhone,
                        keyboardType: TextInputType.phone,
                        initialValue: form.phoneNumber,
                        errorText: _errors['phone'],
                        inputFormatters: phoneInputFormatters(),
                        onChanged: (value) {
                          controller.setPhoneNumber(value);
                          _clearError('phone');
                        },
                      ),
                      const SizedBox(height: Spacing.group),
                      AppUnitField(
                        label: l10n.patientHeight,
                        unit: 'cm',
                        initialValue: form.heightCm,
                        expanded: true,
                        onChanged: (value) {
                          controller.setHeightCm(value);
                          _clearError('height');
                        },
                      ),
                      if (_errors['height'] != null) ...[
                        const SizedBox(height: Spacing.xxxs),
                        AppText(
                          _errors['height']!,
                          type: AppTextType.caption,
                          color: context.respiraColors.error,
                        ),
                      ],
                      const SizedBox(height: Spacing.group),
                      AppUnitField(
                        label: l10n.patientWeight,
                        unit: 'kg',
                        initialValue: form.weightKg,
                        expanded: true,
                        onChanged: (value) {
                          controller.setWeightKg(value);
                          _clearError('weight');
                        },
                      ),
                      if (_errors['weight'] != null) ...[
                        const SizedBox(height: Spacing.xxxs),
                        AppText(
                          _errors['weight']!,
                          type: AppTextType.caption,
                          color: context.respiraColors.error,
                        ),
                      ],
                      const SizedBox(height: Spacing.group),
                      AppTextField(
                        label: l10n.patientAddress,
                        initialValue: form.address,
                        errorText: _errors['address'],
                        inputFormatters: addressInputFormatters(),
                        onChanged: (value) {
                          controller.setAddress(value);
                          _clearError('address');
                        },
                      ),
                      const SizedBox(height: Spacing.group),
                      AppTextField(
                        label: l10n.patientProvince,
                        initialValue: form.city,
                        errorText: _errors['city'],
                        inputFormatters: addressInputFormatters(max: 100),
                        onChanged: (value) {
                          controller.setCity(value);
                          _clearError('city');
                        },
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
                          onPressed: saving ? null : () => _save(form),
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
