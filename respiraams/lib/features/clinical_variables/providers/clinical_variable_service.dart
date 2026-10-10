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
      final queryParams = <String, dynamic>{
        'page': page,
        'pageSize': pageSize,
      };

      if (name != null && name.trim().isNotEmpty) queryParams['name'] = name.trim();
      if (code != null && code.trim().isNotEmpty) queryParams['code'] = code.trim();
      if (isRequired != null) queryParams['isRequired'] = isRequired;
      if (valueType != null) queryParams['valueType'] = valueType;
      if (category != null) queryParams['category'] = category;

      final response = await apiClient.dio.get(
        '/clinical-variables',
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
        throw Exception('Lỗi kết nối mạng: Vui lòng kiểm tra internet');
      }
    } catch (e) {
      throw Exception('Lỗi xử lý dữ liệu: $e');
    }
  }
}