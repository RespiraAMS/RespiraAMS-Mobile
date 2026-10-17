import 'package:dio/dio.dart';
import '../../../core/network/api_client.dart';
import '../models/clinical_metric.dart';

class PaginatedMetricResponse {
  final List<ClinicalMetric> items;
  final bool hasNextPage;

  PaginatedMetricResponse({required this.items, required this.hasNextPage});
}

class ClinicalMetricRepository {
  final ApiClient apiClient;

  ClinicalMetricRepository({required this.apiClient});

  Future<PaginatedMetricResponse> fetchMetrics({
    int page = 1,
    int pageSize = 10,
    String? name,
    String? code,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page,
        'pageSize': pageSize,
      };

      if (name != null && name.trim().isNotEmpty) queryParams['name'] = name.trim();
      if (code != null && code.trim().isNotEmpty) queryParams['code'] = code.trim();

      final response = await apiClient.dio.get(
        '/clinical-metrics',
        queryParameters: queryParams,
      );

      final Map<String, dynamic> responseBody = response.data;
      final Map<String, dynamic> data = responseBody['data'] ?? {};
      
      final List<dynamic> itemsJson = data['items'] ?? [];
      final bool hasNext = data['metadata']?['hasNextPage'] ?? false;

      return PaginatedMetricResponse(
        items: itemsJson.map((item) => ClinicalMetric.fromJson(item)).toList(),
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

  Future<ClinicalMetricDetail> fetchMetricDetail(String id) async {
    try {
      final response = await apiClient.dio.get('/clinical-metrics/$id');
      
      final Map<String, dynamic> responseBody = response.data;
      final Map<String, dynamic> data = responseBody['data'] ?? {};
      
      return ClinicalMetricDetail.fromJson(data);
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
}