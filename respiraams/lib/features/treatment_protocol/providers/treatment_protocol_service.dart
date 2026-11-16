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

/// One selectable option of the protocol filter sheet (pathogen or criterion).
class TreatmentProtocolFilterOption {
  const TreatmentProtocolFilterOption({required this.id, required this.name});

  final String id;
  final String name;
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
    List<String> pathogenIds = const [],
    List<String> criteriaIds = const [],
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page,
        'size': pageSize,
        if (severity != null && severity.isNotEmpty) 'severity': severity,
        if (treatmentSite != null && treatmentSite.isNotEmpty)
          'treatmentSite': treatmentSite,
        // Dio serializes list values as repeated keys by default, which is
        // what the backend's `List<Guid>` binder expects.
        if (pathogenIds.isNotEmpty) 'pathogenIds': pathogenIds,
        if (criteriaIds.isNotEmpty) 'criteriaIds': criteriaIds,
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

  /// Options of the "Tác nhân gây bệnh" filter (`GET /pathogens`).
  Future<List<TreatmentProtocolFilterOption>> fetchPathogenOptions() =>
      _fetchFilterOptions('/pathogens');

  /// Options of the "Tiêu chí" filter (`GET /criteria`).
  Future<List<TreatmentProtocolFilterOption>> fetchCriterionOptions() =>
      _fetchFilterOptions('/criteria');

  /// Walks the paged list endpoint until the last page (capped at 5 pages so
  /// a misbehaving backend cannot loop forever).
  Future<List<TreatmentProtocolFilterOption>> _fetchFilterOptions(
    String path,
  ) async {
    const pageSize = 200;
    final options = <TreatmentProtocolFilterOption>[];
    var page = 1;
    while (page <= 5) {
      final response = await apiClient.dio.get(
        path,
        queryParameters: {'page': page, 'size': pageSize},
      );
      final Map<String, dynamic> responseBody = response.data;
      final Map<String, dynamic> data = responseBody['data'] ?? {};
      final List<dynamic> itemsJson = data['items'] ?? [];
      for (final item in itemsJson) {
        final map = item as Map<String, dynamic>;
        options.add(
          TreatmentProtocolFilterOption(
            id: map['id'] as String? ?? '',
            name: map['name'] as String? ?? '',
          ),
        );
      }
      final metadata = data['metadata'];
      if (metadata is! Map || metadata['hasNextPage'] != true) break;
      page++;
    }
    options.sort(
      (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()),
    );
    return options;
  }
}
