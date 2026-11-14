import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_response.dart';
import '../../../../design_system/design_system.dart';
import '../../../../l10n/l10n.dart';
import '../services/patient_service.dart';

/// Discharge outcomes accepted by `PUT /patients/{id}/discharge`.
enum DischargeOutcome { recovered, death, outOfScope }

extension DischargeOutcomeL10n on DischargeOutcome {
  String get wireValue => switch (this) {
        DischargeOutcome.recovered => 'Recovered',
        DischargeOutcome.death => 'Death',
        DischargeOutcome.outOfScope => 'OutOfScope',
      };

  String label(AppLocalizations l10n) => switch (this) {
        DischargeOutcome.recovered => l10n.patientDischargeRecovered,
        DischargeOutcome.death => l10n.patientDischargeDeath,
        DischargeOutcome.outOfScope => l10n.patientDischargeOutOfScope,
      };

  String description(AppLocalizations l10n) => switch (this) {
        DischargeOutcome.recovered => l10n.patientDischargeRecoveredDesc,
        DischargeOutcome.death => l10n.patientDischargeDeathDesc,
        DischargeOutcome.outOfScope => l10n.patientDischargeOutOfScopeDesc,
      };
}

/// Opens the "Xuất viện bệnh nhân" sheet.
///
/// Resolves with the chosen outcome (`Recovered` | `Death` | `OutOfScope`)
/// **only after** the API call succeeds; `null` when cancelled.
Future<DischargeOutcome?> showDischargePatientSheet(
  BuildContext context, {
  required String patientId,
  required String patientName,
  required String patientCode,
  required String admission,
}) {
  return showModalBottomSheet<DischargeOutcome>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => _DischargePatientSheet(
      patientId: patientId,
      patientName: patientName,
      patientCode: patientCode,
      admission: admission,
    ),
  );
}

class _DischargePatientSheet extends ConsumerStatefulWidget {
  const _DischargePatientSheet({
    required this.patientId,
    required this.patientName,
    required this.patientCode,
    required this.admission,
  });

  final String patientId;
  final String patientName;
  final String patientCode;
  final String admission;

  @override
  ConsumerState<_DischargePatientSheet> createState() =>
      _DischargePatientSheetState();
}

class _DischargePatientSheetState
    extends ConsumerState<_DischargePatientSheet> {
  DischargeOutcome? _selected;
  bool _submitting = false;

  Future<void> _confirm() async {
    final outcome = _selected;
    if (outcome == null || _submitting) return;
    final l10n = context.l10n;

    setState(() => _submitting = true);
    try {
      await PatientService(ref.read(apiClientProvider)).dischargePatient(
        id: widget.patientId,
        outcome: outcome.wireValue,
      );
      if (!mounted) return;
      Navigator.of(context).pop(outcome);
    } on ApiException catch (e) {
      if (mounted) showAppToast(context, e.message);
    } on DioException catch (e) {
      if (!mounted) return;
      showAppToast(context, dioErrorMessage(e).localizedError(l10n));
    } catch (_) {
      if (!mounted) return;
      showAppToast(context, l10n.patientDischargeFailed);
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
                  height: 4,
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
                      LucideIcons.logOut,
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
                          l10n.patientDischargeTitle,
                          type: AppTextType.h3,
                        ),
                        const SizedBox(height: Spacing.xxxs),
                        AppText(
                          '${widget.patientName} · ${widget.patientCode}',
                          type: AppTextType.caption,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
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
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: Spacing.control,
                  vertical: Spacing.control,
                ),
                decoration: BoxDecoration(
                  color: c.surfaceSecondary,
                  borderRadius: AppRadius.md,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: AppText(
                        l10n.patientDischargeAdmission,
                        type: AppTextType.caption,
                      ),
                    ),
                    AppText(
                      _formatAdmission(widget.admission, l10n),
                      type: AppTextType.label,
                      color: c.textPrimary,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: Spacing.section),
              AppText(
                l10n.patientDischargeOutcomeLabel,
                type: AppTextType.label,
                color: c.textPrimary,
              ),
              const SizedBox(height: Spacing.control),
              for (final outcome in DischargeOutcome.values) ...[
                _OutcomeCard(
                  outcome: outcome,
                  selected: _selected == outcome,
                  dimmed: _selected != null && _selected != outcome,
                  onTap: _submitting
                      ? null
                      : () => setState(() => _selected = outcome),
                ),
                if (outcome != DischargeOutcome.values.last)
                  const SizedBox(height: Spacing.control),
              ],
              if (_selected != null) ...[
                const SizedBox(height: Spacing.group),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Spacing.control,
                    vertical: Spacing.control,
                  ),
                  decoration: BoxDecoration(
                    color: c.primarySoft,
                    borderRadius: AppRadius.md,
                  ),
                  child: Row(
                    children: [
                      AppIcon(
                        LucideIcons.checkCircle,
                        size: ControlSize.iconLg,
                        color: c.primary,
                      ),
                      const SizedBox(width: Spacing.inline),
                      Expanded(
                        child: AppText(
                          l10n.patientDischargeSelected(
                            _selected!.label(l10n),
                          ),
                          type: AppTextType.caption,
                          color: c.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: Spacing.section),
              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      label: l10n.patientDischargeCancel,
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
                      label: l10n.patientDischargeConfirm,
                      size: AppButtonSize.medium,
                      loading: _submitting,
                      onPressed: _selected == null || _submitting
                          ? null
                          : _confirm,
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

  static String _formatAdmission(String value, AppLocalizations l10n) {
    if (value.trim().isEmpty) return l10n.commonNotAvailable;
    final parsed = DateTime.tryParse(value);
    if (parsed == null) return value;
    final local = parsed.toLocal();
    final dd = local.day.toString().padLeft(2, '0');
    final mm = local.month.toString().padLeft(2, '0');
    final hh = local.hour.toString().padLeft(2, '0');
    final min = local.minute.toString().padLeft(2, '0');
    return '$dd/$mm/${local.year} · $hh:$min';
  }
}

class _OutcomeCard extends StatelessWidget {
  const _OutcomeCard({
    required this.outcome,
    required this.selected,
    required this.dimmed,
    required this.onTap,
  });

  final DischargeOutcome outcome;
  final bool selected;
  final bool dimmed;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.respiraColors;
    final l10n = context.l10n;

    return Opacity(
      opacity: dimmed ? 0.7 : 1,
      child: Material(
        color: selected ? c.primarySoft : c.surface,
        borderRadius: AppRadius.md,
        child: InkWell(
          onTap: onTap,
          borderRadius: AppRadius.md,
          child: Container(
            padding: const EdgeInsets.all(Spacing.control),
            decoration: BoxDecoration(
              borderRadius: AppRadius.md,
              border: Border.all(
                color: selected ? c.primary : c.borderSubtle,
                width: selected ? 2 : 1,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 24,
                  height: 24,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: selected ? c.primary : c.surfaceSecondary,
                    border: Border.all(
                      color: selected ? c.primary : c.borderDefault,
                    ),
                  ),
                  child: selected
                      ? Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: c.onPrimary,
                          ),
                        )
                      : null,
                ),
                const SizedBox(width: Spacing.control),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        outcome.label(l10n),
                        type: AppTextType.bodyMedium,
                        fontWeight: FontWeight.w600,
                      ),
                      const SizedBox(height: Spacing.xxxs),
                      AppText(
                        outcome.description(l10n),
                        type: AppTextType.caption,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
