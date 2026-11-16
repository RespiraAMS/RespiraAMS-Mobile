import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:respiraams/features/calculator/routes.dart';
import 'package:respiraams/features/lookup/lookup_route.dart';
import 'package:respiraams/features/patient/routes.dart';
import 'package:respiraams/features/patient/widgets/section_label_widget.dart';
import 'package:respiraams/features/settings/settings_menu_button.dart';
import 'package:respiraams/features/statistics/routes.dart';

import '../../../../core/navigation/app_nav_items.dart';
import '../../../../design_system/design_system.dart';
import '../../../../l10n/l10n.dart';
import '../models/calculator.dart';
import '../providers/calculator_providers.dart';
import '../widgets/calculator_entry_row_widget.dart';

/// Route `/calculators` — the 'Máy tính' bottom-nav tab: roster of
/// clinical calculators.
class CalculatorListScreen extends ConsumerWidget {
  const CalculatorListScreen({super.key});

  void _showTabPlaceholder(BuildContext context, String label) {
    showAppToast(context, context.l10n.commonTabComingSoon(label));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = context.respiraColors;
    final l10n = context.l10n;
    final entries = ref.watch(calculatorListProvider);

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
              Row(
                children: [
                  const SettingsMenuButton(),
                  const SizedBox(width: Spacing.group),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          l10n.calculatorTitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TypographyTokens.h3(context)
                              .copyWith(color: c.textPrimary),
                        ),
                        const SizedBox(height: 2),
                        AppText(l10n.calculatorSubtitle,
                            type: AppTextType.caption, maxLines: 1),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: Spacing.section),
              SectionLabelWidget(l10n.calculatorCommonTools),
              const SizedBox(height: Spacing.control),
              Expanded(
                child: ListView.separated(
                  itemCount: entries.length,
                  separatorBuilder: (_, _) =>
                      const SizedBox(height: Spacing.inline),
                  itemBuilder: (context, index) {
                    final entry = entries[index];
                    return CalculatorEntryRowWidget(
                      calculator: entry,
                      onTap: () {
                        if (entry == CalculatorId.curb65) {
                          context.push(CalculatorRoutes.curb65);
                        } else {
                          showAppToast(context,
                              l10n.calculatorComingSoon(entry.title));
                        }
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: Spacing.inline),
              AppBottomNavigation(
                items: navItems,
                activeIndex: 3,
                onTap: (index) {
                  if (index == 0) {
                    context.go(PatientRoutes.list);
                  } else if (index == 1) {
                    // Tra cứu entry: medical lookup catalogue.
                    context.push(LookupRoutes.lookup);
                  } else if (index == 2) {
                    context.push(PatientRoutes.addPatientForDiagnosis);
                  } else if (index == 4) {
                    context.push(StatisticsRoutes.overview);
                  } else if (index != 3) {
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
