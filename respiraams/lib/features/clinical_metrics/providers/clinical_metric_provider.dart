import 'package:flutter/material.dart';
import '../models/clinical_metric.dart';
import 'clinical_metric_service.dart';

class ClinicalMetricProvider extends ChangeNotifier {
  final ClinicalMetricRepository _repository;

  ClinicalMetricProvider(this._repository);

  final List<ClinicalMetric> _items = [];
  List<ClinicalMetric> get items => _items;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _hasMore = true;
  bool get hasMore => _hasMore;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  int _currentPage = 1;
  String _searchQuery = '';

  Future<void> fetchPage() async {
    if (_isLoading || !_hasMore) return;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _repository.fetchMetrics(
        page: _currentPage,
        name: _searchQuery,
        code: _searchQuery.isNotEmpty ? _searchQuery : null,
      );
      
      _items.addAll(response.items);
      _hasMore = response.hasNextPage;
      _currentPage++;
    } catch (e) {
      _errorMessage = 'Lỗi tải dữ liệu: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void search(String query) {
    if (_searchQuery == query) return;
    
    _searchQuery = query;
    _currentPage = 1;
    _items.clear();
    _hasMore = true;
    _isLoading = false; 
    
    fetchPage();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  Future<ClinicalMetricDetail> fetchMetricDetail(String id) {
    return _repository.fetchMetricDetail(id);
  }
}