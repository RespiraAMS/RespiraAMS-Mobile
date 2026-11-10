import 'package:dio/dio.dart';
import '../../../core/network/api_client.dart';
import '../models/clinical_variable.dart';

class PaginatedClinicalVariableResponse {
  final List<ClinicalVariable> items;
  final bool hasNextPage;

  PaginatedClinicalVariableResponse({required this.items, required this.hasNextPage});
}

class ClinicalVariableRepository {
  final ApiClient apiClient;

  ClinicalVariableRepository({required this.apiClient});

  Future<PaginatedClinicalVariableResponse> fetchVariables({
    int page = 1,
    int pageSize = 10,
    String? name,
    String? code,
    bool? isRequired,
    String? valueType,
    String? category,
  }) async {
    try {
      final search = (name ?? code ?? '').trim();
      final queryParams = <String, dynamic>{
        'page': page,
        'size': pageSize,
      };

      if (search.isNotEmpty) {
        // Free-text search lives on `/clinical-variables/search`.
        queryParams['searchTerm'] = search;
      } else {
        if (isRequired != null) queryParams['isRequired'] = isRequired;
        if (valueType != null) queryParams['valueType'] = valueType;
        if (category != null) queryParams['category'] = category;
      }

      final response = await apiClient.dio.get(
        search.isEmpty ? '/clinical-variables' : '/clinical-variables/search',
        queryParameters: queryParams,
      );

      final Map<String, dynamic> responseBody = response.data;
      final Map<String, dynamic> data = responseBody['data'] ?? {};
      
      final List<dynamic> itemsJson = data['items'] ?? [];
      final bool hasNext = data['metadata']?['hasNextPage'] ?? false;

      return PaginatedClinicalVariableResponse(
        items: itemsJson.map((item) => ClinicalVariable.fromJson(item)).toList(),
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

  Future<ClinicalVariableDetail> fetchVariableDetail(String id) async {
    try {
      final response = await apiClient.dio.get('/clinical-variables/$id');
      
      final Map<String, dynamic> responseBody = response.data;
      final Map<String, dynamic> data = responseBody['data'] ?? {};
      
      return ClinicalVariableDetail.fromJson(data);
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