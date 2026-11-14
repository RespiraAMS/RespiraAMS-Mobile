import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_response.dart';
import '../../../../core/utils/context_extensions.dart';
import '../../../../design_system/design_system.dart';
import '../../../../l10n/l10n.dart';
import '../models/patient.dart';
import '../models/patient_dtos.dart';
import '../providers/active_patient_provider.dart';
import '../providers/patient_detail_provider.dart';
import '../providers/patient_list_provider.dart';
import '../routes.dart';
import '../services/patient_service.dart';
import '../widgets/gender_option_widget.dart';
import '../widgets/section_label_widget.dart';

/// Route `/patient/edit?id=…` — edit-demographics form (separate from
/// `AddPatientScreen`).
///
/// Saves with `PUT /patients/{id}`. Clinical fields (date of birth, gender,
/// height, weight) are locked once the patient has a treatment plan: the
/// backend silently ignores them in that case, so the UI mirrors the rule.
class EditPatientScreen extends ConsumerWidget {
  const EditPatientScreen({super.key, required this.patientId});

  final String? patientId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = patientId;
    if (id == null || id.isEmpty) {
      return _Shell(child: AppText(context.l10n.patientNoSelection));
    }

    final l10n = context.l10n;
    return ref.watch(patientDetailProvider(id)).when(
          loading: () => const _Shell(child: CircularProgressIndicator()),
          error: (_, _) => _Shell(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppText(l10n.patientEditLoadFailed),
                const SizedBox(height: Spacing.control),
                AppButton(
                  label: l10n.commonRetry,
                  size: AppButtonSize.medium,
                  type: AppButtonType.outline,
                  onPressed: () => ref.invalidate(patientDetailProvider(id)),
                ),
              ],
            ),
          ),
          data: (dto) => _EditPatientForm(patientId: id, dto: dto),
        );
  }
}

class _Shell extends StatelessWidget {
  const _Shell({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Spacing.group),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppAppBar(
                title: l10n.patientEditTitle,
                subtitle: l10n.patientEditSubtitle,
                onBack: () => context.goBackOr(PatientRoutes.list),
              ),
              Expanded(child: Center(child: child)),
            ],
          ),
        ),
      ),
    );
  }
}

class _EditPatientForm extends ConsumerStatefulWidget {
  const _EditPatientForm({required this.patientId, required this.dto});

  final String patientId;
  final PatientDetailDto dto;

  @override
  ConsumerState<_EditPatientForm> createState() => _EditPatientFormState();
}

class _EditPatientFormState extends ConsumerState<_EditPatientForm> {
  static final _phonePattern =
      RegExp(r'^(0[35789]|84[35789]|\+84[35789])\d{8}$');
  static final _insurancePattern = RegExp(r'^\d{10}$');

  late String _name;
  late String _recordCode;
  late String _dob;
  late String _insurance;
  late String _phone;
  late String _address;
  late String _city;
  late String _height;
  late String _weight;
  late Gender _gender;

  bool _saving = false;

  /// Clinical fields are immutable once the patient has a treatment plan.
  bool get _clinicalLocked => widget.dto.treatmentPlans.isNotEmpty;

  @override
  void initState() {
    super.initState();
    final dto = widget.dto;
    _name = dto.fullName;
    _recordCode = dto.medicalRecordCode;
    _dob = isoDateToDdMmYyyy(dto.dateOfBirth);
    _insurance = dto.healthInsuranceCard;
    _phone = dto.phoneNumber;
    _address = dto.address;
    _city = dto.city;
    _height = _formatNumber(dto.height);
    _weight = _formatNumber(dto.weight);
    _gender = dto.gender == 'Female' ? Gender.nu : Gender.nam;
  }

  static String _formatNumber(double value) {
    if (value == value.roundToDouble()) return value.toStringAsFixed(0);
    return value.toString();
  }

  String? _validate(AppLocalizations l10n) {
    if (_name.trim().split(RegExp(r'\s+')).length < 2) {
      return l10n.patientErrName;
    }
    if (_recordCode.trim().isEmpty) return l10n.patientErrCode;
    if (_dob.trim().isEmpty) return l10n.patientErrDob;
    if (ddMmYyyyToIsoDate(_dob) == null) return l10n.patientErrDobFormat;
    if (!_phonePattern.hasMatch(_phone.trim())) return l10n.patientErrPhone;
    if (!_insurancePattern.hasMatch(_insurance.trim())) {
      return l10n.patientErrInsurance;
    }
    if ((double.tryParse(_height.replaceAll(',', '.')) ?? 0) <= 0) {
      return l10n.patientErrHeight;
    }
    if ((double.tryParse(_weight.replaceAll(',', '.')) ?? 0) <= 0) {
      return l10n.patientErrWeight;
    }
    if (_address.trim().isEmpty) return l10n.patientErrAddress;
    if (_city.trim().isEmpty) return l10n.patientErrCity;
    return null;
  }

  /// "Họ và tên" → (`LastName`, `FirstName`) with the Vietnamese convention:
  /// the first word is the family name, the rest is the given name.
  static (String, String) _splitFullName(String fullName) {
    final words = fullName
        .trim()
        .split(RegExp(r'\s+'))
        .where((word) => word.isNotEmpty)
        .toList();
    if (words.length < 2) return (words.isEmpty ? '' : words.first, '');
    return (words.first, words.skip(1).join(' '));
  }

  Future<void> _save() async {
    if (_saving) return;
    final l10n = context.l10n;

    final error = _validate(l10n);
    if (error != null) {
      showAppToast(context, error);
      return;
    }

    final (lastName, firstName) = _splitFullName(_name);
    final height = double.tryParse(_height.replaceAll(',', '.')) ?? 0;
    final weight = double.tryParse(_weight.replaceAll(',', '.')) ?? 0;

    setState(() => _saving = true);
    try {
      await PatientService(ref.read(apiClientProvider)).updatePatient(
        id: widget.patientId,
        firstName: firstName,
        lastName: lastName,
        phoneNumber: _phone.trim(),
        dateOfBirth: ddMmYyyyToIsoDate(_dob)!,
        gender: _gender == Gender.nam ? 'Male' : 'Female',
        height: height,
        weight: weight,
        medicalRecordCode: _recordCode.trim(),
        healthInsuranceCard: _insurance.trim(),
        address: _address.trim(),
        city: _city.trim(),
      );
      if (!mounted) return;

      // Mirror the edit into the active patient so detail/progress screens
      // reflect it immediately.
      final active = ref.read(activePatientControllerProvider);
      if (active?.id == widget.patientId) {
        ref.read(activePatientControllerProvider.notifier).set(
              Patient(
                id: widget.patientId,
                name: '${lastName.trim()} ${firstName.trim()}'.trim(),
                code: _recordCode.trim(),
                dob: _dob.trim(),
                gender: _gender,
                insurance: _insurance.trim(),
                address: _address.trim(),
                heightCm: height > 0 ? height : null,
                weightKg: weight > 0 ? weight : null,
              ),
            );
      }
      ref.invalidate(patientDetailProvider(widget.patientId));
      ref.read(patientListControllerProvider.notifier).refresh();

      showAppToast(context, l10n.patientEditSuccess);
      context.pop();
    } on ApiException catch (e) {
      if (mounted) showAppToast(context, e.message);
    } on DioException catch (e) {
      if (!mounted) return;
      showAppToast(context, dioErrorMessage(e).localizedError(l10n));
    } catch (_) {
      if (!mounted) return;
      showAppToast(context, l10n.patientEditFailed);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = context.respiraColors;
    final l10n = context.l10n;
    const requiredMark = ' *';

    return Scaffold(
      backgroundColor: c.background,
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
                        title: l10n.patientEditTitle,
                        subtitle: l10n.patientEditSubtitle,
                        onBack: () => context.goBackOr(PatientRoutes.list),
                      ),
                      const SizedBox(height: Spacing.block),
                      PatientHeader(
                        name: widget.dto.fullName,
                        metadata: widget.dto.medicalRecordCode,
                        avatarGlyph: _gender == Gender.nam ? '👨🏻' : '👩🏾',
                      ),
                      const SizedBox(height: Spacing.section),
                      _SectionHeader(
                        title: l10n.patientSectionAdmin,
                        trailing: l10n.patientRequiredHint,
                      ),
                      const SizedBox(height: Spacing.xxs),
                      AppCard(
                        padding: const EdgeInsets.all(Spacing.group),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            AppTextField(
                              label: '${l10n.patientFullName}$requiredMark',
                              initialValue: _name,
                              onChanged: (value) => _name = value,
                            ),
                            const SizedBox(height: Spacing.group),
                            AppTextField(
                              label: '${l10n.patientRecordCode}$requiredMark',
                              initialValue: _recordCode,
                              hintText: l10n.patientRecordCodeHint,
                              onChanged: (value) => _recordCode = value,
                            ),
                            const SizedBox(height: Spacing.group),
                            AppTextField(
                              label: '${l10n.patientDob}$requiredMark',
                              initialValue: _dob,
                              hintText: 'dd/MM/yyyy',
                              keyboardType: TextInputType.datetime,
                              enabled: !_clinicalLocked,
                              onChanged: (value) => _dob = value,
                            ),
                            const SizedBox(height: Spacing.group),
                            _GenderField(
                              selected: _gender,
                              enabled: !_clinicalLocked,
                              onSelect: (gender) =>
                                  setState(() => _gender = gender),
                            ),
                            const SizedBox(height: Spacing.group),
                            AppTextField(
                              label: l10n.patientInsuranceCard,
                              initialValue: _insurance,
                              keyboardType: TextInputType.number,
                              onChanged: (value) => _insurance = value,
                            ),
                            const SizedBox(height: Spacing.group),
                            AppTextField(
                              label: '${l10n.patientPhone}$requiredMark',
                              initialValue: _phone,
                              keyboardType: TextInputType.phone,
                              onChanged: (value) => _phone = value,
                            ),
                            const SizedBox(height: Spacing.group),
                            AppTextField(
                              label: '${l10n.patientAddress}$requiredMark',
                              initialValue: _address,
                              onChanged: (value) => _address = value,
                            ),
                            const SizedBox(height: Spacing.group),
                            AppTextField(
                              label: '${l10n.patientProvince}$requiredMark',
                              initialValue: _city,
                              onChanged: (value) => _city = value,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: Spacing.section),
                      _SectionHeader(title: l10n.patientSectionVitals),
                      const SizedBox(height: Spacing.xxs),
                      AppCard(
                        padding: const EdgeInsets.all(Spacing.group),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            AppUnitField(
                              label: l10n.patientWeight,
                              unit: 'kg',
                              initialValue: _weight,
                              enabled: !_clinicalLocked,
                              expanded: true,
                              onChanged: (value) => _weight = value,
                            ),
                            const SizedBox(height: Spacing.group),
                            AppUnitField(
                              label: l10n.patientHeight,
                              unit: 'cm',
                              initialValue: _height,
                              enabled: !_clinicalLocked,
                              expanded: true,
                              onChanged: (value) => _height = value,
                            ),
                          ],
                        ),
                      ),
                      if (_clinicalLocked) ...[
                        const SizedBox(height: Spacing.control),
                        ClinicalAlert(
                          severity: ClinicalSeverity.info,
                          title: l10n.patientEditClinicalLocked,
                        ),
                      ],
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: Spacing.block,
                          bottom: Spacing.lg,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: AppButton(
                                label: l10n.patientEditCancel,
                                type: AppButtonType.outline,
                                size: AppButtonSize.medium,
                                onPressed: _saving
                                    ? null
                                    : () =>
                                        context.goBackOr(PatientRoutes.list),
                              ),
                            ),
                            const SizedBox(width: Spacing.control),
                            Expanded(
                              child: AppButton(
                                label: l10n.patientEditSave,
                                size: AppButtonSize.medium,
                                loading: _saving,
                                onPressed: _saving ? null : _save,
                              ),
                            ),
                          ],
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

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, this.trailing});

  final String title;
  final String? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: SectionLabelWidget(title)),
        if (trailing != null)
          AppText(trailing!, type: AppTextType.caption, maxLines: 1),
      ],
    );
  }
}

class _GenderField extends StatelessWidget {
  const _GenderField({
    required this.selected,
    required this.enabled,
    required this.onSelect,
  });

  final Gender selected;
  final bool enabled;
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
        Opacity(
          opacity: enabled ? 1 : 0.6,
          child: Row(
            children: [
              GenderOptionWidget(
                label: Gender.nam.label(l10n),
                selected: selected == Gender.nam,
                onTap: () {
                  if (enabled) onSelect(Gender.nam);
                },
              ),
              const SizedBox(width: Spacing.inline),
              GenderOptionWidget(
                label: Gender.nu.label(l10n),
                selected: selected == Gender.nu,
                onTap: () {
                  if (enabled) onSelect(Gender.nu);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
