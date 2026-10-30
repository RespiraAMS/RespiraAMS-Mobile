import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/context_extensions.dart';
import '../../../../design_system/design_system.dart';
import '../../../../core/network/api_response.dart';
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
/// bottom-nav 'Chẩn đoán' tab), saving continues straight into the
/// empirical-treatment progress flow for the just-created patient.
class AddPatientScreen extends ConsumerWidget {
  const AddPatientScreen({super.key, this.diagnosisEntry = false});

  final bool diagnosisEntry;

  static final _phonePattern =
      RegExp(r'^(0[35789]|84[35789]|\+84[35789])\d{8}$');
  static final _insurancePattern = RegExp(r'^\d{10}$');

  String? _validate(AddPatientFormState form) {
    if (form.lastName.trim().isEmpty || form.firstName.trim().isEmpty) {
      return 'Vui lòng nhập họ và tên.';
    }
    if (form.code.trim().isEmpty) {
      return 'Vui lòng nhập mã bệnh án.';
    }
    if (form.dob.trim().isEmpty) {
      return 'Vui lòng nhập ngày sinh.';
    }
    if (ddMmYyyyToIsoDate(form.dob) == null) {
      return 'Ngày sinh không hợp lệ (định dạng dd/MM/yyyy).';
    }
    if (!_phonePattern.hasMatch(form.phoneNumber.trim())) {
      return 'Số điện thoại không hợp lệ.';
    }
    if (!_insurancePattern.hasMatch(form.insurance.trim())) {
      return 'Số thẻ BHYT phải gồm 10 chữ số.';
    }
    if ((double.tryParse(form.heightCm.trim().replaceAll(',', '.')) ?? 0) <= 0) {
      return 'Chiều cao phải lớn hơn 0.';
    }
    if ((double.tryParse(form.weightKg.trim().replaceAll(',', '.')) ?? 0) <= 0) {
      return 'Cân nặng phải lớn hơn 0.';
    }
    if (form.address.trim().isEmpty) {
      return 'Vui lòng nhập địa chỉ.';
    }
    if (form.city.trim().isEmpty) {
      return 'Vui lòng nhập tỉnh/thành phố.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = ref.watch(addPatientControllerProvider);
    final controller = ref.read(addPatientControllerProvider.notifier);
    final saving = ref.watch(addPatientSavingProvider);

    Future<void> save(BuildContext context) async {
      final error = _validate(form);
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
          diagnosisEntry ? PatientRoutes.progress : PatientRoutes.detail,
        );
      } on ApiException catch (e) {
        showAppToast(context, e.message);
      } on DioException catch (e) {
        showAppToast(context, dioErrorMessage(e));
      } catch (_) {
        showAppToast(context, 'Không thể tạo bệnh nhân. Vui lòng thử lại.');
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
                        title: 'Thêm bệnh nhân',
                        subtitle: 'Tạo hồ sơ bệnh nhân mới',
                        onBack: () => context.goBackOr(PatientRoutes.list),
                      ),
                      const SizedBox(height: Spacing.section),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: AppTextField(
                              label: 'Họ',
                              initialValue: form.lastName,
                              onChanged: controller.setLastName,
                            ),
                          ),
                          const SizedBox(width: Spacing.group),
                          Expanded(
                            child: AppTextField(
                              label: 'Tên',
                              initialValue: form.firstName,
                              onChanged: controller.setFirstName,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: Spacing.group),
                      AppTextField(
                        label: 'Mã bệnh án',
                        initialValue: form.code,
                        onChanged: controller.setCode,
                      ),
                      const SizedBox(height: Spacing.group),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: AppTextField(
                              label: 'Ngày sinh',
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
                        label: 'Số thẻ BHYT',
                        keyboardType: TextInputType.number,
                        initialValue: form.insurance,
                        onChanged: controller.setInsurance,
                      ),
                      const SizedBox(height: Spacing.group),
                      AppTextField(
                        label: 'Số điện thoại',
                        keyboardType: TextInputType.phone,
                        initialValue: form.phoneNumber,
                        onChanged: controller.setPhoneNumber,
                      ),
                      const SizedBox(height: Spacing.group),
                      AppUnitField(
                        label: 'Chiều cao',
                        unit: 'cm',
                        initialValue: form.heightCm,
                        onChanged: controller.setHeightCm,
                      ),
                      const SizedBox(height: Spacing.group),
                      AppUnitField(
                        label: 'Cân nặng',
                        unit: 'kg',
                        initialValue: form.weightKg,
                        onChanged: controller.setWeightKg,
                      ),
                      const SizedBox(height: Spacing.group),
                      AppTextField(
                        label: 'Địa chỉ',
                        initialValue: form.address,
                        onChanged: controller.setAddress,
                      ),
                      const SizedBox(height: Spacing.group),
                      AppTextField(
                        label: 'Tỉnh/Thành phố',
                        initialValue: form.city,
                        onChanged: controller.setCity,
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(top: Spacing.block),
                        child: AppButton(
                          label: saving ? 'Đang lưu…' : 'Lưu hồ sơ',
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SectionLabelWidget('Giới tính'),
        const SizedBox(height: Spacing.inline),
        Row(
          children: [
            GenderOptionWidget(
              label: Gender.nam.displayName,
              selected: selected == Gender.nam,
              onTap: () => onSelect(Gender.nam),
            ),
            const SizedBox(width: Spacing.inline),
            GenderOptionWidget(
              label: Gender.nu.displayName,
              selected: selected == Gender.nu,
              onTap: () => onSelect(Gender.nu),
            ),
          ],
        ),
      ],
    );
  }
}
