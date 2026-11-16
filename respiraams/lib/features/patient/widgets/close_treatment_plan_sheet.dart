import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_response.dart';
import '../../../../design_system/design_system.dart';
import '../../../../l10n/l10n.dart';
import '../services/patient_service.dart';

/// Opens the "Dừng phác đồ điều trị" sheet.
///
/// Resolves with `true` **only after** `PUT /treatment-plans/{id}/close`
/// succeeds; `null` when the doctor cancels.
Future<bool?> showCloseTreatmentPlanSheet(
  BuildContext context, {
  required String planId,
  required String patientName,
}) {
  return showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => _CloseTreatmentPlanSheet(
      planId: planId,
      patientName: patientName,
    ),
  );
}

class _CloseTreatmentPlanSheet extends ConsumerStatefulWidget {
  const _CloseTreatmentPlanSheet({
    required this.planId,
    required this.patientName,
  });

  final String planId;
  final String patientName;

  @override
  ConsumerState<_CloseTreatmentPlanSheet> createState() =>
      _CloseTreatmentPlanSheetState();
}

class _CloseTreatmentPlanSheetState
    extends ConsumerState<_CloseTreatmentPlanSheet> {
  static const _maxReasonLength = 500;

  final TextEditingController _reason = TextEditingController();
  bool _submitting = false;
  String? _reasonError;

  @override
  void dispose() {
    _reason.dispose();
    super.dispose();
  }

  Future<void> _confirm() async {
    if (_submitting) return;
    final l10n = context.l10n;
    final reason = _reason.text.trim();
    if (reason.isEmpty) {
      setState(() => _reasonError = l10n.treatmentPlanErrReasonRequired);
      return;
    }

    setState(() {
      _submitting = true;
      _reasonError = null;
    });
    try {
      await PatientService(ref.read(apiClientProvider)).closeTreatmentPlan(
        id: widget.planId,
        reason: reason,
      );
      if (!mounted) return;
      Navigator.of(context).pop(true);
    } on ApiException catch (e) {
      if (mounted) showAppToast(context, e.message);
    } on DioException catch (e) {
      if (!mounted) return;
      showAppToast(context, dioErrorMessage(e).localizedError(l10n));
    } catch (_) {
      if (!mounted) return;
      showAppToast(context, l10n.treatmentPlanCloseFailed);
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = context.respiraColors;
    final l10n = context.l10n;
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return SafeArea(
      top: false,
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.92,
        ),
        padding: EdgeInsets.fromLTRB(
          Spacing.group,
          Spacing.control,
          Spacing.group,
          Spacing.group + bottomInset,
        ),
        decoration: BoxDecoration(
          color: c.surface,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(AppRadius.lgValue),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 6,
                  decoration: BoxDecoration(
                    color: c.borderDefault,
                    borderRadius: AppRadius.full,
                  ),
                ),
              ),
              const SizedBox(height: Spacing.group),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: c.errorSoft,
                      shape: BoxShape.circle,
                    ),
                    child: AppIcon(
                      LucideIcons.xCircle,
                      size: ControlSize.iconLg,
                      color: c.error,
                    ),
                  ),
                  const SizedBox(width: Spacing.control),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          l10n.treatmentPlanCloseTitle,
                          type: AppTextType.h3,
                          maxLines: 2,
                        ),
                        const SizedBox(height: Spacing.xxxs),
                        AppText(
                          'BN: ${widget.patientName}',
                          type: AppTextType.caption,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: Spacing.xxs),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: c.warningSoft,
                            borderRadius: AppRadius.full,
                          ),
                          child: AppText(
                            l10n.treatmentPlanStatusInProgress,
                            type: AppTextType.label,
                            color: c.warning,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: _submitting
                        ? null
                        : () => Navigator.of(context).pop(),
                    icon: AppIcon(
                      LucideIcons.x,
                      size: ControlSize.iconLg,
                      color: c.iconMuted,
                      semanticLabel: l10n.commonCancel,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: Spacing.group),
              Text.rich(
                TextSpan(
                  style: TextStyle(
                    fontSize: 13,
                    height: 20 / 13,
                    color: c.textSecondary,
                  ),
                  children: [
                    TextSpan(
                      text: l10n.treatmentPlanCloseDescriptionPrefix(
                        widget.patientName,
                      ),
                    ),
                    TextSpan(
                      text: l10n.treatmentPlanCloseWarning,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: c.error,
                      ),
                    ),
                    TextSpan(text: l10n.treatmentPlanCloseDescriptionSuffix),
                  ],
                ),
              ),
              const SizedBox(height: Spacing.section),
              AppTextField(
                label: '${l10n.treatmentPlanCloseReasonLabel} *',
                controller: _reason,
                hintText: l10n.treatmentPlanCloseReasonHint,
                errorText: _reasonError,
                maxLines: 5,
                minLines: 3,
                maxLength: _maxReasonLength,
                keyboardType: TextInputType.multiline,
                onChanged: (_) {
                  if (_reasonError != null) {
                    setState(() => _reasonError = null);
                  } else {
                    setState(() {});
                  }
                },
              ),
              const SizedBox(height: Spacing.xxxs),
              Align(
                alignment: Alignment.centerRight,
                child: AppText(
                  l10n.treatmentPlanCloseReasonCounter(_reason.text.runes.length),
                  type: AppTextType.caption,
                  maxLines: 1,
                ),
              ),
              const SizedBox(height: Spacing.section),
              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      label: l10n.commonCancel,
                      type: AppButtonType.outline,
                      size: AppButtonSize.medium,
                      onPressed: _submitting
                          ? null
                          : () => Navigator.of(context).pop(),
                    ),
                  ),
                  const SizedBox(width: Spacing.control),
                  Expanded(
                    child: AppButton(
                      label: l10n.treatmentPlanClose,
                      type: AppButtonType.destructive,
                      size: AppButtonSize.medium,
                      loading: _submitting,
                      onPressed: _submitting ? null : _confirm,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
