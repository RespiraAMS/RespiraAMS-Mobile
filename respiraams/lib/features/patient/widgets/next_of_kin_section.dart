import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_response.dart';
import '../../../../design_system/design_system.dart';
import '../../../../l10n/l10n.dart';
import '../models/next_of_kin_relationship.dart';
import '../models/patient_dtos.dart';
import '../providers/patient_detail_provider.dart';
import '../routes.dart';
import '../services/patient_service.dart';
import 'section_label_widget.dart';

enum _NextOfKinAction { edit, delete }

/// "Người thân liên hệ" block of the patient detail screen.
///
/// Backed by `PatientDetailDto.nextOfKins`, so no extra request is needed;
/// mutations invalidate `patientDetailProvider` to refresh the list.
class NextOfKinSection extends ConsumerStatefulWidget {
  const NextOfKinSection({
    super.key,
    required this.patientId,
    required this.nextOfKins,
  });

  final String patientId;
  final List<NextOfKinItemDto> nextOfKins;

  @override
  ConsumerState<NextOfKinSection> createState() => _NextOfKinSectionState();
}

class _NextOfKinSectionState extends ConsumerState<NextOfKinSection> {
  String? _deletingId;

  void _openForm({String? nextOfKinId}) {
    final query = StringBuffer('patientId=${widget.patientId}');
    if (nextOfKinId != null) query.write('&kinId=$nextOfKinId');
    context.push('${PatientRoutes.nextOfKin}?$query');
  }

  Future<void> _delete(NextOfKinItemDto kin) async {
    if (_deletingId != null) return;
    final l10n = context.l10n;

    final confirmed = await showAppConfirmDialog(
      context,
      title: l10n.nextOfKinDeleteTitle,
      description: l10n.nextOfKinDeleteDesc,
      icon: LucideIcons.trash2,
      infoLabel:
          '${kin.fullName} · '
          '${nextOfKinRelationshipLabel(kin.relationship, l10n)} · '
          '${kin.phoneNumber}',
      infoBackground: context.respiraColors.errorSoft,
      confirmLabel: l10n.nextOfKinDeleteConfirm,
      cancelLabel: l10n.commonCancel,
    );
    if (confirmed != true || !mounted) return;

    setState(() => _deletingId = kin.id);
    try {
      await PatientService(ref.read(apiClientProvider)).deleteNextOfKin(kin.id);
      if (!mounted) return;
      ref.invalidate(patientDetailProvider(widget.patientId));
      showAppToast(context, l10n.nextOfKinDeleteSuccess);
    } on ApiException catch (e) {
      if (mounted) showAppToast(context, e.message);
    } on DioException catch (e) {
      if (!mounted) return;
      showAppToast(context, dioErrorMessage(e).localizedError(l10n));
    } catch (_) {
      if (!mounted) return;
      showAppToast(context, l10n.nextOfKinDeleteFailed);
    } finally {
      if (mounted) setState(() => _deletingId = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = context.respiraColors;
    final l10n = context.l10n;
    final kins = widget.nextOfKins;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(child: SectionLabelWidget(l10n.nextOfKinSection)),
            const SizedBox(width: Spacing.inline),
            _AddButton(onTap: () => _openForm()),
          ],
        ),
        const SizedBox(height: Spacing.xxs),
        if (kins.isEmpty)
          AppSurface(
            padding: const EdgeInsets.all(Spacing.group),
            child: Column(
              children: [
                Container(
                  width: ControlSize.touchTargetMin,
                  height: ControlSize.touchTargetMin,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: c.surfaceSecondary,
                    shape: BoxShape.circle,
                  ),
                  child: AppIcon(
                    LucideIcons.users,
                    size: ControlSize.iconLg,
                    color: c.iconMuted,
                  ),
                ),
                const SizedBox(height: Spacing.control),
                AppText(
                  l10n.nextOfKinEmpty,
                  type: AppTextType.bodyMedium,
                  fontWeight: FontWeight.w600,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: Spacing.xxxs),
                AppText(
                  l10n.nextOfKinEmptyDesc,
                  type: AppTextType.caption,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          )
        else
          Column(
            children: [
              for (var i = 0; i < kins.length; i++) ...[
                if (i > 0) const SizedBox(height: Spacing.control),
                _NextOfKinCard(
                  kin: kins[i],
                  busy: _deletingId != null,
                  onEdit: () => _openForm(nextOfKinId: kins[i].id),
                  onDelete: () => _delete(kins[i]),
                ),
              ],
            ],
          ),
      ],
    );
  }
}

class _AddButton extends StatelessWidget {
  const _AddButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.respiraColors;
    final l10n = context.l10n;

    return Material(
      color: c.primarySoft,
      borderRadius: AppRadius.full,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.full,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Spacing.control,
            vertical: 6,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppIcon(LucideIcons.plus, size: ControlSize.iconSm, color: c.primary),
              const SizedBox(width: Spacing.xxxs + 2),
              AppText(
                l10n.nextOfKinAdd,
                type: AppTextType.label,
                color: c.primary,
                maxLines: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NextOfKinCard extends StatelessWidget {
  const _NextOfKinCard({
    required this.kin,
    required this.busy,
    required this.onEdit,
    required this.onDelete,
  });

  final NextOfKinItemDto kin;
  final bool busy;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final c = context.respiraColors;
    final l10n = context.l10n;
    final initial = kin.fullName.trim().isEmpty
        ? '?'
        : kin.fullName.trim().substring(0, 1).toUpperCase();

    return AppSurface(
      padding: const EdgeInsets.symmetric(
        horizontal: Spacing.group,
        vertical: Spacing.control,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: c.primarySoft,
              shape: BoxShape.circle,
            ),
            child: AppText(
              initial,
              type: AppTextType.bodyMedium,
              fontWeight: FontWeight.w700,
              color: c.primary,
              maxLines: 1,
            ),
          ),
          const SizedBox(width: Spacing.control),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  kin.fullName,
                  type: AppTextType.bodyMedium,
                  fontWeight: FontWeight.w600,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: Spacing.xxxs),
                AppText(
                  '${l10n.nextOfKinRelationship}: '
                  '${nextOfKinRelationshipLabel(kin.relationship, l10n)}',
                  type: AppTextType.caption,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: Spacing.xxxs),
                Row(
                  children: [
                    AppIcon(
                      LucideIcons.phone,
                      size: ControlSize.iconSm,
                      color: c.iconMuted,
                    ),
                    const SizedBox(width: Spacing.xxxs + 2),
                    Expanded(
                      child: AppText(
                        kin.phoneNumber,
                        type: AppTextType.caption,
                        color: c.textPrimary,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: Spacing.xxs),
          PopupMenuButton<_NextOfKinAction>(
            enabled: !busy,
            tooltip: '',
            offset: const Offset(0, 36),
            color: c.surface,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: AppRadius.md,
              side: BorderSide(color: c.borderSubtle),
            ),
            onSelected: (action) {
              switch (action) {
                case _NextOfKinAction.edit:
                  onEdit();
                case _NextOfKinAction.delete:
                  onDelete();
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem<_NextOfKinAction>(
                value: _NextOfKinAction.edit,
                height: 44,
                child: Row(
                  children: [
                    AppIcon(
                      LucideIcons.pencil,
                      size: ControlSize.iconLg,
                      color: c.iconDefault,
                    ),
                    const SizedBox(width: Spacing.control),
                    AppText(l10n.nextOfKinMenuEdit, type: AppTextType.label),
                  ],
                ),
              ),
              PopupMenuItem<_NextOfKinAction>(
                value: _NextOfKinAction.delete,
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
                      l10n.nextOfKinMenuDelete,
                      type: AppTextType.label,
                      color: c.error,
                    ),
                  ],
                ),
              ),
            ],
            child: Container(
              width: 32,
              height: 32,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: c.surfaceSecondary,
                shape: BoxShape.circle,
              ),
              child: AppIcon(
                LucideIcons.moreVertical,
                size: ControlSize.iconLg,
                color: c.iconDefault,
                semanticLabel: l10n.nextOfKinMenuSemantic,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
