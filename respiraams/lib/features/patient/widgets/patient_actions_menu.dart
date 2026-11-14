import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_response.dart';
import '../../../../design_system/design_system.dart';
import '../../../../l10n/l10n.dart';
import '../providers/active_patient_provider.dart';
import '../providers/patient_list_provider.dart';
import '../routes.dart';
import '../services/patient_service.dart';

enum _PatientMenuAction { edit, delete }

/// Overflow menu of the patient detail screen: a vertical 3-dot button
/// rendered next to the patient name.
///
/// * Edit → `/patient/edit?id=…` (`PUT /patients/{id}`).
/// * Delete → confirmation dialog, then `DELETE /patients/{id}`.
class PatientActionsMenu extends ConsumerStatefulWidget {
  const PatientActionsMenu({
    super.key,
    required this.patientId,
    required this.patientName,
    required this.patientCode,
  });

  final String patientId;
  final String patientName;
  final String patientCode;

  @override
  ConsumerState<PatientActionsMenu> createState() =>
      _PatientActionsMenuState();
}

class _PatientActionsMenuState extends ConsumerState<PatientActionsMenu> {
  bool _deleting = false;

  Future<void> _onSelected(_PatientMenuAction action) async {
    switch (action) {
      case _PatientMenuAction.edit:
        await context.push('${PatientRoutes.edit}?id=${widget.patientId}');
        break;
      case _PatientMenuAction.delete:
        await _confirmDelete();
        break;
    }
  }

  Future<void> _confirmDelete() async {
    if (_deleting) return;
    final l10n = context.l10n;

    final confirmed = await showAppConfirmDialog(
      context,
      title: l10n.patientDeleteTitle,
      description: l10n.patientDeleteDescription,
      icon: LucideIcons.trash2,
      infoLabel: '${widget.patientName} · ${widget.patientCode}',
      infoBackground: context.respiraColors.errorSoft,
      confirmLabel: l10n.patientDeleteConfirm,
      cancelLabel: l10n.commonCancel,
    );
    if (confirmed != true || !mounted) return;

    setState(() => _deleting = true);
    try {
      await PatientService(ref.read(apiClientProvider))
          .deletePatient(widget.patientId);
      if (!mounted) return;

      final active = ref.read(activePatientControllerProvider);
      if (active?.id == widget.patientId) {
        ref.read(activePatientControllerProvider.notifier).clear();
      }
      ref.read(patientListControllerProvider.notifier).refresh();

      showAppToast(context, l10n.patientDeleteSuccess);
      context.go(PatientRoutes.list);
    } on ApiException catch (e) {
      if (mounted) showAppToast(context, e.message);
    } on DioException catch (e) {
      if (!mounted) return;
      showAppToast(context, dioErrorMessage(e).localizedError(l10n));
    } catch (_) {
      if (!mounted) return;
      showAppToast(context, l10n.patientDeleteFailed);
    } finally {
      if (mounted) setState(() => _deleting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = context.respiraColors;
    final l10n = context.l10n;

    return PopupMenuButton<_PatientMenuAction>(
      enabled: !_deleting,
      tooltip: '',
      offset: const Offset(0, 40),
      color: c.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.md,
        side: BorderSide(color: c.borderSubtle),
      ),
      onSelected: _onSelected,
      itemBuilder: (context) => [
        PopupMenuItem<_PatientMenuAction>(
          value: _PatientMenuAction.edit,
          height: 44,
          child: Row(
            children: [
              AppIcon(
                LucideIcons.pencil,
                size: ControlSize.iconLg,
                color: c.iconDefault,
              ),
              const SizedBox(width: Spacing.control),
              AppText(l10n.patientMenuEdit, type: AppTextType.label),
            ],
          ),
        ),
        PopupMenuItem<_PatientMenuAction>(
          value: _PatientMenuAction.delete,
          height: 44,
          child: Row(
            children: [
              AppIcon(
                LucideIcons.trash2,
                size: ControlSize.iconLg,
                color: c.error,
              ),
              const SizedBox(width: Spacing.control),
              AppText(
                l10n.patientMenuDelete,
                type: AppTextType.label,
                color: c.error,
              ),
            ],
          ),
        ),
      ],
      child: Container(
        width: 36,
        height: 36,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: c.surfaceSecondary,
          shape: BoxShape.circle,
        ),
        child: AppIcon(
          LucideIcons.moreVertical,
          size: ControlSize.iconBase,
          color: c.iconDefault,
          semanticLabel: l10n.patientMenuSemantic,
        ),
      ),
    );
  }
}
