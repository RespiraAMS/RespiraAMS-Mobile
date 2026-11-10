import 'package:dio/dio.dart';
import '../../../core/network/api_client.dart';
import '../models/pathogen.dart';

class PaginatedPathogenResponse {
  final List<Pathogen> items;
  final bool hasNextPage;

  PaginatedPathogenResponse({required this.items, required this.hasNextPage});
}

class PathogenRepository {
  final ApiClient apiClient;

  PathogenRepository({required this.apiClient});

  Future<PaginatedPathogenResponse> fetchPathogens({int page = 1, int pageSize = 10, String? name}) async {
    try {
      final search = name?.trim() ?? '';
      final queryParams = <String, dynamic>{
        'page': page,
        'size': pageSize,
        if (search.isNotEmpty) 'searchTerm': search,
      };
      // Free-text search lives on `/pathogens/search`; the paged endpoint
      // only supports the `isAtypical` filter.
      final response = await apiClient.dio.get(
        search.isEmpty ? '/pathogens' : '/pathogens/search',
        queryParameters: queryParams,
      );

      final Map<String, dynamic> responseBody = response.data;
      final Map<String, dynamic> data = responseBody['data'] ?? {};
      
      final List<dynamic> itemsJson = data['items'] ?? [];
      final bool hasNext = data['metadata']?['hasNextPage'] ?? false;

      return PaginatedPathogenResponse(
        items: itemsJson.map((item) => Pathogen.fromJson(item)).toList(),
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