import 'package:dio/dio.dart';

import '../../../core/network/api_client.dart';
import '../models/antibiogram.dart';

class PaginatedAntibiogramResponse {
  final List<Antibiogram> items;
  final bool hasNextPage;

  PaginatedAntibiogramResponse({
    required this.items,
    required this.hasNextPage,
  });
}

/// Client of `GET /antibiograms` (Respira.Clinical).
///
/// The endpoint only filters on `pathogenId` and `micCategory`; there is no
/// free-text search and no `GET /{id}`, so the list screen searches and
/// expands locally.
class AntibiogramRepository {
  final ApiClient apiClient;

  AntibiogramRepository({required this.apiClient});

  Future<PaginatedAntibiogramResponse> fetchAntibiograms({
    int page = 1,
    int pageSize = 10,
    String? micCategory,
    String? pathogenId,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page,
        'size': pageSize,
        if (micCategory != null && micCategory.isNotEmpty)
          'micCategory': micCategory,
        if (pathogenId != null && pathogenId.isNotEmpty)
          'pathogenId': pathogenId,
      };

      final response = await apiClient.dio.get(
        '/antibiograms',
        queryParameters: queryParams,
      );

      final Map<String, dynamic> responseBody = response.data;
      final Map<String, dynamic> data = responseBody['data'] ?? {};
      final List<dynamic> itemsJson = data['items'] ?? [];
      final bool hasNext = data['metadata']?['hasNextPage'] ?? false;

      return PaginatedAntibiogramResponse(
        items: itemsJson
            .map((item) => Antibiogram.fromJson(item as Map<String, dynamic>))
            .toList(),
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
