import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../design_system/design_system.dart';
import '../../../../l10n/l10n.dart';
import '../analysis_routes.dart';
import '../models/analysis_report.dart';
import '../providers/analysis_providers.dart';

/// Route `/analysis` — treatment analysis snapshots produced by
/// `Respira.Analysis`, entered from the statistics screen.
class AnalysisReportListScreen extends ConsumerStatefulWidget {
  const AnalysisReportListScreen({super.key});

  @override
  ConsumerState<AnalysisReportListScreen> createState() =>
      _AnalysisReportListScreenState();
}

class _AnalysisReportListScreenState
    extends ConsumerState<AnalysisReportListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = ref.read(analysisListProvider.notifier);
      if (ref.read(analysisListProvider).page == 1) {
        provider.loadNextPage();
      }
    });
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(analysisListProvider.notifier).loadNextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = context.respiraColors;
    final l10n = context.l10n;
    final state = ref.watch(analysisListProvider);

    if (state.errorMessage != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showAppToast(context, state.errorMessage!.localizedError(l10n));
        ref.read(analysisListProvider.notifier).clearError();
      });
    }

    final doctorNames = ref.watch(doctorNamesProvider).valueOrNull;

    return Scaffold(
      backgroundColor: c.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Spacing.group,
                vertical: Spacing.xxs,
              ),
              child: AppAppBar(
                title: l10n.analysisTitle,
                subtitle: l10n.analysisSubtitle,
                onBack: () => Navigator.pop(context),
              ),
            ),
            const SizedBox(height: Spacing.control),
            Expanded(child: _buildBody(state, doctorNames)),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(
    AnalysisListState state,
    Map<String, String>? doctorNames,
  ) {
    final c = context.respiraColors;
    final l10n = context.l10n;

    if (state.isEmpty && state.isLoading) {
      return Center(child: CircularProgressIndicator(color: c.primary));
    }

    if (state.isEmpty) {
      return RefreshIndicator(
        color: c.primary,
        onRefresh: ref.read(analysisListProvider.notifier).refresh,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.25),
            Center(
              child: AppText(l10n.analysisEmpty, color: c.textSecondary),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      color: c.primary,
      onRefresh: ref.read(analysisListProvider.notifier).refresh,
      child: ListView.separated(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(
          Spacing.group,
          Spacing.xxs,
          Spacing.group,
          Spacing.section,
        ),
        itemCount: state.items.length + (state.hasMore ? 1 : 0),
        separatorBuilder: (_, _) => const SizedBox(height: Spacing.control),
        itemBuilder: (context, index) {
          if (index == state.items.length) {
            return Padding(
              padding: const EdgeInsets.all(Spacing.group),
              child: Center(
                child: CircularProgressIndicator(color: c.primary),
              ),
            );
          }

          final item = state.items[index];
          return _ReportCard(
            item: item,
            doctorNames: doctorNames,
            onTap: () => context.push(AnalysisRoutes.detailPath(item.analysisId)),
          );
        },
      ),
    );
  }
}

class _ReportCard extends StatelessWidget {
  const _ReportCard({
    required this.item,
    required this.doctorNames,
    required this.onTap,
  });

  final AnalysisReportListItem item;
  final Map<String, String>? doctorNames;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.respiraColors;
    final l10n = context.l10n;

    return AppSurface(
      padding: const EdgeInsets.symmetric(
        horizontal: Spacing.group,
        vertical: Spacing.control,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.sm,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: AppText(
                    analysisDoctorLabel(item.doctorId, doctorNames, l10n),
                    type: AppTextType.bodyMedium,
                    fontWeight: FontWeight.w600,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: Spacing.inline),
                AppIcon(
                  LucideIcons.chevronRight,
                  size: ControlSize.iconLg,
                  color: c.iconMuted,
                ),
              ],
            ),
            const SizedBox(height: Spacing.xxs),
            Row(
              children: [
                AppIcon(
                  LucideIcons.calendarRange,
                  size: ControlSize.iconSm,
                  color: c.iconMuted,
                ),
                const SizedBox(width: Spacing.xxxs + 2),
                Expanded(
                  child: AppText(
                    '${l10n.analysisPeriod}: '
                    '${analysisDate(item.start)} → ${analysisDate(item.end)}',
                    type: AppTextType.caption,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
            const SizedBox(height: Spacing.control),
            Wrap(
              spacing: Spacing.xxs,
              runSpacing: Spacing.xxs,
              children: [
                _CountChip(
                  label: l10n.analysisAdherent,
                  count: item.totalAdherentPlans,
                  background: c.successSoft,
                  foreground: c.success,
                ),
                _CountChip(
                  label: l10n.analysisNonAdherent,
                  count: item.totalNonAdherentPlans,
                  background: c.errorSoft,
                  foreground: c.error,
                ),
                _CountChip(
                  label: l10n.analysisPendingReview,
                  count: item.totalPendingReviewPlans,
                  background: c.warningSoft,
                  foreground: c.warning,
                ),
              ],
            ),
            const SizedBox(height: Spacing.control),
            Row(
              children: [
                AppIcon(
                  LucideIcons.users,
                  size: ControlSize.iconSm,
                  color: c.iconMuted,
                ),
                const SizedBox(width: Spacing.xxxs + 2),
                Expanded(
                  child: AppText(
                    '${l10n.analysisPatientsCount(item.totalPatients)} · '
                    '${l10n.analysisPlansCount(item.totalTreatmentPlans)}',
                    type: AppTextType.caption,
                    color: c.textPrimary,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),
            AppText(
              l10n.analysisCreatedAt(analysisDateTime(item.createdAt)),
              type: AppTextType.caption,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

/// Doctor label shared by the list and the detail screen.
String analysisDoctorLabel(
  String? doctorId,
  Map<String, String>? doctorNames,
  AppLocalizations l10n,
) {
  if (doctorId == null || doctorId.isEmpty) return l10n.analysisAllDoctors;
  final name = doctorNames?[doctorId];
  if (name != null && name.isNotEmpty) return name;
  final short = doctorId.length > 8 ? doctorId.substring(0, 8) : doctorId;
  return l10n.analysisDoctorFallback(short);
}

class _CountChip extends StatelessWidget {
  const _CountChip({
    required this.label,
    required this.count,
    required this.background,
    required this.foreground,
  });

  final String label;
  final int count;
  final Color background;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: background,
        borderRadius: AppRadius.full,
      ),
      child: AppText(
        '$label: $count',
        type: AppTextType.label,
        color: foreground,
        maxLines: 1,
      ),
    );
  }
}
