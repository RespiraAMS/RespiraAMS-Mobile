import 'package:dio/dio.dart';
import '../../../core/network/api_client.dart';
import '../models/pathogen.dart';

class PaginatedPathogenResponse {
  final List<Pathogen> items;
  final bool hasNextPage;

  PaginatedPathogenResponse({required this.items, required this.hasNextPage});
}

class PathogenRepository {
  final ApiClient apiClient;

  PathogenRepository({required this.apiClient});

  Future<PaginatedPathogenResponse> fetchPathogens({
    int page = 1,
    int pageSize = 10,
    bool? isAtypical,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page,
        'pageSize': pageSize,
      };

      if (isAtypical != null) queryParams['IsAtypical'] = isAtypical;

      final response = await apiClient.dio.get(
        '/pathogens',
        queryParameters: queryParams,
      );

      return _parseResponse(response);
    } on DioException catch (e) {
      throw _handleError(e);
    } catch (e) {
      throw Exception('Lỗi xử lý dữ liệu: $e');
    }
  }

  Future<PaginatedPathogenResponse> searchPathogens({
    int page = 1,
    int pageSize = 10,
    required String searchTerm,
  }) async {
    try {
      final response = await apiClient.dio.get(
        '/pathogens/search',
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

  PaginatedPathogenResponse _parseResponse(Response response) {
    final Map<String, dynamic> responseBody = response.data;
    final Map<String, dynamic> data = responseBody['data'] ?? {};
    
    final List<dynamic> itemsJson = data['items'] ?? [];
    final bool hasNext = data['metadata']?['hasNextPage'] ?? false;

    return PaginatedPathogenResponse(
      items: itemsJson.map((item) => Pathogen.fromJson(item)).toList(),
      hasNextPage: hasNext,
    );
  }

  Exception _handleError(DioException e) {
    if (e.response != null) {
      return Exception('Lỗi server: ${e.response?.statusCode}');
    }
    return Exception('Lỗi kết nối mạng: Vui lòng kiểm tra internet');
  }
}