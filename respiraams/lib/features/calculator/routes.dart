import 'package:go_router/go_router.dart';

import 'models/calculator.dart';
import 'screens/calculator_detail_screen.dart';
import 'screens/calculator_list_screen.dart';

class CalculatorRoutes {
  static const list = '/calculators';
  static const curb65 = '/calculators/curb-65';
  static const egfr = '/calculators/egfr';
  static const crcl = '/calculators/crcl';
  static const bmi = '/calculators/bmi';
  static const qsofa = '/calculators/qsofa';

  static String pathFor(CalculatorId id) => switch (id) {
        CalculatorId.curb65 => curb65,
        CalculatorId.egfr => egfr,
        CalculatorId.crcl => crcl,
        CalculatorId.bmi => bmi,
        CalculatorId.qsofa => qsofa,
      };
}

final List<RouteBase> calculatorRoutes = [
  GoRoute(
    path: CalculatorRoutes.list,
    builder: (context, state) => const CalculatorListScreen(),
  ),
  for (final id in CalculatorId.values)
    GoRoute(
      path: CalculatorRoutes.pathFor(id),
      builder: (context, state) => CalculatorDetailScreen(calculator: id),
    ),
];
