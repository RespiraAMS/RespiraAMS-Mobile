import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';

import '../../../../design_system/design_system.dart';
import '../../../../l10n/l10n.dart';
import '../models/treatment_protocol.dart';
import '../providers/treatment_protocol_provider.dart';

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
                      contentPadding: const EdgeInsets.symmetric(vertical: 0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: TextStyle(color: c.textPrimary),
                  ),
                ),
                const SizedBox(height: Spacing.control),
                _FilterRow<ProtocolSeverity>(
                  values: const [
                    ProtocolSeverity.mild,
                    ProtocolSeverity.moderate,
                    ProtocolSeverity.severe,
                  ],
                  labelOf: (value) => value.label(l10n),
                  selected: provider.severityFilter,
                  onSelected: provider.setSeverityFilter,
                ),
                const SizedBox(height: Spacing.xxs),
                _FilterRow<ProtocolTreatmentSite>(
                  values: const [
                    ProtocolTreatmentSite.outpatient,
                    ProtocolTreatmentSite.inpatient,
                    ProtocolTreatmentSite.intensiveCareUnit,
                  ],
                  labelOf: (value) => value.label(l10n),
                  selected: provider.siteFilter,
                  onSelected: provider.setSiteFilter,
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

/// Horizontal chip row for one enum filter ("Tất cả" + values).
class _FilterRow<T> extends StatelessWidget {
  const _FilterRow({
    required this.values,
    required this.labelOf,
    required this.selected,
    required this.onSelected,
  });

  final List<T> values;
  final String Function(T value) labelOf;
  final T? selected;
  final ValueChanged<T?> onSelected;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: Spacing.group),
      child: Row(
        children: [
          _FilterChip(
            label: l10n.commonAll,
            selected: selected == null,
            onTap: () => onSelected(null),
          ),
          for (final value in values) ...[
            const SizedBox(width: Spacing.inline),
            _FilterChip(
              label: labelOf(value),
              selected: selected == value,
              onTap: () => onSelected(value),
            ),
          ],
        ],
      ),
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
