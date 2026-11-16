import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';

import '../../../../design_system/design_system.dart';
import '../../../../l10n/l10n.dart';
import '../models/treatment_protocol.dart';
import '../providers/treatment_protocol_provider.dart';
import '../providers/treatment_protocol_service.dart';

/// Route `/lookup/treatment-protocols` — CAP treatment protocol catalogue.
///
/// Cards are collapsed by default and expand in place (the backend has no
/// detail endpoint).
class TreatmentProtocolListScreen extends StatefulWidget {
  const TreatmentProtocolListScreen({super.key});

  @override
  State<TreatmentProtocolListScreen> createState() =>
      _TreatmentProtocolListScreenState();
}

class _TreatmentProtocolListScreenState
    extends State<TreatmentProtocolListScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TreatmentProtocolProvider>().fetchPage();
    });
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<TreatmentProtocolProvider>().fetchPage();
    }
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      if (mounted) context.read<TreatmentProtocolProvider>().search(query);
    });
  }

  Future<void> _showFilterBottomSheet() async {
    final provider = context.read<TreatmentProtocolProvider>();
    // The pathogen/criterion lists are fetched in the background; the sheet
    // listens to the provider and swaps its spinner for the checklists once
    // the options arrive.
    unawaited(provider.loadFilterOptions());

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: context.respiraColors.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => _FilterBottomSheet(provider: provider),
    );

    // Applying a filter resets the list; start the new result set at the top.
    if (!mounted) return;
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = context.respiraColors;
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: c.background,
      body: SafeArea(
        child: Consumer<TreatmentProtocolProvider>(
          builder: (context, provider, child) {
            if (provider.errorMessage != null) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                showAppToast(
                  context,
                  provider.errorMessage!.localizedError(l10n),
                );
                provider.clearError();
              });
            }

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Spacing.group,
                    vertical: 8,
                  ),
                  child: AppAppBar(
                    title: l10n.treatmentProtocolTitle,
                    subtitle: l10n.treatmentProtocolSubtitle,
                    onBack: () => Navigator.pop(context),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: Spacing.group),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          onChanged: _onSearchChanged,
                          decoration: InputDecoration(
                            hintText: l10n.treatmentProtocolSearchHint,
                            hintStyle: TextStyle(color: c.textSecondary),
                            prefixIcon: Icon(
                              LucideIcons.search,
                              color: c.iconDefault,
                              size: 20,
                            ),
                            filled: true,
                            fillColor: c.surface,
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          style: TextStyle(color: c.textPrimary),
                        ),
                      ),
                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: _showFilterBottomSheet,
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: provider.hasActiveFilters
                                ? c.primary
                                : c.surface,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            LucideIcons.listFilter,
                            color: provider.hasActiveFilters
                                ? Colors.white
                                : c.iconPrimary,
                            size: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: Spacing.control),
                Expanded(child: _buildList(context, provider)),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildList(
    BuildContext context,
    TreatmentProtocolProvider provider,
  ) {
    final c = context.respiraColors;
    final l10n = context.l10n;

    if (provider.items.isEmpty && provider.isLoading) {
      return Center(child: CircularProgressIndicator(color: c.primary));
    }

    if (provider.items.isEmpty) {
      return Center(
        child: AppText(
          provider.hasLoadedItems
              ? l10n.commonNoResults
              : l10n.treatmentProtocolEmpty,
          color: c.textSecondary,
        ),
      );
    }

    return RefreshIndicator(
      color: c.primary,
      onRefresh: provider.refresh,
      child: ListView.separated(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(Spacing.group),
        itemCount: provider.items.length + (provider.hasMore ? 1 : 0),
        separatorBuilder: (_, _) => const SizedBox(height: Spacing.control),
        itemBuilder: (context, index) {
          if (index == provider.items.length) {
            return Padding(
              padding: const EdgeInsets.all(Spacing.group),
              child: Center(
                child: CircularProgressIndicator(color: c.primary),
              ),
            );
          }

          return _TreatmentProtocolCard(item: provider.items[index]);
        },
      ),
    );
  }
}

/// Bottom sheet with the protocol filters: severity + site chips and the
/// multi-select pathogen/criterion lists.
///
/// Edits a local draft and only pushes it to [provider] on "Áp dụng", so
/// dismissing the sheet leaves the current result set untouched.
class _FilterBottomSheet extends StatefulWidget {
  const _FilterBottomSheet({required this.provider});

  final TreatmentProtocolProvider provider;

  @override
  State<_FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<_FilterBottomSheet> {
  ProtocolSeverity? _severity;
  ProtocolTreatmentSite? _site;
  late Set<String> _pathogenIds;
  late Set<String> _criteriaIds;

  @override
  void initState() {
    super.initState();
    _severity = widget.provider.severityFilter;
    _site = widget.provider.siteFilter;
    _pathogenIds = {...widget.provider.pathogenIds};
    _criteriaIds = {...widget.provider.criteriaIds};
  }

  void _apply() {
    widget.provider.applyFilters(
      severity: _severity,
      treatmentSite: _site,
      pathogenIds: _pathogenIds,
      criteriaIds: _criteriaIds,
    );
    Navigator.pop(context);
  }

  void _clear() {
    setState(() {
      _severity = null;
      _site = null;
      _pathogenIds = {};
      _criteriaIds = {};
    });
  }

  @override
  Widget build(BuildContext context) {
    final c = context.respiraColors;
    final l10n = context.l10n;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.85,
        ),
        child: ListenableBuilder(
          listenable: widget.provider,
          builder: (context, _) {
            final isLoadingOptions = widget.provider.isLoadingOptions;
            final optionsError = widget.provider.optionsError;

            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    Spacing.group,
                    Spacing.control,
                    Spacing.group,
                    0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                            color: c.borderSubtle,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                      const SizedBox(height: Spacing.section),
                      AppText(
                        l10n.filterTitle,
                        type: AppTextType.h3,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(
                      Spacing.group,
                      Spacing.section,
                      Spacing.group,
                      Spacing.group,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          l10n.treatmentProtocolFilterSeverity,
                          type: AppTextType.bodyMedium,
                          fontWeight: FontWeight.w600,
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            _FilterChip(
                              label: l10n.commonAll,
                              selected: _severity == null,
                              onTap: () => setState(() => _severity = null),
                            ),
                            for (final value in const [
                              ProtocolSeverity.mild,
                              ProtocolSeverity.moderate,
                              ProtocolSeverity.severe,
                            ])
                              _FilterChip(
                                label: value.label(l10n),
                                selected: _severity == value,
                                onTap: () =>
                                    setState(() => _severity = value),
                              ),
                          ],
                        ),
                        const SizedBox(height: Spacing.section),
                        AppText(
                          l10n.treatmentProtocolFilterSite,
                          type: AppTextType.bodyMedium,
                          fontWeight: FontWeight.w600,
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            _FilterChip(
                              label: l10n.commonAll,
                              selected: _site == null,
                              onTap: () => setState(() => _site = null),
                            ),
                            for (final value in const [
                              ProtocolTreatmentSite.outpatient,
                              ProtocolTreatmentSite.inpatient,
                              ProtocolTreatmentSite.intensiveCareUnit,
                            ])
                              _FilterChip(
                                label: value.label(l10n),
                                selected: _site == value,
                                onTap: () => setState(() => _site = value),
                              ),
                          ],
                        ),
                        const SizedBox(height: Spacing.section),
                        if (isLoadingOptions)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: Spacing.group,
                            ),
                            child: Center(
                              child: CircularProgressIndicator(color: c.primary),
                            ),
                          )
                        else if (optionsError != null)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(
                                l10n.treatmentProtocolFilterLoadFailed,
                                type: AppTextType.caption,
                                color: c.error,
                              ),
                              const SizedBox(height: 8),
                              AppButton(
                                label: l10n.commonRetry,
                                type: AppButtonType.outline,
                                size: AppButtonSize.medium,
                                onPressed: () => widget.provider
                                    .loadFilterOptions(force: true),
                              ),
                            ],
                          )
                        else ...[
                          _MultiSelectSection(
                            title: l10n.treatmentProtocolFilterPathogen,
                            searchHint:
                                l10n.treatmentProtocolFilterSearchPathogen,
                            options: widget.provider.pathogenOptions,
                            selectedIds: _pathogenIds,
                            onChanged: (ids) =>
                                setState(() => _pathogenIds = ids),
                          ),
                          const SizedBox(height: Spacing.section),
                          _MultiSelectSection(
                            title: l10n.treatmentProtocolFilterCriteria,
                            searchHint:
                                l10n.treatmentProtocolFilterSearchCriteria,
                            options: widget.provider.criteriaOptions,
                            selectedIds: _criteriaIds,
                            onChanged: (ids) =>
                                setState(() => _criteriaIds = ids),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    Spacing.group,
                    Spacing.control,
                    Spacing.group,
                    Spacing.group + MediaQuery.of(context).padding.bottom,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: AppButton(
                          label: l10n.filterClear,
                          type: AppButtonType.outline,
                          onPressed: _clear,
                        ),
                      ),
                      const SizedBox(width: Spacing.control),
                      Expanded(
                        child: AppButton(
                          label: l10n.filterApply,
                          onPressed: _apply,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

/// Search + checkbox list for one multi-select filter (pathogens/criteria).
class _MultiSelectSection extends StatefulWidget {
  const _MultiSelectSection({
    required this.title,
    required this.searchHint,
    required this.options,
    required this.selectedIds,
    required this.onChanged,
  });

  final String title;
  final String searchHint;
  final List<TreatmentProtocolFilterOption> options;
  final Set<String> selectedIds;
  final ValueChanged<Set<String>> onChanged;

  @override
  State<_MultiSelectSection> createState() => _MultiSelectSectionState();
}

class _MultiSelectSectionState extends State<_MultiSelectSection> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = context.respiraColors;
    final l10n = context.l10n;

    final query = _query.trim().toLowerCase();
    final visible = query.isEmpty
        ? widget.options
        : widget.options
            .where((option) => option.name.toLowerCase().contains(query))
            .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: AppText(
                widget.title,
                type: AppTextType.bodyMedium,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (widget.selectedIds.isNotEmpty)
              AppText(
                l10n.treatmentProtocolFilterSelectedCount(
                  widget.selectedIds.length,
                ),
                type: AppTextType.caption,
                color: c.primary,
              ),
          ],
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _searchController,
          onChanged: (value) => setState(() => _query = value),
          decoration: InputDecoration(
            hintText: widget.searchHint,
            hintStyle: TextStyle(color: c.textSecondary),
            prefixIcon: Icon(
              LucideIcons.search,
              color: c.iconDefault,
              size: 20,
            ),
            filled: true,
            fillColor: c.surface,
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
          style: TextStyle(color: c.textPrimary),
        ),
        const SizedBox(height: 8),
        Container(
          constraints: const BoxConstraints(maxHeight: 220),
          decoration: BoxDecoration(
            color: c.surface,
            borderRadius: AppRadius.md,
            border: Border.all(color: c.borderSubtle),
          ),
          child: visible.isEmpty
              ? Padding(
                  padding: const EdgeInsets.all(Spacing.control),
                  child: AppText(
                    l10n.commonNoResults,
                    type: AppTextType.caption,
                    color: c.textSecondary,
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: visible.length,
                  itemBuilder: (context, index) {
                    final option = visible[index];
                    final selected = widget.selectedIds.contains(option.id);
                    return CheckboxListTile(
                      value: selected,
                      dense: true,
                      visualDensity: VisualDensity.compact,
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 8),
                      activeColor: c.primary,
                      title: AppText(option.name, type: AppTextType.body),
                      onChanged: (checked) {
                        final next = {...widget.selectedIds};
                        if (checked == true) {
                          next.add(option.id);
                        } else {
                          next.remove(option.id);
                        }
                        widget.onChanged(next);
                      },
                    );
                  },
                ),
        ),
      ],
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
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

    return Material(
      color: selected ? c.primarySoft : c.surface,
      borderRadius: AppRadius.full,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.full,
        child: Container(
          height: 34,
          padding: const EdgeInsets.symmetric(horizontal: Spacing.control),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: AppRadius.full,
            border: Border.all(
              color: selected ? c.primary : c.borderSubtle,
            ),
          ),
          child: AppText(
            label,
            type: AppTextType.label,
            color: selected ? c.primary : c.textSecondary,
            maxLines: 1,
          ),
        ),
      ),
    );
  }
}

/// Protocol card: severity/site/applied summary when collapsed, pathogens +
/// criteria + antibiotic combinations when expanded.
class _TreatmentProtocolCard extends StatefulWidget {
  const _TreatmentProtocolCard({required this.item});

  final TreatmentProtocol item;

  @override
  State<_TreatmentProtocolCard> createState() =>
      _TreatmentProtocolCardState();
}

class _TreatmentProtocolCardState extends State<_TreatmentProtocolCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final c = context.respiraColors;
    final l10n = context.l10n;
    final item = widget.item;
    final pathogenNames = item.pathogens.map((p) => p.name).join(' · ');

    return AppSurface(
      padding: const EdgeInsets.symmetric(
        horizontal: Spacing.group,
        vertical: Spacing.control,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => setState(() => _expanded = !_expanded),
            borderRadius: AppRadius.sm,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Wrap(
                        spacing: Spacing.xxs,
                        runSpacing: Spacing.xxs,
                        children: [
                          _Badge(
                            label: item.severity.label(l10n),
                            background: _severityBackground(context, item.severity),
                            foreground: _severityForeground(context, item.severity),
                          ),
                          _Badge(
                            label: item.treatmentSite.label(l10n),
                            background: c.surfaceSecondary,
                            foreground: c.textSecondary,
                          ),
                          _Badge(
                            label: item.isApplied
                                ? l10n.treatmentProtocolApplied
                                : l10n.treatmentProtocolNotApplied,
                            background:
                                item.isApplied ? c.successSoft : c.surfaceTertiary,
                            foreground:
                                item.isApplied ? c.success : c.textSecondary,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: Spacing.inline),
                    AnimatedRotation(
                      turns: _expanded ? 0.5 : 0,
                      duration: const Duration(milliseconds: 200),
                      child: AppIcon(
                        LucideIcons.chevronDown,
                        size: ControlSize.iconBase,
                        color: c.iconMuted,
                      ),
                    ),
                  ],
                ),
                if (pathogenNames.isNotEmpty) ...[
                  const SizedBox(height: Spacing.xxs),
                  AppText(
                    pathogenNames,
                    type: AppTextType.bodyMedium,
                    fontWeight: FontWeight.w600,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
                const SizedBox(height: Spacing.xxxs),
                AppText(
                  _footerLabel(item, l10n),
                  type: AppTextType.caption,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 200),
            alignment: Alignment.topCenter,
            child: _expanded
                ? Padding(
                    padding: const EdgeInsets.only(top: Spacing.control),
                    child: _ProtocolDetails(item: item),
                  )
                : const SizedBox(width: double.infinity),
          ),
        ],
      ),
    );
  }

  static String _footerLabel(TreatmentProtocol item, AppLocalizations l10n) {
    final version = item.version.isEmpty
        ? ''
        : l10n.commonVersion(item.version);
    final publisher = item.publisher.isEmpty
        ? ''
        : '${l10n.treatmentProtocolPublisher}: ${item.publisher}';
    final parts = [version, publisher].where((part) => part.isNotEmpty);
    return parts.join(' · ');
  }

  static Color _severityBackground(BuildContext context, ProtocolSeverity value) {
    final c = context.respiraColors;
    return switch (value) {
      ProtocolSeverity.mild => c.successSoft,
      ProtocolSeverity.moderate => c.warningSoft,
      ProtocolSeverity.severe => c.errorSoft,
      ProtocolSeverity.unknown => c.surfaceSecondary,
    };
  }

  static Color _severityForeground(BuildContext context, ProtocolSeverity value) {
    final c = context.respiraColors;
    return switch (value) {
      ProtocolSeverity.mild => c.success,
      ProtocolSeverity.moderate => c.warning,
      ProtocolSeverity.severe => c.error,
      ProtocolSeverity.unknown => c.textSecondary,
    };
  }
}

class _ProtocolDetails extends StatelessWidget {
  const _ProtocolDetails({required this.item});

  final TreatmentProtocol item;

  @override
  Widget build(BuildContext context) {
    final c = context.respiraColors;
    final l10n = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _DetailsSection(
          label: l10n.treatmentProtocolPathogens,
          child: item.pathogens.isEmpty
              ? AppText(l10n.commonNoData, type: AppTextType.caption)
              : Wrap(
                  spacing: Spacing.xxs,
                  runSpacing: Spacing.xxs,
                  children: [
                    for (final pathogen in item.pathogens)
                      _Badge(
                        label: pathogen.name,
                        background: c.surfaceSecondary,
                        foreground: c.textPrimary,
                      ),
                  ],
                ),
        ),
        const SizedBox(height: Spacing.control),
        _DetailsSection(
          label: l10n.treatmentProtocolCriteria,
          child: item.criteria.isEmpty
              ? AppText(l10n.commonNoData, type: AppTextType.caption)
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var i = 0; i < item.criteria.length; i++) ...[
                      if (i > 0) const SizedBox(height: Spacing.xxs),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            item.criteria[i].name,
                            type: AppTextType.caption,
                            color: c.textPrimary,
                          ),
                          if (item.criteria[i].formula.isNotEmpty)
                            AppText(
                              item.criteria[i].formula,
                              type: AppTextType.caption,
                              color: c.textSecondary,
                            ),
                        ],
                      ),
                    ],
                  ],
                ),
        ),
        const SizedBox(height: Spacing.control),
        _DetailsSection(
          label: l10n.treatmentProtocolCombinations,
          child: item.treatments.isEmpty
              ? AppText(l10n.commonNoData, type: AppTextType.caption)
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var i = 0; i < item.treatments.length; i++) ...[
                      if (i > 0) const SizedBox(height: Spacing.xxs),
                      _CombinationRow(
                        index: i + 1,
                        antibiotics: item.treatments[i],
                      ),
                    ],
                  ],
                ),
        ),
      ],
    );
  }
}

class _DetailsSection extends StatelessWidget {
  const _DetailsSection({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          label,
          type: AppTextType.label,
          color: context.respiraColors.textPrimary,
        ),
        const SizedBox(height: Spacing.xxs),
        child,
      ],
    );
  }
}

class _CombinationRow extends StatelessWidget {
  const _CombinationRow({required this.index, required this.antibiotics});

  final int index;
  final List<ProtocolAntibiotic> antibiotics;

  @override
  Widget build(BuildContext context) {
    final c = context.respiraColors;
    final names = antibiotics.map((a) => a.name).join(' + ');

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: Spacing.control,
        vertical: Spacing.xxs,
      ),
      decoration: BoxDecoration(
        color: c.surfaceSecondary,
        borderRadius: AppRadius.sm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            '$index. $names',
            type: AppTextType.caption,
            color: c.textPrimary,
          ),
          if (antibiotics.any((a) => a.classification.isNotEmpty))
            AppText(
              antibiotics
                  .where((a) => a.classification.isNotEmpty)
                  .map((a) => '${a.name}: ${a.classification}')
                  .join(' · '),
              type: AppTextType.caption,
              color: c.textSecondary,
            ),
        ],
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({
    required this.label,
    required this.background,
    required this.foreground,
  });

  final String label;
  final Color background;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: background,
        borderRadius: AppRadius.full,
      ),
      child: AppText(
        label,
        type: AppTextType.label,
        color: foreground,
        maxLines: 1,
      ),
    );
  }
}
