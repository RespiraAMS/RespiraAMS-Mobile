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

  bool? _filterIsApplied;

  bool get hasActiveFilters => _filterIsApplied != null;
  bool? get filterIsApplied => _filterIsApplied;

  Future<void> fetchPage() async {
    if (_isLoading || !_hasMore) return;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      PaginatedMetricResponse response;

      // Có từ khóa -> Gọi API Search
      if (_searchQuery.isNotEmpty) {
        response = await _repository.searchMetrics(
          page: _currentPage,
          searchTerm: _searchQuery,
        );
      } 
      else {
        response = await _repository.fetchMetrics(
          page: _currentPage,
          isApplied: _filterIsApplied,
        );
      }
      
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
    final trimmedQuery = query.trim();

    if (_searchQuery == trimmedQuery) return;

    if (trimmedQuery.isNotEmpty) {
      if (trimmedQuery.length < 2) {
        _errorMessage = 'Vui lòng nhập ít nhất 2 ký tự.';
        notifyListeners();
        return;
      }
      if (!RegExp(r'^[\p{L}0-9\s\-]+$', unicode: true).hasMatch(trimmedQuery)) {
        _errorMessage = 'Từ khóa chỉ được chứa chữ, số, khoảng trắng và gạch ngang.';
        notifyListeners();
        return;
      }
    }
    
    _searchQuery = trimmedQuery;
    _resetAndFetch();
  }

  void applyFilter({bool? isApplied}) {
    _filterIsApplied = isApplied;
    _searchQuery = ''; 
    _resetAndFetch();
  }

  void clearFilters() {
    _filterIsApplied = null;
    _resetAndFetch();
  }

  void _resetAndFetch() {
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