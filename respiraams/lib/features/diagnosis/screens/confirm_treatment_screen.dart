import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/context_extensions.dart';
import '../../../../design_system/design_system.dart';
import '../../../../l10n/l10n.dart';
import '../models/clinical_dtos.dart';
import '../models/diagnosis_labels.dart';
import '../providers/diagnosis_flow_provider.dart';
import '../routes.dart';
import '../widgets/aware_chip.dart';

/// `true` when [combination] is exactly the current [selected] set.
bool _isSameSet(List<AntibioticRefDto> combination, Set<String> selected) {
  if (selected.isEmpty) return false;
  final ids = combination.map((medicine) => medicine.id).toSet();
  return ids.length == selected.length && ids.containsAll(selected);
}

/// Route `/diagnosis/confirm-treatment` — pick the antibiotics to prescribe
/// and confirm the treatment.
///
/// Two ways to pick, mirroring how a doctor actually works:
/// * **Phác đồ tuân thủ** — tap one of the recommended medicine combinations
///   from the diagnose result; the selection follows the protocol.
/// * **Tất cả thuốc** — search the catalogue and pick any set manually.
///
/// A selection that matches a protocol combination is marked "Tuân thủ" (green
/// border); a non-adherent selection requires a reason (the backend enforces
/// the same rule).
class ConfirmTreatmentScreen extends ConsumerStatefulWidget {
  const ConfirmTreatmentScreen({super.key, this.result});

  final DiagnoseResultDto? result;

  @override
  ConsumerState<ConfirmTreatmentScreen> createState() =>
      _ConfirmTreatmentScreenState();
}

class _ConfirmTreatmentScreenState
    extends ConsumerState<ConfirmTreatmentScreen> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  final Set<String> _selected = {};
  String _query = '';
  bool _needWarning = false;
  String? _error;

  /// 0 = protocols, 1 = full catalogue.
  int _tab = 0;

  @override
  void dispose() {
    _searchController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  bool _isAdherent(DiagnoseResultDto result, Set<String> selected) {
    for (final protocol in result.protocols) {
      for (final combination in protocol.medicines) {
        if (_isSameSet(combination, selected)) return true;
      }
    }
    return false;
  }

  bool _protocolIsAdherent(
    TreatmentProtocolDto protocol,
    Set<String> selected,
  ) {
    return protocol.medicines
        .any((combination) => _isSameSet(combination, selected));
  }

  /// Replaces the whole selection and refreshes the combination warning.
  Future<void> _applySelection(Set<String> ids) async {
    setState(() {
      _selected
        ..clear()
        ..addAll(ids);
      _error = null;
      _needWarning = false;
    });
    ref.read(diagnosisFlowControllerProvider.notifier).clearConfirmError();

    if (_selected.length >= 2) {
      final warn = await ref
          .read(diagnosisFlowControllerProvider.notifier)
          .checkCombinationWarning(_selected.toList());
      if (mounted) setState(() => _needWarning = warn);
    }
  }

  /// Tap in the catalogue tab: add/remove one antibiotic.
  Future<void> _toggle(AntibioticFormDto antibiotic) {
    final next = {..._selected};
    if (!next.remove(antibiotic.id)) next.add(antibiotic.id);
    return _applySelection(next);
  }

  /// Tap in the protocol tab: select the whole combination (or clear it when
  /// the same combination is already selected).
  Future<void> _selectCombination(List<AntibioticRefDto> combination) {
    final ids = combination.map((medicine) => medicine.id).toSet();
    return _applySelection(
      _isSameSet(combination, _selected) ? const <String>{} : ids,
    );
  }

  Future<void> _confirm() async {
    final result = widget.result;
    if (result == null) return;
    final l10n = context.l10n;

    if (_selected.isEmpty) {
      setState(() => _error = l10n.diagnosisSelectMedicineRequired);
      return;
    }

    final reason = _reasonController.text.trim();
    if (!_isAdherent(result, _selected) && reason.isEmpty) {
      setState(() => _error = l10n.diagnosisReasonRequired);
      return;
    }

    setState(() => _error = null);
    final ok = await ref
        .read(diagnosisFlowControllerProvider.notifier)
        .confirmTreatment(
          medicineIds: _selected.toList(),
          reasonForMedicineChoice: reason.isEmpty ? null : reason,
        );
    if (!mounted) return;
    if (ok) {
      Navigator.of(context).pop(true);
      return;
    }
    final error = ref.read(diagnosisFlowControllerProvider).confirmError;
    if (error != null) {
      showAppToast(context, error.localizedError(l10n));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final result = widget.result;
    final flow = ref.watch(diagnosisFlowControllerProvider);
    final catalog =
        ref.watch(diagnosisFormProvider).valueOrNull?.antibiotics ??
            const <AntibioticFormDto>[];
    final query = _query.trim().toLowerCase();
    final drugs = query.isEmpty
        ? catalog
        : catalog
            .where(
              (antibiotic) =>
                  antibiotic.name.toLowerCase().contains(query) ||
                  antibiotic.antibioticGroupName.toLowerCase().contains(query),
            )
            .toList();

    if (result == null) {
      return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Spacing.group),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppAppBar(
                  title: l10n.diagnosisConfirmTreatment,
                  subtitle: l10n.diagnosisSelectDrugs,
                  onBack: () =>
                      context.goBackOr(DiagnosisRoutes.diagnosisResult),
                ),
                const Spacer(),
                Center(
                  child: AppText(
                    l10n.diagnosisConfirmMissingResult,
                    type: AppTextType.caption,
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      );
    }

    final adherent = _isAdherent(result, _selected);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Spacing.group),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppAppBar(
                title: l10n.diagnosisConfirmTreatment,
                subtitle: l10n.diagnosisSelectDrugs,
                onBack: () =>
                    context.goBackOr(DiagnosisRoutes.diagnosisResult),
              ),
              const SizedBox(height: Spacing.control),
              AppSegmentedTabs<int>(
                segments: [
                  (0, l10n.diagnosisTabAdherentProtocols),
                  (1, l10n.diagnosisTabAllDrugs),
                ],
                selected: _tab,
                onChanged: (index) => setState(() => _tab = index),
              ),
              const SizedBox(height: Spacing.section),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (_tab == 0)
                        _ProtocolTab(
                          protocols: result.protocols,
                          selected: _selected,
                          isProtocolAdherent: (protocol) =>
                              _protocolIsAdherent(protocol, _selected),
                          onSelect: _selectCombination,
                        )
                      else ...[
                        AppTextField(
                          label: l10n.diagnosisDrugSearch,
                          controller: _searchController,
                          hintText: l10n.diagnosisDrugSearchHint,
                          onChanged: (value) =>
                              setState(() => _query = value),
                        ),
                        const SizedBox(height: Spacing.section),
                        if (drugs.isEmpty)
                          AppText(
                            l10n.commonNoResults,
                            type: AppTextType.caption,
                          )
                        else
                          for (final antibiotic in drugs)
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: Spacing.inline,
                              ),
                              child: _DrugRow(
                                key: ValueKey('drug-${antibiotic.id}'),
                                antibiotic: antibiotic,
                                selected: _selected.contains(antibiotic.id),
                                onTap: () => _toggle(antibiotic),
                              ),
                            ),
                      ],
                      const SizedBox(height: Spacing.section),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              l10n.diagnosisSelectDrugs,
                              style: TypographyTokens.label(context)
                                  .copyWith(
                                color: context.respiraColors.textPrimary,
                              ),
                            ),
                          ),
                          if (_selected.isNotEmpty)
                            AppText(
                              l10n.diagnosisSelectedDrugs(_selected.length),
                              type: AppTextType.caption,
                              color: context.respiraColors.primary,
                            ),
                        ],
                      ),
                      const SizedBox(height: Spacing.inline),
                      AppTextField(
                        label: adherent || _selected.isEmpty
                            ? l10n.diagnosisReason
                            : '${l10n.diagnosisReason} *',
                        controller: _reasonController,
                        hintText: l10n.diagnosisReasonHint,
                        helperText:
                            adherent ? null : l10n.diagnosisNonAdherentReason,
                      ),
                      if (_needWarning) ...[
                        const SizedBox(height: Spacing.section),
                        ClinicalAlert(
                          severity: ClinicalSeverity.needsAttention,
                          title: l10n.diagnosisWarnCombinationTitle,
                          description: l10n.diagnosisWarnCombinationDesc,
                        ),
                      ],
                      if (_error != null) ...[
                        const SizedBox(height: Spacing.control),
                        Text(
                          _error!,
                          style: TypographyTokens.caption(context)
                              .copyWith(color: context.respiraColors.error),
                        ),
                      ],
                      const SizedBox(height: Spacing.screen),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: Spacing.lg),
                child: AppButton(
                  label: l10n.diagnosisConfirmTreatment,
                  expand: true,
                  loading: flow.confirming,
                  onPressed: _selected.isEmpty ? null : _confirm,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Tab 1 — the recommended protocols from `POST /diagnose`.
///
/// Each medicine combination is one tappable row, so the doctor can prescribe
/// an adherent protocol with a single tap.
class _ProtocolTab extends StatelessWidget {
  const _ProtocolTab({
    required this.protocols,
    required this.selected,
    required this.isProtocolAdherent,
    required this.onSelect,
  });

  final List<TreatmentProtocolDto> protocols;
  final Set<String> selected;
  final bool Function(TreatmentProtocolDto protocol) isProtocolAdherent;
  final ValueChanged<List<AntibioticRefDto>> onSelect;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    if (protocols.isEmpty) {
      return AppText(l10n.diagnosisProtocolNoData, type: AppTextType.caption);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppText(l10n.diagnosisProtocolSelect, type: AppTextType.caption),
        const SizedBox(height: Spacing.inline),
        for (final protocol in protocols) ...[
          _ProtocolCard(
            protocol: protocol,
            adherent: isProtocolAdherent(protocol),
            selected: selected,
            onSelect: onSelect,
          ),
          const SizedBox(height: Spacing.control),
        ],
      ],
    );
  }
}

/// Protocol summary; the green border marks a protocol the selection follows.
class _ProtocolCard extends StatelessWidget {
  const _ProtocolCard({
    required this.protocol,
    required this.adherent,
    required this.selected,
    required this.onSelect,
  });

  final TreatmentProtocolDto protocol;
  final bool adherent;
  final Set<String> selected;
  final ValueChanged<List<AntibioticRefDto>> onSelect;

  @override
  Widget build(BuildContext context) {
    final c = context.respiraColors;
    final l10n = context.l10n;

    return Container(
      padding: const EdgeInsets.all(Spacing.control),
      decoration: BoxDecoration(
        color: c.surface,
        borderRadius: AppRadius.md,
        border: Border.all(
          color: adherent ? c.success : c.borderSubtle,
          width: adherent ? 2 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  '${severityLabel(protocol.severity, l10n)} · '
                  '${treatmentSiteLabel(protocol.treatmentSite, l10n)}',
                  style: TypographyTokens.body(context)
                      .copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              if (adherent)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Spacing.xxs,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: c.successSoft,
                    borderRadius: AppRadius.full,
                  ),
                  child: AppText(
                    l10n.diagnosisProtocolAdherent,
                    type: AppTextType.caption,
                    color: c.success,
                  ),
                ),
            ],
          ),
          const SizedBox(height: Spacing.xxs),
          if (protocol.medicines.isEmpty)
            AppText(l10n.diagnosisProtocolNoMedicine, type: AppTextType.caption)
          else
            for (final combination in protocol.medicines)
              Padding(
                padding: const EdgeInsets.only(top: Spacing.xxxs),
                child: _CombinationRow(
                  combination: combination,
                  selected: _isSameSet(combination, selected),
                  onTap: () => onSelect(combination),
                ),
              ),
        ],
      ),
    );
  }
}

/// One tappable medicine combination of a protocol.
class _CombinationRow extends StatelessWidget {
  const _CombinationRow({
    required this.combination,
    required this.selected,
    required this.onTap,
  });

  final List<AntibioticRefDto> combination;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.respiraColors;

    return Material(
      color: selected ? c.primarySoft : c.surfaceSecondary,
      borderRadius: AppRadius.sm,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.sm,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: Spacing.control,
            vertical: Spacing.xxs + 2,
          ),
          decoration: BoxDecoration(
            borderRadius: AppRadius.sm,
            border: Border.all(
              color: selected ? c.primary : c.borderSubtle,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Wrap(
                  spacing: Spacing.xxxs,
                  runSpacing: Spacing.xxxs,
                  children: [
                    for (final medicine in combination)
                      AwareDrugChip(
                        name: medicine.name,
                        classification: medicine.classification,
                      ),
                  ],
                ),
              ),
              const SizedBox(width: Spacing.xxs),
              Icon(
                selected
                    ? Icons.radio_button_checked
                    : Icons.radio_button_unchecked,
                size: ControlSize.iconLg,
                color: selected ? c.primary : c.iconMuted,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Selectable antibiotic row (AWaRe-coloured chip on the trailing edge).
class _DrugRow extends StatelessWidget {
  const _DrugRow({
    super.key,
    required this.antibiotic,
    required this.selected,
    required this.onTap,
  });

  final AntibioticFormDto antibiotic;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.respiraColors;

    return Material(
      color: selected ? c.primarySoft : c.surface,
      borderRadius: AppRadius.sm,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Container(
          constraints: const BoxConstraints(minHeight: ControlSize.rowHeight),
          padding: const EdgeInsets.symmetric(
            horizontal: Spacing.control,
            vertical: Spacing.control,
          ),
          decoration: BoxDecoration(
            borderRadius: AppRadius.sm,
            border: Border.all(
              color: selected ? c.primary : c.borderSubtle,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      antibiotic.name,
                      style: TypographyTokens.body(context)
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    if (antibiotic.antibioticGroupName.isNotEmpty) ...[
                      const SizedBox(height: Spacing.xxxs),
                      AppText(
                        antibiotic.antibioticGroupName,
                        type: AppTextType.caption,
                      ),
                    ],
                  ],
                ),
              ),
              if (antibiotic.classification.isNotEmpty) ...[
                const SizedBox(width: Spacing.control),
                AwareDrugChip(
                  name: '',
                  classification: antibiotic.classification,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
