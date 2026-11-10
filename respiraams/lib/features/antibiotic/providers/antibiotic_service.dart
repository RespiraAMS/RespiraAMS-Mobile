import 'package:dio/dio.dart';
import '../../../core/network/api_client.dart';
import '../models/antibiotic.dart';

class PaginatedAntibioticResponse {
  final List<Antibiotic> items;
  final bool hasNextPage;

  PaginatedAntibioticResponse({required this.items, required this.hasNextPage});
}

class AntibioticRepository {
  final ApiClient apiClient;

  AntibioticRepository({required this.apiClient});

  Future<PaginatedAntibioticResponse> fetchAntibiotics({int page = 1, int pageSize = 10, String? name,}) async {
    try {
      final search = name?.trim() ?? '';
      final queryParams = <String, dynamic>{
        'page': page,
        'size': pageSize,
        if (search.isNotEmpty) 'searchTerm': search,
      };

      // Free-text search lives on `/antibiotics/search`; the paged endpoint
      // only supports `antibioticGroupId` / `classification` filters.
      final response = await apiClient.dio.get(
        search.isEmpty ? '/antibiotics' : '/antibiotics/search',
        queryParameters: queryParams,
      );

      final Map<String, dynamic> responseBody = response.data;
      
      final Map<String, dynamic> data = responseBody['data'] ?? {};
      
      final List<dynamic> itemsJson = data['items'] ?? [];
      final bool hasNext = data['metadata']?['hasNextPage'] ?? false;

      return PaginatedAntibioticResponse(
        items: itemsJson.map((item) => Antibiotic.fromJson(item)).toList(),
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

  Future<AntibioticDetail> fetchAntibioticDetail(String id) async {
    try {
      final response = await apiClient.dio.get('/antibiotics/$id');
      final Map<String, dynamic> responseBody = response.data;
      final Map<String, dynamic> data = responseBody['data'] ?? {};
      
      return AntibioticDetail.fromJson(data);
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

