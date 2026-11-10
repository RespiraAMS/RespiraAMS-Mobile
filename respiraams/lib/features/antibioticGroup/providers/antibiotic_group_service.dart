import 'package:dio/dio.dart';
import '../../../core/network/api_client.dart';
import '../../antibiotic/models/antibiotic.dart';
import '../models/antibiotic_group.dart';

class PaginatedGroupResponse {
  final List<AntibioticGroup> items;
  final bool hasNextPage;

  PaginatedGroupResponse({required this.items, required this.hasNextPage});
}

class AntibioticGroupRepository {
  final ApiClient apiClient;

  AntibioticGroupRepository({required this.apiClient});

  Future<PaginatedGroupResponse> fetchGroups({int page = 1, int pageSize = 10, String? name}) async {
    try {
      final search = name?.trim() ?? '';
      final queryParams = <String, dynamic>{
        'page': page,
        'size': pageSize,
        if (search.isNotEmpty) 'searchTerm': search,
      };

      // Free-text search lives on `/antibiotic-groups/search`; the paged
      // endpoint only supports the `parentId` filter.
      final response = await apiClient.dio.get(
        search.isEmpty ? '/antibiotic-groups' : '/antibiotic-groups/search',
        queryParameters: queryParams,
      );

      final Map<String, dynamic> responseBody = response.data;
      final Map<String, dynamic> data = responseBody['data'] ?? {};
      
      final List<dynamic> itemsJson = data['items'] ?? [];
      final bool hasNext = data['metadata']?['hasNextPage'] ?? false;

      return PaginatedGroupResponse(
        items: itemsJson.map((item) => AntibioticGroup.fromJson(item)).toList(),
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

  Future<List<Antibiotic>> fetchAntibioticsByGroupId(String groupId) async {
    try {
      final response = await apiClient.dio.get(
        '/antibiotics',
        queryParameters: {
          'antibioticGroupId': groupId,
          'size': 100,
        },
      );

      final Map<String, dynamic> responseBody = response.data;
      final Map<String, dynamic> data = responseBody['data'] ?? {};
      final List<dynamic> itemsJson = data['items'] ?? [];

      return itemsJson.map((item) => Antibiotic.fromJson(item)).toList();
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