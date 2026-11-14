import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_response.dart';
import '../../../../design_system/design_system.dart';
import '../../../../l10n/l10n.dart';
import '../models/next_of_kin_relationship.dart';
import '../models/patient.dart';
import '../models/patient_dtos.dart';
import '../providers/patient_detail_provider.dart';
import '../services/patient_service.dart';
import '../widgets/next_of_kin_relationship_field.dart';
import '../widgets/section_label_widget.dart';

/// Route `/patient/next-of-kin?patientId=…&kinId=…` — create (no `kinId`) or
/// edit a next of kin of the patient.
class NextOfKinFormScreen extends ConsumerWidget {
  const NextOfKinFormScreen({
    super.key,
    required this.patientId,
    this.nextOfKinId,
  });

  final String? patientId;
  final String? nextOfKinId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = patientId;
    if (id == null || id.isEmpty) {
      return _Shell(
        child: AppText(context.l10n.patientNoSelection, type: AppTextType.caption),
      );
    }

    final l10n = context.l10n;
    return ref.watch(patientDetailProvider(id)).when(
          loading: () => const _Shell(child: CircularProgressIndicator()),
          error: (_, _) => _Shell(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppText(l10n.patientProfileError, type: AppTextType.caption),
                const SizedBox(height: Spacing.control),
                AppButton(
                  label: l10n.commonRetry,
                  type: AppButtonType.outline,
                  size: AppButtonSize.medium,
                  onPressed: () => ref.invalidate(patientDetailProvider(id)),
                ),
              ],
            ),
          ),
          data: (dto) => _NextOfKinForm(
            patient: dto,
            nextOfKinId: nextOfKinId,
          ),
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
      backgroundColor: context.respiraColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Spacing.group),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppAppBar(
                title: l10n.nextOfKinAddTitle,
                subtitle: l10n.nextOfKinSubtitle,
                onBack: () => Navigator.pop(context),
              ),
              Expanded(child: Center(child: child)),
            ],
          ),
        ),
      ),
    );
  }
}

class _NextOfKinForm extends ConsumerStatefulWidget {
  const _NextOfKinForm({required this.patient, this.nextOfKinId});

  final PatientDetailDto patient;
  final String? nextOfKinId;

  @override
  ConsumerState<_NextOfKinForm> createState() => _NextOfKinFormState();
}

class _NextOfKinFormState extends ConsumerState<_NextOfKinForm> {
  static final _phonePattern =
      RegExp(r'^(0[35789]|84[35789]|\+84[35789])\d{8}$');

  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _otherRelationship = TextEditingController();

  NextOfKinRelationship? _relationship;
  bool _saving = false;

  String? _nameError;
  String? _phoneError;
  String? _relationshipError;
  String? _otherError;

  bool get _isEditing => widget.nextOfKinId != null;

  @override
  void initState() {
    super.initState();
    final kinId = widget.nextOfKinId;
    if (kinId == null) return;

    for (final kin in widget.patient.nextOfKins) {
      if (kin.id != kinId) continue;
      _fullName.text = kin.fullName;
      _phone.text = kin.phoneNumber;
      final relationship = nextOfKinRelationshipFrom(kin.relationship);
      _relationship = relationship;
      if (relationship == NextOfKinRelationship.other) {
        _otherRelationship.text = kin.relationship;
      }
      break;
    }
  }

  @override
  void dispose() {
    _fullName.dispose();
    _phone.dispose();
    _otherRelationship.dispose();
    super.dispose();
  }

  String? _resolveRelationship() {
    final relationship = _relationship;
    if (relationship == null) return null;
    if (relationship != NextOfKinRelationship.other) {
      return relationship.storedValue;
    }
    final other = _otherRelationship.text.trim();
    return other.isEmpty ? null : other;
  }

  bool _validate(AppLocalizations l10n) {
    setState(() {
      _nameError = _fullName.text.trim().isEmpty ? l10n.nextOfKinErrName : null;
      _phoneError = _phonePattern.hasMatch(_phone.text.trim())
          ? null
          : l10n.nextOfKinErrPhone;
      _relationshipError =
          _relationship == null ? l10n.nextOfKinErrRelationship : null;
      _otherError =
          _relationship == NextOfKinRelationship.other &&
              _otherRelationship.text.trim().isEmpty
          ? l10n.nextOfKinErrRelationship
          : null;
    });

    return _nameError == null &&
        _phoneError == null &&
        _relationshipError == null &&
        _otherError == null;
  }

  Future<void> _save() async {
    if (_saving) return;
    final l10n = context.l10n;
    if (!_validate(l10n)) return;

    final relationship = _resolveRelationship();
    if (relationship == null) return;

    setState(() => _saving = true);
    try {
      final service = PatientService(ref.read(apiClientProvider));
      if (_isEditing) {
        await service.updateNextOfKin(
          nextOfKinId: widget.nextOfKinId!,
          fullName: _fullName.text.trim(),
          phoneNumber: _phone.text.trim(),
          relationship: relationship,
        );
      } else {
        await service.addNextOfKin(
          patientId: widget.patient.id,
          fullName: _fullName.text.trim(),
          phoneNumber: _phone.text.trim(),
          relationship: relationship,
        );
      }
      if (!mounted) return;

      ref.invalidate(patientDetailProvider(widget.patient.id));
      showAppToast(
        context,
        _isEditing ? l10n.nextOfKinUpdateSuccess : l10n.nextOfKinCreateSuccess,
      );
      Navigator.pop(context);
    } on ApiException catch (e) {
      if (mounted) showAppToast(context, e.message);
    } on DioException catch (e) {
      if (!mounted) return;
      showAppToast(context, dioErrorMessage(e).localizedError(l10n));
    } catch (_) {
      if (!mounted) return;
      showAppToast(
        context,
        _isEditing ? l10n.nextOfKinUpdateFailed : l10n.nextOfKinCreateFailed,
      );
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = context.respiraColors;
    final l10n = context.l10n;
    final patient = widget.patient;
    final gender = patient.gender == 'Male' ? Gender.nam : Gender.nu;

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
                        title: _isEditing
                            ? l10n.nextOfKinEditTitle
                            : l10n.nextOfKinAddTitle,
                        subtitle: l10n.nextOfKinSubtitle,
                        onBack: () => Navigator.pop(context),
                      ),
                      const SizedBox(height: Spacing.block),
                      AppSurface(
                        padding: const EdgeInsets.all(Spacing.group),
                        color: c.surfaceSecondary,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              patient.fullName,
                              type: AppTextType.bodyMedium,
                              fontWeight: FontWeight.w600,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: Spacing.xxxs),
                            AppText(
                              '${patient.medicalRecordCode} · '
                              '${gender.label(l10n)}',
                              type: AppTextType.caption,
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: Spacing.section),
                      SectionLabelWidget(l10n.nextOfKinInfoSection),
                      const SizedBox(height: Spacing.xxs),
                      AppCard(
                        padding: const EdgeInsets.all(Spacing.group),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            AppTextField(
                              label: '${l10n.nextOfKinFullName} *',
                              controller: _fullName,
                              hintText: l10n.nextOfKinFullNameHint,
                              errorText: _nameError,
                              onChanged: (_) {
                                if (_nameError != null) {
                                  setState(() => _nameError = null);
                                }
                              },
                            ),
                            const SizedBox(height: Spacing.group),
                            NextOfKinRelationshipField(
                              selected: _relationship,
                              otherController: _otherRelationship,
                              otherErrorText: _otherError,
                              onOtherChanged: (_) {
                                if (_otherError != null) {
                                  setState(() => _otherError = null);
                                }
                              },
                              onChanged: (relationship) => setState(() {
                                _relationship = relationship;
                                _relationshipError = null;
                                if (relationship !=
                                    NextOfKinRelationship.other) {
                                  _otherError = null;
                                }
                              }),
                            ),
                            if (_relationshipError != null) ...[
                              const SizedBox(height: Spacing.xxs),
                              AppText(
                                _relationshipError!,
                                type: AppTextType.caption,
                                color: c.error,
                              ),
                            ],
                            const SizedBox(height: Spacing.group),
                            AppTextField(
                              label: '${l10n.nextOfKinPhone} *',
                              controller: _phone,
                              hintText: l10n.nextOfKinPhoneHint,
                              keyboardType: TextInputType.phone,
                              errorText: _phoneError,
                              onChanged: (_) {
                                if (_phoneError != null) {
                                  setState(() => _phoneError = null);
                                }
                              },
                            ),
                          ],
                        ),
                      ),
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
                                label: l10n.commonCancel,
                                type: AppButtonType.outline,
                                size: AppButtonSize.medium,
                                onPressed: _saving
                                    ? null
                                    : () => Navigator.pop(context),
                              ),
                            ),
                            const SizedBox(width: Spacing.control),
                            Expanded(
                              child: AppButton(
                                label: _isEditing
                                    ? l10n.nextOfKinUpdate
                                    : l10n.nextOfKinSave,
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
