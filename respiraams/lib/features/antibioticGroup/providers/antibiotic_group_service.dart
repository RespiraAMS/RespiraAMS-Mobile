import 'package:dio/dio.dart';
import '../../../core/network/api_client.dart';
import '../../antibiotic/models/antibiotic.dart';
import '../models/antibiotic_group.dart';
import '../models/antibiotic_group_summary.dart';

class PaginatedGroupResponse {
  final List<AntibioticGroup> items;
  final bool hasNextPage;

  PaginatedGroupResponse({required this.items, required this.hasNextPage});
}

class AntibioticGroupRepository {
  final ApiClient apiClient;

  AntibioticGroupRepository({required this.apiClient});

  Future<PaginatedGroupResponse> fetchGroups({
    int page = 1, 
    int pageSize = 10, 
    String? parentId,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page,
        'pageSize': pageSize,
      };

      if (parentId != null) {
        queryParams['ParentId'] = parentId;
      }

      final response = await apiClient.dio.get(
        '/antibiotic-groups',
        queryParameters: queryParams,
      );

      return _parseResponse(response);
    } on DioException catch (e) {
      throw _handleError(e);
    } catch (e) {
      throw Exception('Lỗi xử lý dữ liệu: $e');
    }
  }

  Future<PaginatedGroupResponse> searchGroups({
    int page = 1, 
    int pageSize = 10, 
    required String searchTerm,
  }) async {
    try {
      final response = await apiClient.dio.get(
        '/antibiotic-groups/search',
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

  PaginatedGroupResponse _parseResponse(Response response) {
    final Map<String, dynamic> responseBody = response.data;
    final Map<String, dynamic> data = responseBody['data'] ?? {};
    
    final List<dynamic> itemsJson = data['items'] ?? [];
    final bool hasNext = data['metadata']?['hasNextPage'] ?? false;

    return PaginatedGroupResponse(
      items: itemsJson.map((item) => AntibioticGroup.fromJson(item)).toList(),
      hasNextPage: hasNext,
    );
  }

  Future<List<AntibioticGroupSummary>> fetchGroupList() async {
    try {
      final response = await apiClient.dio.get('/antibiotic-groups/list');
      
      final Map<String, dynamic> responseBody = response.data;
      final Map<String, dynamic> data = responseBody['data'] ?? {};
      final List<dynamic> groupsJson = data['antibioticGroups'] ?? [];

      return groupsJson.map((item) => AntibioticGroupSummary.fromJson(item)).toList();
    } catch (e) {
      throw Exception('Không tải được danh sách nhóm kháng sinh');
    }
  }

  Exception _handleError(DioException e) {
    if (e.response != null) {
      return Exception('Lỗi server: ${e.response?.statusCode}');
    }
    return Exception('Lỗi kết nối mạng: Vui lòng kiểm tra internet');
  }

  Future<List<Antibiotic>> fetchAntibioticsByGroupId(String groupId) async {
    try {
      final response = await apiClient.dio.get(
        '/antibiotics',
        queryParameters: {
          'AntibioticGroupId': groupId,
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
        throw Exception('Lỗi kết nối mạng: Vui lòng kiểm tra internet');
      }
    } catch (e) {
      throw Exception('Lỗi xử lý dữ liệu: $e');
    }
  }
}