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
      final queryParams = <String, dynamic>{
        'page': page,
        'pageSize': pageSize,
      };

      if (name != null && name.trim().isNotEmpty) {
        queryParams['name'] = name.trim();
      }

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
        throw Exception('Lỗi kết nối mạng: Vui lòng kiểm tra internet');
      }
    } catch (e) {
      throw Exception('Lỗi xử lý dữ liệu: $e');
    }
  }
}