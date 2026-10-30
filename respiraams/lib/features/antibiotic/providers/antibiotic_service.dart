import 'package:dio/dio.dart';
import '../../../core/network/api_client.dart';
import '../models/antibiotic.dart';
import '../models/antibiotic_group_summary.dart';

class PaginatedAntibioticResponse {
  final List<Antibiotic> items;
  final bool hasNextPage;

  PaginatedAntibioticResponse({required this.items, required this.hasNextPage});
}

class AntibioticRepository {
  final ApiClient apiClient;

  AntibioticRepository({required this.apiClient});

  Future<PaginatedAntibioticResponse> fetchAntibiotics({
    int page = 1, 
    int pageSize = 10,
    String? groupId,
    String? classification,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page,
        'pageSize': pageSize,
      };

      if (groupId != null) queryParams['AntibioticGroupId'] = groupId;
      if (classification != null) queryParams['Classification'] = classification;

      final response = await apiClient.dio.get(
        '/antibiotics',
        queryParameters: queryParams,
      );

      return _parseResponse(response);
    } on DioException catch (e) {
      throw _handleError(e);
    } catch (e) {
      throw Exception('Lỗi xử lý dữ liệu: $e');
    }
  }

  Future<PaginatedAntibioticResponse> searchAntibiotics({
    int page = 1, 
    int pageSize = 10,
    required String searchTerm,
  }) async {
    try {
      final response = await apiClient.dio.get(
        '/antibiotics/search',
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

  PaginatedAntibioticResponse _parseResponse(Response response) {
    final Map<String, dynamic> responseBody = response.data;
    final Map<String, dynamic> data = responseBody['data'] ?? {};
    
    final List<dynamic> itemsJson = data['items'] ?? [];
    final bool hasNext = data['metadata']?['hasNextPage'] ?? false;

    return PaginatedAntibioticResponse(
      items: itemsJson.map((item) => Antibiotic.fromJson(item)).toList(),
      hasNextPage: hasNext,
    );
  }

  Future<List<AntibioticGroupSummary>> fetchAntibioticGroupsList() async {
    try {
      final response = await apiClient.dio.get('/antibiotic-groups/list');
      final data = response.data['data']?['antibioticGroups'] as List<dynamic>? ?? [];
      return data.map((e) => AntibioticGroupSummary.fromJson(e)).toList();
    } catch (e) {
      throw Exception('Không tải được danh sách nhóm kháng sinh: $e');
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
        throw Exception('Lỗi kết nối mạng: Vui lòng kiểm tra internet');
      }
    } catch (e) {
      throw Exception('Lỗi xử lý dữ liệu: $e');
    }
  }

  Exception _handleError(DioException e) {
    if (e.response != null) {
      return Exception('Lỗi server: ${e.response?.statusCode}');
    }
    return Exception('Lỗi kết nối mạng: Vui lòng kiểm tra internet');
  }
}

