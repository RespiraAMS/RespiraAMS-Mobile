import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/navigation/app_nav_items.dart';
import '../../../../design_system/design_system.dart';
import '../../../../l10n/l10n.dart';
import '../../calculator/routes.dart';
import '../../patient/routes.dart';
import '../../settings/settings_menu_button.dart';
import '../../statistics/routes.dart';
import '../providers/lookup_data_provider.dart';
import '../widgets/category_grid_item.dart';

/// Route `/lookup` — the 'Tra cứu' bottom-nav tab: medical lookup catalogue.
class MedicalLookupScreen extends StatelessWidget {
  const MedicalLookupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.respiraColors;
    final l10n = context.l10n;
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
                  const SizedBox(width: Spacing.control),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          l10n.lookupTitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TypographyTokens.h3(context)
                              .copyWith(color: c.textPrimary),
                        ),
                        const SizedBox(height: 2),
                        AppText(
                          l10n.lookupSubtitle,
                          type: AppTextType.caption,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: Spacing.section),
              Text(
                l10n.lookupCategories,
                style: TypographyTokens.bodyLarge(context).copyWith(
                  fontWeight: FontWeight.w700,
                  color: c.textPrimary,
                ),
              ),
              const SizedBox(height: Spacing.control),
              Expanded(
                child: ListView(
                  children: [
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 12,
                        childAspectRatio: 171 / 112,
                      ),
                      itemCount: LookupDataProvider.categories.length,
                      itemBuilder: (context, index) {
                        return CategoryGridItem(
                          category: LookupDataProvider.categories[index],
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: Spacing.inline),
              AppBottomNavigation(
                items: navItems,
                activeIndex: 1,
                onTap: (index) {
                  if (index == 0) {
                    context.go(PatientRoutes.list);
                  } else if (index == 2) {
                    // Diagnosis entry: create a patient, then continue with
                    // the empirical-treatment flow for them.
                    context.push(PatientRoutes.addPatientForDiagnosis);
                  } else if (index == 3) {
                    context.push(CalculatorRoutes.list);
                  } else if (index == 4) {
                    context.push(StatisticsRoutes.overview);
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
