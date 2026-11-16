import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';

import '../../../../design_system/design_system.dart';
import '../../../../l10n/l10n.dart';
import '../models/antibiogram.dart';
import '../providers/antibiogram_provider.dart';

/// Route `/lookup/antibiograms` — MIC susceptibility catalogue.
///
/// Each card is collapsed by default and expands in place (no detail
/// endpoint exists on the backend).
class AntibiogramListScreen extends StatefulWidget {
  const AntibiogramListScreen({super.key});

  @override
  State<AntibiogramListScreen> createState() => _AntibiogramListScreenState();
}

class _AntibiogramListScreenState extends State<AntibiogramListScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AntibiogramProvider>().fetchPage();
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
      context.read<AntibiogramProvider>().fetchPage();
    }
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      if (mounted) context.read<AntibiogramProvider>().search(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    final c = context.respiraColors;
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: c.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Spacing.group,
                vertical: 8,
              ),
              child: AppAppBar(
                title: l10n.antibiogramTitle,
                subtitle: l10n.antibiogramSubtitle,
                onBack: () => Navigator.pop(context),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Spacing.group),
              child: TextField(
                controller: _searchController,
                onChanged: _onSearchChanged,
                decoration: InputDecoration(
                  hintText: l10n.antibiogramSearchHint,
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
            _MicFilterRow(
              selected: context.watch<AntibiogramProvider>().micFilter,
            ),
            const SizedBox(height: Spacing.control),
            Expanded(
              child: Consumer<AntibiogramProvider>(
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

                  if (provider.items.isEmpty && provider.isLoading) {
                    return Center(
                      child: CircularProgressIndicator(color: c.primary),
                    );
                  }

                  if (provider.items.isEmpty) {
                    return Center(
                      child: AppText(
                        provider.hasLoadedItems
                            ? l10n.commonNoResults
                            : l10n.antibiogramEmpty,
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
                      itemCount:
                          provider.items.length + (provider.hasMore ? 1 : 0),
                      separatorBuilder: (_, _) =>
                          const SizedBox(height: Spacing.control),
                      itemBuilder: (context, index) {
                        if (index == provider.items.length) {
                          return Padding(
                            padding: const EdgeInsets.all(Spacing.group),
                            child: Center(
                              child:
                                  CircularProgressIndicator(color: c.primary),
                            ),
                          );
                        }

                        return _AntibiogramCard(item: provider.items[index]);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// MIC filter chips ("Tất cả" + the three categories).
class _MicFilterRow extends StatelessWidget {
  const _MicFilterRow({required this.selected});

  final MicCategory? selected;

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
            onTap: () => context.read<AntibiogramProvider>().setMicFilter(null),
          ),
          for (final category in const [
            MicCategory.susceptible,
            MicCategory.intermediate,
            MicCategory.resistant,
          ]) ...[
            const SizedBox(width: Spacing.inline),
            _FilterChip(
              label: category.label(l10n),
              selected: selected == category,
              onTap: () =>
                  context.read<AntibiogramProvider>().setMicFilter(category),
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

/// Antibiogram card: pathogen + MIC when collapsed, antibiotic chips when
/// expanded.
class _AntibiogramCard extends StatefulWidget {
  const _AntibiogramCard({required this.item});

  final Antibiogram item;

  @override
  State<_AntibiogramCard> createState() => _AntibiogramCardState();
}

class _AntibiogramCardState extends State<_AntibiogramCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final c = context.respiraColors;
    final l10n = context.l10n;
    final item = widget.item;

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
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        item.pathogen.name,
                        type: AppTextType.bodyMedium,
                        fontWeight: FontWeight.w600,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: Spacing.xxs),
                      Row(
                        children: [
                          _MicBadge(category: item.micCategory),
                          const SizedBox(width: Spacing.inline),
                          Expanded(
                            child: AppText(
                              l10n.antibiogramAntibiotics(
                                item.antibiotics.length,
                              ),
                              type: AppTextType.caption,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
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
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 200),
            alignment: Alignment.topCenter,
            child: _expanded
                ? Padding(
                    padding: const EdgeInsets.only(top: Spacing.control),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (item.antibiotics.isEmpty)
                          AppText(
                            l10n.commonNoData,
                            type: AppTextType.caption,
                          )
                        else
                          Wrap(
                            spacing: Spacing.xxs,
                            runSpacing: Spacing.xxs,
                            children: [
                              for (final antibiotic in item.antibiotics)
                                _AntibioticChip(antibiotic: antibiotic),
                            ],
                          ),
                      ],
                    ),
                  )
                : const SizedBox(width: double.infinity),
          ),
        ],
      ),
    );
  }
}

class _MicBadge extends StatelessWidget {
  const _MicBadge({required this.category});

  final MicCategory category;

  @override
  Widget build(BuildContext context) {
    final c = context.respiraColors;
    final (Color bg, Color fg) = switch (category) {
      MicCategory.susceptible => (c.successSoft, c.success),
      MicCategory.intermediate => (c.warningSoft, c.warning),
      MicCategory.resistant => (c.errorSoft, c.error),
      MicCategory.unknown => (c.surfaceSecondary, c.textSecondary),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: bg, borderRadius: AppRadius.full),
      child: AppText(
        category.label(context.l10n),
        type: AppTextType.label,
        color: fg,
        maxLines: 1,
      ),
    );
  }
}

class _AntibioticChip extends StatelessWidget {
  const _AntibioticChip({required this.antibiotic});

  final AntibiogramAntibiotic antibiotic;

  @override
  Widget build(BuildContext context) {
    final c = context.respiraColors;
    final classification = antibiotic.classification;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: c.surfaceSecondary,
        borderRadius: AppRadius.full,
        border: Border.all(color: c.borderSubtle),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: AppText(
              antibiotic.name,
              type: AppTextType.caption,
              color: c.textPrimary,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (classification.isNotEmpty) ...[
            const SizedBox(width: Spacing.xxxs),
            AppText(
              classification,
              type: AppTextType.label,
              color: c.iconPrimary,
              maxLines: 1,
            ),
          ],
        ],
      ),
    );
  }
}
