import 'package:flutter/material.dart';
import '../models/pathogen.dart';
import 'pathogen_service.dart';

class PathogenProvider extends ChangeNotifier {
  final PathogenRepository _repository;

  PathogenProvider(this._repository);

  final List<Pathogen> _items = [];
  List<Pathogen> get items => _items;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _hasMore = true;
  bool get hasMore => _hasMore;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  int _currentPage = 1;
  String _searchQuery = '';

  // State bộ lọc
  bool? _filterIsAtypical;

  bool get hasActiveFilters => _filterIsAtypical != null;
  bool? get filterIsAtypical => _filterIsAtypical;

  Future<void> fetchPage() async {
    if (_isLoading || !_hasMore) return;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      PaginatedPathogenResponse response;

      // Nếu có từ khóa -> Gọi API Search
      if (_searchQuery.isNotEmpty) {
        response = await _repository.searchPathogens(
          page: _currentPage,
          searchTerm: _searchQuery,
        );
      } 
      else {
        response = await _repository.fetchPathogens(
          page: _currentPage,
          isAtypical: _filterIsAtypical,
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

  void applyFilter({bool? isAtypical}) {
    _filterIsAtypical = isAtypical;
    _searchQuery = '';
    _resetAndFetch();
  }

  void clearFilters() {
    _filterIsAtypical = null;
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