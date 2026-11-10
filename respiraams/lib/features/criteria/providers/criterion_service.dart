import 'package:dio/dio.dart';
import '../../../core/network/api_client.dart';
import '../models/criterion.dart';

class PaginatedCriterionResponse {
  final List<Criterion> items;
  final bool hasNextPage;

  PaginatedCriterionResponse({required this.items, required this.hasNextPage});
}

class CriterionRepository {
  final ApiClient apiClient;

  CriterionRepository({required this.apiClient});

  Future<PaginatedCriterionResponse> fetchCriteria({
    int page = 1,
    int pageSize = 10,
    String? name,
  }) async {
    try {
      // `GET /criteria` has no search endpoint; only page/size are supported.
      // Free-text matching is applied client-side by [CriterionProvider].
      final queryParams = <String, dynamic>{
        'page': page,
        'size': pageSize,
      };

      final response = await apiClient.dio.get(
        '/criteria',
        queryParameters: queryParams,
      );

      final Map<String, dynamic> responseBody = response.data;
      final Map<String, dynamic> data = responseBody['data'] ?? {};
      
      final List<dynamic> itemsJson = data['items'] ?? [];
      final bool hasNext = data['metadata']?['hasNextPage'] ?? false;

      return PaginatedCriterionResponse(
        items: itemsJson.map((item) => Criterion.fromJson(item)).toList(),
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
}