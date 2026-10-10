import 'package:dio/dio.dart';
import '../../../core/network/api_client.dart';
import '../models/suspected_cause.dart';
import '../models/pathogen_summary.dart';

class PaginatedSuspectedCauseResponse {
  final List<SuspectedCause> items;
  final bool hasNextPage;

  PaginatedSuspectedCauseResponse({required this.items, required this.hasNextPage});
}

class SuspectedCauseRepository {
  final ApiClient apiClient;

  SuspectedCauseRepository({required this.apiClient});

  Future<PaginatedSuspectedCauseResponse> fetchSuspectedCauses({
    int page = 1,
    int pageSize = 10,
    String? pathogenId,
    String? severity,
    String? treatmentSite,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page,
        'pageSize': pageSize,
      };

      if (pathogenId != null) queryParams['PathogenId'] = pathogenId;
      if (severity != null) queryParams['Severity'] = severity;
      if (treatmentSite != null) queryParams['TreatmentSite'] = treatmentSite;

      final response = await apiClient.dio.get(
        '/suspected-causes',
        queryParameters: queryParams,
      );

      final Map<String, dynamic> responseBody = response.data;
      final Map<String, dynamic> data = responseBody['data'] ?? {};
      
      final List<dynamic> itemsJson = data['items'] ?? [];
      final bool hasNext = data['metadata']?['hasNextPage'] ?? false;

      return PaginatedSuspectedCauseResponse(
        items: itemsJson.map((item) => SuspectedCause.fromJson(item)).toList(),
        hasNextPage: hasNext,
      );
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception('Lỗi server: ${e.response?.statusCode}');
      } else {
        throw Exception('Lỗi kết nối mạng: Vui lòng kiểm tra internet');
      }
    } catch (e) {
      throw Exception('Lỗi xử lý dữ liệu: $e');
    }
  }

  Future<List<PathogenSummary>> fetchPathogensList() async {
    try {
      final response = await apiClient.dio.get('/pathogens/list');
      
      final Map<String, dynamic> responseBody = response.data;
      final Map<String, dynamic> data = responseBody['data'] ?? {};
      final List<dynamic> pathogensJson = data['pathogens'] ?? [];

      return pathogensJson.map((item) => PathogenSummary.fromJson(item)).toList();
    } catch (e) {
      // Bắt mọi lỗi để không crash ứng dụng nếu filter hỏng
      throw Exception('Không tải được danh sách tác nhân');
    }
  }
}