import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../core/network/api_response.dart';
import '../../../core/utils/context_extensions.dart';
import '../../../core/utils/name_initials.dart';
import '../../../design_system/design_system.dart';
import '../../../l10n/l10n.dart';
import '../../patient/models/patient.dart';
import '../../patient/routes.dart';
import '../../patient/widgets/gender_option_widget.dart';
import '../models/doctor_profile_options.dart';
import '../models/new_password_form_state.dart';
import '../providers/current_doctor_provider.dart';
import '../providers/session_provider.dart';
import '../services/auth_service.dart';
import '../services/doctor_service.dart';
import '../services/profile_update_service.dart';

/// Route `/doctor/profile/edit` — editable doctor profile (personal, contact,
/// professional + avatar and optional password change).
///
/// Saving runs the update saga (`POST /profile/update`); the payload is a full
/// replacement of the profile, so every field is pre-filled from [doctor].
class DoctorProfileEditScreen extends ConsumerWidget {
  const DoctorProfileEditScreen({super.key, this.doctor});

  /// Profile passed by the read-only screen through `GoRouterState.extra`.
  /// Falls back to [currentDoctorProvider] when opened without it.
  final DoctorProfileDto? doctor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final passed = doctor;
    if (passed != null) return _EditForm(doctor: passed);

    return ref.watch(currentDoctorProvider).when(
          loading: () => const _StateScaffold(
            child: CircularProgressIndicator(),
          ),
          error: (_, _) => _StateScaffold(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppText(
                  context.l10n.doctorProfileError,
                  type: AppTextType.caption,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: Spacing.block),
                AppButton(
                  label: context.l10n.doctorProfileRetry,
                  type: AppButtonType.outline,
                  onPressed: () => ref.invalidate(currentDoctorProvider),
                ),
              ],
            ),
          ),
          data: (dto) => dto == null
              ? _StateScaffold(
                  child: AppText(
                    context.l10n.doctorProfileEmpty,
                    type: AppTextType.caption,
                    textAlign: TextAlign.center,
                  ),
                )
              : _EditForm(doctor: dto),
        );
  }
}

class _EditForm extends ConsumerStatefulWidget {
  const _EditForm({required this.doctor});

  final DoctorProfileDto doctor;

  @override
  ConsumerState<_EditForm> createState() => _EditFormState();
}

class _EditFormState extends ConsumerState<_EditForm> {
  static const _maxAvatarBytes = 5 * 1024 * 1024;
  static const _allowedAvatarExtensions = {'.jpg', '.jpeg', '.png', '.webp'};
  static final _emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
  static final _phoneRegex =
      RegExp(r'^(0[35789]|84[35789]|\+84[35789])\d{8}$');
  static final _citizenIdRegex = RegExp(r'^\d{9,12}$');

  late String _firstName;
  late String _lastName;
  late String _email;
  late String _phone;
  late String _citizenId;
  late String _address;
  late String _dob;
  late DoctorGender? _gender;
  late DoctorAcademicTitle _academicTitle;
  late DoctorPosition _position;
  late Set<DoctorDegree> _degrees;
  String _newPassword = '';
  String _confirmPassword = '';

  Uint8List? _avatarBytes;
  String? _avatarFileName;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final doctor = widget.doctor;
    _firstName = doctor.firstName;
    _lastName = doctor.lastName;
    _email = doctor.email ?? '';
    _phone = doctor.phone ?? '';
    _citizenId = doctor.citizenIdentificationNumber ?? '';
    _address = doctor.address ?? '';
    _dob = doctor.dateOfBirth == null
        ? ''
        : isoDateToDdMmYyyy(doctor.dateOfBirth!);
    _gender = DoctorGender.fromWire(doctor.gender);
    _academicTitle =
        DoctorAcademicTitle.fromWire(doctor.academicTitle) ??
            DoctorAcademicTitle.none;
    _position =
        DoctorPosition.fromWire(doctor.position) ?? DoctorPosition.staffDoctor;
    _degrees = doctor.degrees
        .map(DoctorDegree.fromWire)
        .whereType<DoctorDegree>()
        .toSet();
  }

  String get _displayName {
    final name = [_firstName.trim(), _lastName.trim()]
        .where((part) => part.isNotEmpty)
        .join(' ');
    return name.isEmpty ? widget.doctor.fullName : name;
  }

  Future<void> _pickAvatar() async {
    final l10n = context.l10n;
    try {
      final file = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );
      if (file == null) return;

      final name = file.name.toLowerCase();
      final dot = name.lastIndexOf('.');
      final extension = dot == -1 ? '' : name.substring(dot);
      if (extension.isNotEmpty &&
          !_allowedAvatarExtensions.contains(extension)) {
        if (mounted) showAppToast(context, l10n.doctorProfileAvatarInvalid);
        return;
      }

      final bytes = await file.readAsBytes();
      if (bytes.length > _maxAvatarBytes) {
        if (mounted) showAppToast(context, l10n.doctorProfileAvatarTooLarge);
        return;
      }

      if (!mounted) return;
      setState(() {
        _avatarBytes = bytes;
        _avatarFileName =
            extension.isEmpty ? 'avatar.jpg' : file.name;
      });
    } catch (_) {
      if (mounted) showAppToast(context, l10n.doctorProfileAvatarInvalid);
    }
  }

  Future<void> _pickAcademicTitle() async {
    final l10n = context.l10n;
    final selected = await _showOptionSheet<DoctorAcademicTitle>(
      title: l10n.doctorProfileAcademicTitle,
      values: DoctorAcademicTitle.values,
      labelOf: (value) => value.label(l10n),
      selected: _academicTitle,
    );
    if (selected != null) setState(() => _academicTitle = selected);
  }

  Future<void> _pickPosition() async {
    final l10n = context.l10n;
    final selected = await _showOptionSheet<DoctorPosition>(
      title: l10n.doctorProfilePosition,
      values: DoctorPosition.values,
      labelOf: (value) => value.label(l10n),
      selected: _position,
    );
    if (selected != null) setState(() => _position = selected);
  }

  Future<T?> _showOptionSheet<T>({
    required String title,
    required List<T> values,
    required String Function(T value) labelOf,
    required T selected,
  }) {
    final c = context.respiraColors;
    return showModalBottomSheet<T>(
      context: context,
      backgroundColor: c.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(Spacing.group),
              child: AppText(
                title,
                type: AppTextType.h3,
                fontWeight: FontWeight.bold,
              ),
            ),
            Flexible(
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                children: [
                  for (final value in values)
                    ListTile(
                      title: AppText(
                        labelOf(value),
                        type: AppTextType.body,
                        color: c.textPrimary,
                      ),
                      trailing: value == selected
                          ? Icon(LucideIcons.check, color: c.primary)
                          : null,
                      onTap: () => Navigator.pop(context, value),
                    ),
                ],
              ),
            ),
            const SizedBox(height: Spacing.group),
          ],
        ),
      ),
    );
  }

  String? _validate(AppLocalizations l10n) {
    if (_firstName.trim().isEmpty || _lastName.trim().isEmpty) {
      return l10n.doctorProfileErrRequired;
    }
    if (!_emailRegex.hasMatch(_email.trim())) {
      return l10n.doctorProfileErrEmail;
    }
    if (!_phoneRegex.hasMatch(_phone.trim())) {
      return l10n.patientErrPhone;
    }
    if (!_citizenIdRegex.hasMatch(_citizenId.trim())) {
      return l10n.doctorProfileErrRequired;
    }
    if (_address.trim().isEmpty) {
      return l10n.doctorProfileErrRequired;
    }
    if (_dob.trim().isNotEmpty && ddMmYyyyToIsoDate(_dob.trim()) == null) {
      return l10n.patientErrDobFormat;
    }
    if (_gender == null) {
      return l10n.doctorProfileErrRequired;
    }

    if (_newPassword.isNotEmpty || _confirmPassword.isNotEmpty) {
      final form = NewPasswordFormState(
        password: _newPassword,
        confirmPassword: _confirmPassword,
      );
      if (!form.allRulesMet) return l10n.doctorProfilePasswordWeak;
      if (!form.passwordsMatch) return l10n.doctorProfilePasswordMismatch;
    }

    return null;
  }

  Future<void> _save() async {
    final l10n = context.l10n;
    final error = _validate(l10n);
    if (error != null) {
      showAppToast(context, error);
      return;
    }

    final doctor = widget.doctor;
    final payload = ProfileUpdatePayload(
      accountId: doctor.accountId,
      doctorId: doctor.id,
      email: _email.trim(),
      phone: _phone.trim(),
      password: _newPassword.isEmpty ? null : _newPassword,
      firstName: _firstName.trim(),
      lastName: _lastName.trim(),
      degrees: _degrees.toList(),
      academicTitle: _academicTitle,
      position: _position,
      gender: _gender!,
      citizenIdentificationNumber: _citizenId.trim(),
      dateOfBirth: _dob.trim().isEmpty
          ? null
          : ddMmYyyyToIsoDate(_dob.trim()),
      address: _address.trim(),
    );

    setState(() => _saving = true);
    try {
      final service = ref.read(profileUpdateServiceProvider);
      final sagaId = await service.start(
        payload: payload,
        avatarBytes: _avatarBytes,
        avatarFileName: _avatarFileName,
      );
      await service.waitUntilFinished(sagaId);

      final updated = await _refetchProfile(payload);
      if (!_matchesPayload(updated, payload)) {
        throw const _UpdateNotAppliedException();
      }

      ref.invalidate(currentDoctorProvider);
      await ref.read(sessionControllerProvider.notifier).updateIdentity(
            displayName: updated.fullName,
            avatarUrl: updated.avatarUrl,
          );

      if (payload.password != null) {
        // Best-effort: rotate the tokens right away so the authentication
        // service drops its cached account entry and the new password is
        // valid immediately (instead of after the 5-minute cache TTL).
        await ref.read(authServiceProvider).refreshSession();
      }

      if (!mounted) return;
      showAppToast(context, l10n.doctorProfileSaveSuccess);
      context.pop();
    } on ProfileUpdateTimeoutException {
      if (mounted) showAppToast(context, l10n.doctorProfileSaveTimeout);
    } on ApiException catch (e) {
      if (mounted) showAppToast(context, e.message);
    } on DioException catch (e) {
      if (!mounted) return;
      if (e.response?.statusCode == 403) {
        showAppToast(context, l10n.doctorProfileSaveForbidden);
        return;
      }
      showAppToast(context, dioErrorMessage(e).localizedError(l10n));
    } catch (_) {
      if (mounted) showAppToast(context, l10n.doctorProfileSaveFailed);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  /// The saga is deleted once it finishes, so completion is verified by
  /// re-fetching the profile (retrying briefly for read-after-write lag).
  ///
  /// The by-id endpoint does not enrich account-level fields (email, phone,
  /// avatar), so the roster endpoint is preferred here.
  Future<DoctorProfileDto> _refetchProfile(
    ProfileUpdatePayload payload,
  ) async {
    final service = ref.read(doctorServiceProvider);

    Future<DoctorProfileDto> fetch() async {
      final enriched =
          await service.findByAccountId(widget.doctor.accountId);
      return enriched ?? service.getDoctor(widget.doctor.id);
    }

    var latest = await fetch();
    for (var attempt = 0; attempt < 10; attempt++) {
      if (_matchesPayload(latest, payload)) break;
      await Future<void>.delayed(const Duration(milliseconds: 600));
      latest = await fetch();
    }
    return latest;
  }

  bool _matchesPayload(DoctorProfileDto doctor, ProfileUpdatePayload payload) {
    if (doctor.firstName.trim() != payload.firstName) return false;
    if (doctor.lastName.trim() != payload.lastName) return false;

    // Account-level fields are only present on the enriched roster response;
    // compare them when available and rely on the profile fields otherwise.
    final email = doctor.email?.trim();
    if (email != null && email.isNotEmpty && email != payload.email) {
      return false;
    }
    final phone = doctor.phone?.trim();
    if (phone != null && phone.isNotEmpty && phone != payload.phone) {
      return false;
    }
    final citizenId = doctor.citizenIdentificationNumber?.trim();
    if (citizenId != null &&
        citizenId.isNotEmpty &&
        citizenId != payload.citizenIdentificationNumber) {
      return false;
    }
    return true;
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppAppBar(
                  title: l10n.doctorProfileEditTitle,
                  subtitle: l10n.doctorProfileEditSubtitle,
                  onBack: () => context.goBackOr(PatientRoutes.list),
                ),
                const SizedBox(height: Spacing.block),
                _buildAvatar(context),
                const SizedBox(height: Spacing.section),
                _SectionHeader(l10n.doctorProfileSectionPersonal),
                const SizedBox(height: Spacing.xxs),
                AppCard(
                  padding: const EdgeInsets.all(Spacing.group),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AppTextField(
                        label: '${l10n.patientLastName}$requiredMark',
                        initialValue: _lastName,
                        textInputAction: TextInputAction.next,
                        onChanged: (value) => _lastName = value,
                      ),
                      const SizedBox(height: Spacing.group),
                      AppTextField(
                        label: '${l10n.patientFirstName}$requiredMark',
                        initialValue: _firstName,
                        textInputAction: TextInputAction.next,
                        onChanged: (value) => _firstName = value,
                      ),
                      const SizedBox(height: Spacing.group),
                      AppTextField(
                        label: l10n.doctorProfileDob,
                        initialValue: _dob,
                        hintText: 'dd/MM/yyyy',
                        keyboardType: TextInputType.datetime,
                        textInputAction: TextInputAction.next,
                        onChanged: (value) => _dob = value,
                      ),
                      const SizedBox(height: Spacing.group),
                      AppText(
                        l10n.doctorProfileGender,
                        type: AppTextType.label,
                        color: c.textPrimary,
                      ),
                      const SizedBox(height: Spacing.inline),
                      Row(
                        children: [
                          GenderOptionWidget(
                            label: l10n.genderMale,
                            selected: _gender == DoctorGender.male,
                            onTap: () => setState(
                              () => _gender = DoctorGender.male,
                            ),
                          ),
                          const SizedBox(width: Spacing.control),
                          GenderOptionWidget(
                            label: l10n.genderFemale,
                            selected: _gender == DoctorGender.female,
                            onTap: () => setState(
                              () => _gender = DoctorGender.female,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: Spacing.group),
                      AppTextField(
                        label: '${l10n.doctorProfileCitizenId}$requiredMark',
                        initialValue: _citizenId,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        onChanged: (value) => _citizenId = value,
                      ),
                      const SizedBox(height: Spacing.group),
                      AppTextField(
                        label: '${l10n.doctorProfileAddress}$requiredMark',
                        initialValue: _address,
                        maxLines: 2,
                        minLines: 2,
                        textInputAction: TextInputAction.newline,
                        onChanged: (value) => _address = value,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: Spacing.section),
                _SectionHeader(l10n.doctorProfileSectionContact),
                const SizedBox(height: Spacing.xxs),
                AppCard(
                  padding: const EdgeInsets.all(Spacing.group),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AppTextField(
                        label: '${l10n.doctorProfileEmail}$requiredMark',
                        initialValue: _email,
                        helperText: l10n.doctorProfileEmailHint,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        onChanged: (value) => _email = value,
                      ),
                      const SizedBox(height: Spacing.group),
                      AppTextField(
                        label: '${l10n.doctorProfilePhone}$requiredMark',
                        initialValue: _phone,
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.next,
                        onChanged: (value) => _phone = value,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: Spacing.section),
                _SectionHeader(l10n.doctorProfileSectionProfessional),
                const SizedBox(height: Spacing.xxs),
                AppCard(
                  padding: const EdgeInsets.all(Spacing.group),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _PickerField(
                        label: l10n.doctorProfileAcademicTitle,
                        value: _academicTitle.label(l10n),
                        onTap: _pickAcademicTitle,
                      ),
                      const SizedBox(height: Spacing.group),
                      _PickerField(
                        label: l10n.doctorProfilePosition,
                        value: _position.label(l10n),
                        onTap: _pickPosition,
                      ),
                      const SizedBox(height: Spacing.group),
                      AppText(
                        l10n.doctorProfileDegrees,
                        type: AppTextType.label,
                        color: c.textPrimary,
                      ),
                      const SizedBox(height: Spacing.inline),
                      Wrap(
                        spacing: Spacing.xxs,
                        runSpacing: Spacing.xxs,
                        children: [
                          for (final degree in DoctorDegree.values)
                            _DegreeChip(
                              label: degree.label(l10n),
                              selected: _degrees.contains(degree),
                              onTap: () => setState(() {
                                if (!_degrees.remove(degree)) {
                                  _degrees.add(degree);
                                }
                              }),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: Spacing.section),
                _SectionHeader(l10n.doctorProfileSectionSecurity),
                const SizedBox(height: Spacing.xxs),
                AppCard(
                  padding: const EdgeInsets.all(Spacing.group),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AppTextField(
                        label: l10n.doctorProfileNewPassword,
                        helperText: l10n.doctorProfilePasswordHint,
                        obscureText: true,
                        textInputAction: TextInputAction.next,
                        onChanged: (value) => setState(
                          () => _newPassword = value,
                        ),
                      ),
                      const SizedBox(height: Spacing.group),
                      AppTextField(
                        label: l10n.doctorProfileConfirmPassword,
                        obscureText: true,
                        textInputAction: TextInputAction.done,
                        onChanged: (value) => setState(
                          () => _confirmPassword = value,
                        ),
                      ),
                      if (_confirmPassword.isNotEmpty &&
                          _newPassword != _confirmPassword) ...[
                        const SizedBox(height: Spacing.control),
                        AppText(
                          l10n.doctorProfilePasswordMismatch,
                          type: AppTextType.caption,
                          color: c.error,
                        ),
                      ] else if (_newPassword.isNotEmpty &&
                          !NewPasswordFormState(
                            password: _newPassword,
                            confirmPassword: _confirmPassword,
                          ).allRulesMet) ...[
                        const SizedBox(height: Spacing.control),
                        AppText(
                          l10n.doctorProfilePasswordWeak,
                          type: AppTextType.caption,
                          color: c.error,
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: Spacing.section),
                AppButton(
                  label: _saving
                      ? l10n.doctorProfileSaving
                      : l10n.doctorProfileSave,
                  expand: true,
                  loading: _saving,
                  onPressed: _saving ? null : _save,
                ),
                const SizedBox(height: Spacing.screen),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar(BuildContext context) {
    final c = context.respiraColors;
    final l10n = context.l10n;
    final bytes = _avatarBytes;

    final avatar = bytes != null
        ? Container(
            width: 96,
            height: 96,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: c.borderDefault),
            ),
            child: Image.memory(
              bytes,
              width: 96,
              height: 96,
              fit: BoxFit.cover,
              gaplessPlayback: true,
            ),
          )
        : AvatarGlyphWidget(
            glyph: initialsFor(_displayName),
            size: 96,
            imageUrl: widget.doctor.avatarUrl,
          );

    return Column(
      children: [
        GestureDetector(
          onTap: _saving ? null : _pickAvatar,
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              avatar,
              Container(
                width: 32,
                height: 32,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: c.primary,
                  shape: BoxShape.circle,
                  border: Border.all(color: c.background, width: 2),
                ),
                child: Icon(
                  LucideIcons.camera,
                  size: 16,
                  color: c.onPrimary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: Spacing.control),
        AppButton(
          label: l10n.doctorProfileAvatarChange,
          type: AppButtonType.ghost,
          size: AppButtonSize.small,
          onPressed: _saving ? null : _pickAvatar,
        ),
        const SizedBox(height: Spacing.xxs),
        AppText(
          l10n.doctorProfileAvatarHint,
          type: AppTextType.caption,
          color: c.textSecondary,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

/// Label + tappable value box opening an option sheet (title/position).
class _PickerField extends StatelessWidget {
  const _PickerField({
    required this.label,
    required this.value,
    required this.onTap,
  });

  final String label;
  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.respiraColors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: TypographyTokens.label(context).copyWith(color: c.textPrimary),
        ),
        const SizedBox(height: Spacing.inline),
        Material(
          color: c.surface,
          borderRadius: AppRadius.md,
          child: InkWell(
            onTap: onTap,
            borderRadius: AppRadius.md,
            child: Container(
              height: ControlSize.inputDefault,
              padding: const EdgeInsets.symmetric(horizontal: Spacing.group),
              decoration: BoxDecoration(
                borderRadius: AppRadius.md,
                border: Border.all(color: c.borderSubtle),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: AppText(
                      value,
                      type: AppTextType.body,
                      color: c.textPrimary,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(LucideIcons.chevronDown, color: c.iconDefault, size: 20),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _DegreeChip extends StatelessWidget {
  const _DegreeChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.respiraColors;

    return ChoiceChip(
      label: AppText(
        label,
        type: AppTextType.label,
        color: selected ? c.onPrimary : c.textPrimary,
      ),
      selected: selected,
      onSelected: (_) => onTap(),
      selectedColor: c.primary,
      backgroundColor: c.surface,
      showCheckmark: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: selected ? c.primary : c.borderSubtle),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppText(
      title,
      type: AppTextType.label,
      color: context.respiraColors.textPrimary,
    );
  }
}

/// Loading / error / empty shell used when the profile is not passed in.
class _StateScaffold extends StatelessWidget {
  const _StateScaffold({required this.child});

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
                title: l10n.doctorProfileEditTitle,
                subtitle: l10n.doctorProfileEditSubtitle,
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

/// Internal marker: the saga finished but the profile does not reflect the
/// submitted values (i.e. the run failed).
class _UpdateNotAppliedException implements Exception {
  const _UpdateNotAppliedException();
}
