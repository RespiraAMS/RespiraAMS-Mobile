import 'package:go_router/go_router.dart';

import 'screens/analysis_report_detail_screen.dart';
import 'screens/analysis_report_list_screen.dart';

/// Typed path constants for the analysis feature.
class AnalysisRoutes {
  static const list = '/analysis';
  static const detail = '/analysis/detail';

  static String detailPath(String analysisId) => '$detail?id=$analysisId';
}

final List<RouteBase> analysisRoutes = [
  GoRoute(
    path: AnalysisRoutes.list,
    builder: (context, state) => const AnalysisReportListScreen(),
  ),
  GoRoute(
    path: AnalysisRoutes.detail,
    builder: (context, state) => AnalysisReportDetailScreen(
      analysisId: state.uri.queryParameters['id'],
    ),
  ),
];
