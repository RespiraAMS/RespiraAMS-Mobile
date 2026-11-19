import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/navigation/app_nav_items.dart';
import '../../../../design_system/design_system.dart';
import '../../../../l10n/l10n.dart';
import '../../../../features/calculator/routes.dart';
import '../../../../features/analysis/analysis_routes.dart';
import '../../../../features/lookup/lookup_route.dart';
import '../../../../features/patient/routes.dart';
import '../../settings/settings_menu_button.dart';
import '../models/statistics_view.dart';
import '../providers/statistics_provider.dart';
import '../widgets/breakdown_row_widget.dart';
import '../widgets/distribution_bars_widget.dart';
import '../widgets/kpi_tile_widget.dart';

/// Route `/statistics` — treatment activity overview (bottom-nav tab 5).
///
/// Every number comes from the real API: `GET /patients` (roster KPIs, age and
/// outcome distributions) and `GET /analysis/reports` (latest adherence
/// report inside the selected period).
class StatisticsScreen extends ConsumerWidget {
  const StatisticsScreen({super.key});

  void _showTabPlaceholder(BuildContext context, String label) {
    showAppToast(context, context.l10n.commonTabComingSoon(label));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final period = ref.watch(statisticsPeriodControllerProvider);
    final periodController =
        ref.read(statisticsPeriodControllerProvider.notifier);
    final view = ref.watch(statisticsViewProvider);

    final navItems = appBottomNavItems(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            Spacing.group,
            Spacing.inline,
            Spacing.group,
            Spacing.group,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const _Header(),
              const SizedBox(height: Spacing.section),
              AppSegmentedTabs<PeriodRange>(
                segments: [
                  for (final range in PeriodRange.values)
                    (range, range.label(l10n)),
                ],
                selected: period,
                onChanged: periodController.setPeriod,
              ),
              const SizedBox(height: Spacing.section),
              Expanded(
                child: view.when(
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (_, _) => _ErrorState(
                    onRetry: () => ref.invalidate(statisticsViewProvider),
                  ),
                  data: (data) => _Content(view: data),
                ),
              ),
              const SizedBox(height: Spacing.inline),
              AppBottomNavigation(
                items: navItems,
                activeIndex: 4,
                onTap: (index) {
                  if (index == 0) {
                    context.go(PatientRoutes.list);
                  } else if (index == 1) {
                    // Tra cứu entry: medical lookup catalogue.
                    context.push(LookupRoutes.lookup);
                  } else if (index == 2) {
                    // Diagnosis entry: create a patient, then continue with
                    // the empirical-treatment flow for them.
                    context.push(PatientRoutes.addPatientForDiagnosis);
                  } else if (index == 3) {
                    context.push(CalculatorRoutes.list);
                  } else if (index != 4) {
                    _showTabPlaceholder(context, navItems[index].label);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends ConsumerWidget {
  const _Header();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = context.respiraColors;
    final l10n = context.l10n;

    return Row(
      children: [
        const SettingsMenuButton(),
        const SizedBox(width: Spacing.group),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                l10n.statisticsTitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style:
                    TypographyTokens.h3(context).copyWith(color: c.textPrimary),
              ),
              const SizedBox(height: 2),
              AppText(l10n.statisticsSubtitle,
                  type: AppTextType.caption, maxLines: 1),
            ],
          ),
        ),
      ],
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({required this.view});

  final StatisticsView view;

  @override
  Widget build(BuildContext context) {
    final c = context.respiraColors;
    final l10n = context.l10n;
    final maxOutcomeCount = view.outcomes.fold<int>(
      1,
      (max, stat) => stat.count > max ? stat.count : max,
    );

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final kpi in view.kpis) ...[
                if (kpi != view.kpis.first)
                  const SizedBox(width: Spacing.inline),
                Expanded(child: KpiTileWidget(stat: kpi)),
              ],
            ],
          ),
          const SizedBox(height: Spacing.section),
          Text(
            l10n.statisticsAgeDistribution,
            style: TypographyTokens.bodyMedium(context)
                .copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: Spacing.inline),
          DistributionBarsWidget(bars: view.ageBars),
          const SizedBox(height: Spacing.section),
          Text(
            l10n.statisticsOutcomes,
            style: TypographyTokens.bodyLarge(context)
                .copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: Spacing.inline),
          Container(
            padding: const EdgeInsets.all(Spacing.group),
            decoration: BoxDecoration(
              color: c.surface,
              borderRadius: AppRadius.md,
              border: Border.all(color: c.borderSubtle),
            ),
            child: view.outcomes.isEmpty
                ? AppText(l10n.statisticsEmpty, type: AppTextType.caption)
                : Column(
                    children: [
                      for (final stat in view.outcomes) ...[
                        if (stat != view.outcomes.first)
                          const SizedBox(height: Spacing.block),
                        BreakdownRowWidget(
                          stat: stat,
                          label: _outcomeLabel(stat.key, l10n),
                          maxCount: maxOutcomeCount,
                        ),
                      ],
                    ],
                  ),
          ),
          const SizedBox(height: Spacing.section),
          Text(
            l10n.statisticsLatestReport,
            style: TypographyTokens.bodyLarge(context)
                .copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: Spacing.inline),
          _LatestReportCard(report: view.latestReport),
          const SizedBox(height: Spacing.section),
          const _AnalysisReportEntry(),
        ],
      ),
    );
  }
}

class _LatestReportCard extends StatelessWidget {
  const _LatestReportCard({required this.report});

  final LatestReport? report;

  @override
  Widget build(BuildContext context) {
    final c = context.respiraColors;
    final l10n = context.l10n;
    final value = report;

    if (value == null) {
      return Container(
        padding: const EdgeInsets.all(Spacing.group),
        decoration: BoxDecoration(
          color: c.surface,
          borderRadius: AppRadius.md,
          border: Border.all(color: c.borderSubtle),
        ),
        child: AppText(
          l10n.statisticsLatestReportEmpty,
          type: AppTextType.caption,
        ),
      );
    }

    final rate = (value.adherenceRate * 100).round();

    return Material(
      color: c.surface,
      borderRadius: AppRadius.md,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: value.analysisId.isEmpty
            ? null
            : () => context.push(AnalysisRoutes.detailPath(value.analysisId)),
        child: Container(
          padding: const EdgeInsets.all(Spacing.group),
          decoration: BoxDecoration(
            borderRadius: AppRadius.md,
            border: Border.all(color: c.borderSubtle),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      l10n.statisticsAdherenceRate,
                      style: TypographyTokens.bodyMedium(context)
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                  AppText(
                    '$rate%',
                    type: AppTextType.bodyMedium,
                    fontWeight: FontWeight.w700,
                    color: c.primary,
                  ),
                ],
              ),
              const SizedBox(height: Spacing.control),
              Row(
                children: [
                  Expanded(
                    child: _ReportMetric(
                      label: l10n.statisticsTreatmentPlans,
                      value: value.totalTreatmentPlans,
                    ),
                  ),
                  Expanded(
                    child: _ReportMetric(
                      label: l10n.statisticsReportPatients,
                      value: value.totalPatients,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: Spacing.control),
              Row(
                children: [
                  Expanded(
                    child: AppText(
                      l10n.statisticsOpenReport,
                      type: AppTextType.caption,
                      color: c.primary,
                    ),
                  ),
                  Icon(
                    LucideIcons.chevronRight,
                    size: ControlSize.iconLg,
                    color: c.iconMuted,
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

class _ReportMetric extends StatelessWidget {
  const _ReportMetric({required this.label, required this.value});

  final String label;
  final int value;

  @override
  Widget build(BuildContext context) {
    final c = context.respiraColors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        AppText(label, type: AppTextType.caption, maxLines: 1),
        const SizedBox(height: Spacing.xxxs),
        Text(
          '$value',
          style: TypographyTokens.bodyMedium(context).copyWith(
            fontWeight: FontWeight.w700,
            color: c.textPrimary,
          ),
        ),
      ],
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppText(l10n.commonLoadDataError, type: AppTextType.caption),
          const SizedBox(height: Spacing.control),
          AppButton(
            label: l10n.commonRetry,
            type: AppButtonType.outline,
            size: AppButtonSize.medium,
            onPressed: onRetry,
          ),
        ],
      ),
    );
  }
}

String _outcomeLabel(String key, AppLocalizations l10n) => switch (key) {
      'InTreatment' => l10n.patientStatusTreating,
      'Recovered' => l10n.patientStatusRecovered,
      'Death' => l10n.patientStatusDeceased,
      'OutOfScope' => l10n.patientStatusOutOfScope,
      _ => key,
    };

class _AnalysisReportEntry extends StatelessWidget {
  const _AnalysisReportEntry();

  @override
  Widget build(BuildContext context) {
    final c = context.respiraColors;
    final l10n = context.l10n;

    return Material(
      color: c.surface,
      borderRadius: AppRadius.lg,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.push(AnalysisRoutes.list),
        child: Container(
          padding: const EdgeInsets.all(Spacing.group),
          decoration: BoxDecoration(
            borderRadius: AppRadius.lg,
            border: Border.all(color: c.borderSubtle),
          ),
          child: Row(
            children: [
              Container(
                width: ControlSize.touchTargetMin,
                height: ControlSize.touchTargetMin,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: c.primarySoft,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  LucideIcons.clipboardList,
                  size: ControlSize.iconLg,
                  color: c.primary,
                ),
              ),
              const SizedBox(width: Spacing.control),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      l10n.analysisEntryTitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TypographyTokens.bodyMedium(context).copyWith(
                        fontWeight: FontWeight.w600,
                        color: c.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    AppText(
                      l10n.analysisEntrySubtitle,
                      type: AppTextType.caption,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: Spacing.inline),
              Icon(
                LucideIcons.chevronRight,
                size: ControlSize.iconLg,
                color: c.iconMuted,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
