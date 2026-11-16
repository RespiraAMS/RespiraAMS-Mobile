import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../core/utils/context_extensions.dart';
import '../../../core/utils/name_initials.dart';
import '../../../design_system/design_system.dart';
import '../../../l10n/l10n.dart';
import '../../patient/models/patient.dart';
import '../../patient/routes.dart';
import '../models/doctor_profile_options.dart';
import '../providers/current_doctor_provider.dart';
import '../routes.dart';
import '../services/doctor_service.dart';

/// Route `/doctor/profile` — read-only profile of the signed-in doctor.
///
/// Opened from the name at the top of the settings sheet. Resolves the
/// profile through the account-id bridge (`GET /doctors`) and keeps the
/// result alive for the session.
class DoctorProfileScreen extends ConsumerWidget {
  const DoctorProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;

    return ref.watch(currentDoctorProvider).when(
          loading: () => const _StateScaffold(
            child: CircularProgressIndicator(),
          ),
          error: (_, _) => _StateScaffold(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppText(
                  l10n.doctorProfileError,
                  type: AppTextType.caption,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: Spacing.block),
                AppButton(
                  label: l10n.doctorProfileRetry,
                  type: AppButtonType.outline,
                  onPressed: () => ref.invalidate(currentDoctorProvider),
                ),
              ],
            ),
          ),
          data: (doctor) => doctor == null
              ? _StateScaffold(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppText(
                        l10n.doctorProfileEmpty,
                        type: AppTextType.caption,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: Spacing.block),
                      AppButton(
                        label: l10n.doctorProfileRetry,
                        type: AppButtonType.outline,
                        onPressed: () =>
                            ref.invalidate(currentDoctorProvider),
                      ),
                    ],
                  ),
                )
              : _ProfileView(doctor: doctor),
        );
  }
}

class _ProfileView extends StatelessWidget {
  const _ProfileView({required this.doctor});

  final DoctorProfileDto doctor;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final name = doctor.fullName.trim().isNotEmpty
        ? doctor.fullName.trim()
        : l10n.settingsDoctorFallback;
    final academicTitle = _academicTitleLabel(doctor.academicTitle, l10n);
    final position = _positionLabel(doctor.position, l10n);
    final headline = [academicTitle, position]
        .whereType<String>()
        .map((part) => part.trim())
        .where((part) => part.isNotEmpty)
        .join(' · ');
    final degrees = doctor.degrees
        .map((part) => _degreeLabel(part, l10n))
        .whereType<String>()
        .join(', ');
    final gender = _genderLabel(doctor.gender, l10n);
    final role = _roleLabel(doctor.role, l10n);
    final citizenId = _maskCitizenId(doctor.citizenIdentificationNumber);
    final dateOfBirth = _dateOfBirthLabel(doctor.dateOfBirth);

    final professional = <Widget>[
      if (academicTitle != null)
        _InfoRow(
          label: l10n.doctorProfileAcademicTitle,
          value: academicTitle,
        ),
      if (degrees.isNotEmpty)
        _InfoRow(label: l10n.doctorProfileDegrees, value: degrees),
      if (position != null)
        _InfoRow(
          label: l10n.doctorProfilePosition,
          value: position,
        ),
      if (role != null) _InfoRow(label: l10n.doctorProfileRole, value: role),
    ];

    final contact = <Widget>[
      if (doctor.email?.trim().isNotEmpty ?? false)
        _InfoRow(label: l10n.doctorProfileEmail, value: doctor.email!.trim()),
      if (doctor.phone?.trim().isNotEmpty ?? false)
        _InfoRow(label: l10n.doctorProfilePhone, value: doctor.phone!.trim()),
      if (doctor.address?.trim().isNotEmpty ?? false)
        _InfoRow(
          label: l10n.doctorProfileAddress,
          value: doctor.address!.trim(),
        ),
    ];

    final personal = <Widget>[
      if (dateOfBirth != null)
        _InfoRow(label: l10n.doctorProfileDob, value: dateOfBirth),
      if (gender != null)
        _InfoRow(label: l10n.doctorProfileGender, value: gender),
      if (citizenId != null)
        _InfoRow(label: l10n.doctorProfileCitizenId, value: citizenId),
    ];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Spacing.group),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: AppAppBar(
                        title: l10n.doctorProfileTitle,
                        subtitle: l10n.doctorProfileSubtitle,
                        onBack: () => context.goBackOr(PatientRoutes.list),
                      ),
                    ),
                    const SizedBox(width: Spacing.inline),
                    _EditButton(doctor: doctor),
                  ],
                ),
                const SizedBox(height: Spacing.block),
                PatientHeader(
                  name: name,
                  metadata: headline.isNotEmpty
                      ? headline
                      : l10n.settingsProfileSpecialty,
                  avatarGlyph: initialsFor(name),
                  avatarImageUrl: doctor.avatarUrl,
                ),
                const SizedBox(height: Spacing.control),
                AppButton(
                  label: l10n.doctorProfileEdit,
                  type: AppButtonType.outline,
                  size: AppButtonSize.medium,
                  leadingIcon: LucideIcons.pencil,
                  expand: true,
                  onPressed: () => context.push(
                    AuthenticationRoutes.doctorProfileEdit,
                    extra: doctor,
                  ),
                ),
                if (professional.isEmpty && contact.isEmpty && personal.isEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: Spacing.section),
                    child: AppText(
                      l10n.doctorProfileEmpty,
                      type: AppTextType.caption,
                    ),
                  )
                else ...[
                  if (professional.isNotEmpty) ...[
                    const SizedBox(height: Spacing.section),
                    _SectionLabel(l10n.doctorProfileSectionProfessional),
                    const SizedBox(height: Spacing.xxs),
                    AppCard.divided(
                      professional,
                      padding: const EdgeInsets.symmetric(
                        horizontal: Spacing.group,
                      ),
                    ),
                  ],
                  if (contact.isNotEmpty) ...[
                    const SizedBox(height: Spacing.section),
                    _SectionLabel(l10n.doctorProfileSectionContact),
                    const SizedBox(height: Spacing.xxs),
                    AppCard.divided(
                      contact,
                      padding: const EdgeInsets.symmetric(
                        horizontal: Spacing.group,
                      ),
                    ),
                  ],
                  if (personal.isNotEmpty) ...[
                    const SizedBox(height: Spacing.section),
                    _SectionLabel(l10n.doctorProfileSectionPersonal),
                    const SizedBox(height: Spacing.xxs),
                    AppCard.divided(
                      personal,
                      padding: const EdgeInsets.symmetric(
                        horizontal: Spacing.group,
                      ),
                    ),
                  ],
                ],
                const SizedBox(height: Spacing.screen),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Opens the editable profile, passing the loaded [doctor] so the form does
/// not have to resolve the profile again.
class _EditButton extends StatelessWidget {
  const _EditButton({required this.doctor});

  final DoctorProfileDto doctor;

  @override
  Widget build(BuildContext context) {
    final c = context.respiraColors;
    final l10n = context.l10n;

    return Semantics(
      button: true,
      label: l10n.doctorProfileEdit,
      child: Material(
        color: c.primarySoft,
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        child: SizedBox(
          width: 44,
          height: 44,
          child: InkWell(
            onTap: () => context.push(
              AuthenticationRoutes.doctorProfileEdit,
              extra: doctor,
            ),
            child: Center(
              child: Icon(LucideIcons.pencil, size: 20, color: c.primary),
            ),
          ),
        ),
      ),
    );
  }
}

/// Loading / error / empty shell, mirroring the patient detail states.
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
                title: l10n.doctorProfileTitle,
                subtitle: l10n.doctorProfileSubtitle,
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

/// Key–value row inside a grouped card.
class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 44),
      padding: const EdgeInsets.symmetric(vertical: Spacing.control),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: AppText(
              label,
              type: AppTextType.caption,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: Spacing.control),
          Expanded(
            flex: 3,
            child: AppText(
              value,
              type: AppTextType.bodyMedium,
              fontWeight: FontWeight.w600,
              textAlign: TextAlign.right,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return AppText(
      text,
      type: AppTextType.label,
      color: context.respiraColors.textPrimary,
    );
  }
}

String? _genderLabel(String? gender, AppLocalizations l10n) {
  final value = gender?.trim();
  if (value == null || value.isEmpty) return null;
  final parsed = DoctorGender.fromWire(value);
  if (parsed != null) return parsed.label(l10n);
  return switch (value.toLowerCase()) {
    'other' => l10n.doctorProfileGenderOther,
    _ => value,
  };
}

/// Enum labels are localized; unknown values from older payloads fall back to
/// the raw string so nothing disappears from the screen.
String? _degreeLabel(String? degree, AppLocalizations l10n) {
  final value = degree?.trim();
  if (value == null || value.isEmpty) return null;
  return DoctorDegree.fromWire(value)?.label(l10n) ?? value;
}

String? _academicTitleLabel(String? title, AppLocalizations l10n) {
  final value = title?.trim();
  if (value == null || value.isEmpty) return null;
  return DoctorAcademicTitle.fromWire(value)?.label(l10n) ?? value;
}

String? _positionLabel(String? position, AppLocalizations l10n) {
  final value = position?.trim();
  if (value == null || value.isEmpty) return null;
  return DoctorPosition.fromWire(value)?.label(l10n) ?? value;
}

/// `yyyy-MM-ddTHH:mm:ss…` → `dd/MM/yyyy`.
String? _dateOfBirthLabel(String? dateOfBirth) {
  final value = dateOfBirth?.trim();
  if (value == null || value.isEmpty) return null;
  return isoDateToDdMmYyyy(value);
}

String? _roleLabel(String? role, AppLocalizations l10n) {
  final value = role?.trim();
  if (value == null || value.isEmpty) return null;
  return switch (value.toLowerCase()) {
    'doctor' => l10n.doctorProfileRoleDoctor,
    'admin' => l10n.doctorProfileRoleAdmin,
    _ => value,
  };
}

/// Keeps only the last four digits of the citizen id visible.
String? _maskCitizenId(String? citizenId) {
  final value = citizenId?.trim();
  if (value == null || value.isEmpty) return null;
  final digits = value.replaceAll(RegExp(r'\s+'), '');
  final visible = digits.length <= 4 ? digits : digits.substring(digits.length - 4);
  return '•••• $visible';
}
