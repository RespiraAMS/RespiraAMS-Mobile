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
      final search = (name ?? code ?? '').trim();
      final queryParams = <String, dynamic>{
        'page': page,
        'size': pageSize,
        if (search.isNotEmpty) 'searchTerm': search,
      };

      // Free-text search lives on `/clinical-metrics/search`.
      final response = await apiClient.dio.get(
        search.isEmpty ? '/clinical-metrics' : '/clinical-metrics/search',
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
        throw Exception('Network error: please check your connection');
      }
    } catch (e) {
      throw Exception('Failed to process data: $e');
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
        throw Exception('Network error: please check your connection');
      }
    } catch (e) {
      throw Exception('Failed to process data: $e');
    }
  }
}