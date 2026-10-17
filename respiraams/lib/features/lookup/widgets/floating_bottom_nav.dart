import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../design_system/design_system.dart';
import '../../calculator/routes.dart';
import '../../patient/routes.dart';
import '../../statistics/routes.dart';

/// Bottom navigation of the Tra cứu (lookup) screens.
///
/// Floating-pill variant of the app-wide 5-tab layout; Tra cứu is active
/// here, so tapping it is a no-op.
class FloatingBottomNav extends StatelessWidget {
  const FloatingBottomNav({super.key});

  static const _activeIndex = 1;

  static const _navItems = [
    AppBottomNavItem(icon: LucideIcons.users, label: 'Bệnh nhân'),
    AppBottomNavItem(icon: LucideIcons.search, label: 'Tra cứu'),
    AppBottomNavItem(icon: LucideIcons.stethoscope, label: 'Chẩn đoán'),
    AppBottomNavItem(icon: LucideIcons.calculator, label: 'Máy tính'),
    AppBottomNavItem(icon: LucideIcons.barChart2, label: 'Thống kê'),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
      child: AppBottomNavigation(
        items: _navItems,
        activeIndex: _activeIndex,
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
    );
  }
}
