import 'package:dio/dio.dart';
import '../../../core/network/api_client.dart';
import '../models/risk_factor.dart';
import '../../suspected_causes/models/pathogen_summary.dart';

class PaginatedRiskFactorResponse {
  final List<RiskFactor> items;
  final bool hasNextPage;

  PaginatedRiskFactorResponse({required this.items, required this.hasNextPage});
}

class RiskFactorRepository {
  final ApiClient apiClient;

  RiskFactorRepository({required this.apiClient});

  Future<PaginatedRiskFactorResponse> fetchRiskFactors({
    int page = 1,
    int pageSize = 10,
    String? pathogenId,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page,
        'pageSize': pageSize,
      };

      if (pathogenId != null) queryParams['PathogenId'] = pathogenId;

      final response = await apiClient.dio.get(
        '/risk-factors',
        queryParameters: queryParams,
      );

      final Map<String, dynamic> responseBody = response.data;
      final Map<String, dynamic> data = responseBody['data'] ?? {};
      
      final List<dynamic> itemsJson = data['items'] ?? [];
      final bool hasNext = data['metadata']?['hasNextPage'] ?? false;

      return PaginatedRiskFactorResponse(
        items: itemsJson.map((item) => RiskFactor.fromJson(item)).toList(),
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

  Future<RiskFactor> fetchRiskFactorDetail(String id) async {
    try {
      final response = await apiClient.dio.get('/risk-factors/$id');
      final Map<String, dynamic> responseBody = response.data;
      final Map<String, dynamic> data = responseBody['data'] ?? {};
      
      return RiskFactor.fromJson(data);
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

  Future<List<PathogenSummary>> fetchPathogensList() async {
    try {
      final response = await apiClient.dio.get('/pathogens/list');
      
      final Map<String, dynamic> responseBody = response.data;
      final Map<String, dynamic> data = responseBody['data'] ?? {};
      final List<dynamic> pathogensJson = data['pathogens'] ?? [];

      return pathogensJson.map((item) => PathogenSummary.fromJson(item)).toList();
    } catch (e) {
      throw Exception('Không tải được danh sách tác nhân');
    }
  }
}