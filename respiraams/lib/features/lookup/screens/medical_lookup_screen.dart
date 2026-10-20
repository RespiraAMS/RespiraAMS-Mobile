import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../design_system/design_system.dart';
import '../../calculator/routes.dart';
import '../../patient/routes.dart';
import '../../statistics/routes.dart';
import '../providers/lookup_data_provider.dart';
import '../widgets/category_grid_item.dart';

/// Route `/lookup` — the 'Tra cứu' bottom-nav tab: medical lookup catalogue.
class MedicalLookupScreen extends StatelessWidget {
  const MedicalLookupScreen({super.key});

  static const _navItems = [
    AppBottomNavItem(icon: LucideIcons.users, label: 'Bệnh nhân'),
    AppBottomNavItem(icon: LucideIcons.search, label: 'Tra cứu'),
    AppBottomNavItem(icon: LucideIcons.stethoscope, label: 'Chẩn đoán'),
    AppBottomNavItem(icon: LucideIcons.calculator, label: 'Máy tính'),
    AppBottomNavItem(icon: LucideIcons.barChart2, label: 'Thống kê'),
  ];

  @override
  Widget build(BuildContext context) {
    final c = context.respiraColors;

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
                  const AppMenuButton(),
                  const SizedBox(width: Spacing.control),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Tra cứu',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TypographyTokens.h3(context)
                              .copyWith(color: c.textPrimary),
                        ),
                        const SizedBox(height: 2),
                        AppText(
                          'Tài liệu y tế dành cho bác sĩ',
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
                'Danh mục',
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
                items: _navItems,
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
