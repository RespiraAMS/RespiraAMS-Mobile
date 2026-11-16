import 'package:dio/dio.dart';

import '../../../core/network/api_response.dart';
import '../../../core/network/pagination_dto.dart';
import '../models/analysis_report.dart';

/// Client of `GET /analysis/reports` (Respira.Analysis).
///
/// Reports are immutable snapshots: the list returns summary numbers only,
/// the detail returns the per-doctor / per-medicine breakdown. Creating,
/// deleting and exporting reports is out of scope for the mobile app.
class AnalysisService {
  AnalysisService(this._dio);

  final Dio _dio;

  /// `GET /analysis/reports` — paged snapshots, newest first.
  ///
  /// `page` starts at 1 and `size` must be within 1–100. Doctors are scoped
  /// to their own reports by the backend, so [doctorId] is only useful for
  /// Admin / HeadDepartmentDoctor accounts.
  Future<Paged<AnalysisReportListItem>> getReports({
    int page = 1,
    int size = 10,
    String? doctorId,
    String? searchTerm,
  }) async {
    final res = await _dio.get(
      '/analysis/reports',
      queryParameters: {
        'page': page,
        'size': size,
        if (doctorId != null && doctorId.isNotEmpty) 'doctorId': doctorId,
        if (searchTerm != null && searchTerm.trim().isNotEmpty)
          'searchTerm': searchTerm.trim(),
      },
    );
    final json = unwrapEnvelope(res);
    return Paged.fromJson(json, AnalysisReportListItem.fromJson);
  }

  /// `GET /analysis/reports/{analysisId}` — full snapshot.
  Future<AnalysisReport> getReport(String analysisId) async {
    final res = await _dio.get('/analysis/reports/$analysisId');
    return unwrapData(res, AnalysisReport.fromJson);
  }
}
