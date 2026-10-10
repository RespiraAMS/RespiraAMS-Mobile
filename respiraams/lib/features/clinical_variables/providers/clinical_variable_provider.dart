import 'package:flutter/material.dart';
import '../models/clinical_variable.dart';
import 'clinical_variable_service.dart';

class ClinicalVariableProvider extends ChangeNotifier {
  final ClinicalVariableRepository _repository;

  ClinicalVariableProvider(this._repository);

  final List<ClinicalVariable> _items = [];
  List<ClinicalVariable> get items => _items;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _hasMore = true;
  bool get hasMore => _hasMore;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  int _currentPage = 1;

  // Search & Filter States
  String _searchQuery = '';
  bool? _filterIsRequired;
  String? _filterValueType;
  String? _filterCategory;

  bool get hasActiveFilters => _filterIsRequired != null || _filterValueType != null || _filterCategory != null;

  bool? get filterIsRequired => _filterIsRequired;
  String? get filterValueType => _filterValueType;
  String? get filterCategory => _filterCategory;

  Future<void> fetchPage() async {
    if (_isLoading || !_hasMore) return;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _repository.fetchVariables(
        page: _currentPage,
        name: _searchQuery, 
        isRequired: _filterIsRequired,
        valueType: _filterValueType,
        category: _filterCategory,
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
    _resetAndFetch();
  }

  void applyFilter({bool? isRequired, String? valueType, String? category}) {
    _filterIsRequired = isRequired;
    _filterValueType = valueType;
    _filterCategory = category;
    _resetAndFetch();
  }

  void clearFilters() {
    _filterIsRequired = null;
    _filterValueType = null;
    _filterCategory = null;
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
}