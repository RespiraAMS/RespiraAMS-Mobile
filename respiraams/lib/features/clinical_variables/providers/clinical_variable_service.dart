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
    bool? isRequired,
    String? valueType,
    String? category,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page,
        'pageSize': pageSize,
      };

      if (isRequired != null) queryParams['isRequired'] = isRequired;
      if (valueType != null) queryParams['valueType'] = valueType;
      if (category != null) queryParams['category'] = category;

      final response = await apiClient.dio.get(
        '/clinical-variables',
        queryParameters: queryParams,
      );

      return _parseResponse(response);
    } on DioException catch (e) {
      throw _handleError(e);
    } catch (e) {
      throw Exception('Lỗi xử lý dữ liệu: $e');
    }
  }

  Future<PaginatedClinicalVariableResponse> searchVariables({
    int page = 1,
    int pageSize = 10,
    required String searchTerm,
  }) async {
    try {
      final response = await apiClient.dio.get(
        '/clinical-variables/search',
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

  PaginatedClinicalVariableResponse _parseResponse(Response response) {
    final Map<String, dynamic> responseBody = response.data;
    final Map<String, dynamic> data = responseBody['data'] ?? {};
    
    final List<dynamic> itemsJson = data['items'] ?? [];
    final bool hasNext = data['metadata']?['hasNextPage'] ?? false;

    return PaginatedClinicalVariableResponse(
      items: itemsJson.map((item) => ClinicalVariable.fromJson(item)).toList(),
      hasNextPage: hasNext,
    );
  }

  Future<ClinicalVariableDetail> fetchVariableDetail(String id) async {
    try {
      final response = await apiClient.dio.get('/clinical-variables/$id');
      
      final Map<String, dynamic> responseBody = response.data;
      final Map<String, dynamic> data = responseBody['data'] ?? {};
      
      return ClinicalVariableDetail.fromJson(data);
    } on DioException catch (e) {
      throw _handleError(e);
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