import 'package:dio/dio.dart';

import '../../../core/network/api_client.dart';
import '../models/treatment_protocol.dart';

class PaginatedTreatmentProtocolResponse {
  final List<TreatmentProtocol> items;
  final bool hasNextPage;

  PaginatedTreatmentProtocolResponse({
    required this.items,
    required this.hasNextPage,
  });
}

/// Client of `GET /treatment-protocols` (Respira.Clinical).
///
/// Supported filters: `severity`, `treatmentSite`, `pathogenIds`,
/// `criteriaIds`. There is no free-text search and no `GET /{id}`, so the
/// list screen searches and expands locally.
class TreatmentProtocolRepository {
  final ApiClient apiClient;

  TreatmentProtocolRepository({required this.apiClient});

  Future<PaginatedTreatmentProtocolResponse> fetchTreatmentProtocols({
    int page = 1,
    int pageSize = 10,
    String? severity,
    String? treatmentSite,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page,
        'size': pageSize,
        if (severity != null && severity.isNotEmpty) 'severity': severity,
        if (treatmentSite != null && treatmentSite.isNotEmpty)
          'treatmentSite': treatmentSite,
      };

      final response = await apiClient.dio.get(
        '/treatment-protocols',
        queryParameters: queryParams,
      );

      final Map<String, dynamic> responseBody = response.data;
      final Map<String, dynamic> data = responseBody['data'] ?? {};
      final List<dynamic> itemsJson = data['items'] ?? [];
      final bool hasNext = data['metadata']?['hasNextPage'] ?? false;

      return PaginatedTreatmentProtocolResponse(
        items: itemsJson
            .map(
              (item) => TreatmentProtocol.fromJson(item as Map<String, dynamic>),
            )
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
