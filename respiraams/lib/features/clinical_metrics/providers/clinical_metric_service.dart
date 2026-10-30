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
    bool? isApplied,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page,
        'pageSize': pageSize,
      };

      if (isApplied != null) queryParams['IsApplied'] = isApplied;

      final response = await apiClient.dio.get(
        '/clinical-metrics',
        queryParameters: queryParams,
      );

      return _parseResponse(response);
    } on DioException catch (e) {
      throw _handleError(e);
    } catch (e) {
      throw Exception('Lỗi xử lý dữ liệu: $e');
    }
  }

  Future<PaginatedMetricResponse> searchMetrics({
    int page = 1,
    int pageSize = 10,
    required String searchTerm,
  }) async {
    try {
      final response = await apiClient.dio.get(
        '/clinical-metrics/search',
        queryParameters: {
          'page': page,
          'pageSize': pageSize,
          'SearchTerm': searchTerm,
        },
      );

      return _parseResponse(response);
    } on DioException catch (e) {
      throw _handleError(e);
    } catch (e) {
      throw Exception('Lỗi xử lý dữ liệu: $e');
    }
  }

  PaginatedMetricResponse _parseResponse(Response response) {
    final Map<String, dynamic> responseBody = response.data;
    final Map<String, dynamic> data = responseBody['data'] ?? {};
    
    final List<dynamic> itemsJson = data['items'] ?? [];
    final bool hasNext = data['metadata']?['hasNextPage'] ?? false;

    return PaginatedMetricResponse(
      items: itemsJson.map((item) => ClinicalMetric.fromJson(item)).toList(),
      hasNextPage: hasNext,
    );
  }

  Exception _handleError(DioException e) {
    if (e.response != null) {
      return Exception('Lỗi server: ${e.response?.statusCode}');
    }
    return Exception('Lỗi kết nối mạng: Vui lòng kiểm tra internet');
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