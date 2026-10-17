import 'package:flutter/material.dart';
import '../models/antibiotic.dart';
import '../models/antibiotic_group_summary.dart';
import 'antibiotic_service.dart';

class AntibioticProvider extends ChangeNotifier {
  final AntibioticRepository _repository;

  AntibioticProvider(this._repository);

  final List<Antibiotic> _items = [];
  List<Antibiotic> get items => _items;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _hasMore = true;
  bool get hasMore => _hasMore;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  int _currentPage = 1;
  String _searchQuery = '';

  // States bộ lọc
  String? _filterGroupId;
  String? _filterClassification;

  bool get hasActiveFilters => _filterGroupId != null || _filterClassification != null;
  String? get filterGroupId => _filterGroupId;
  String? get filterClassification => _filterClassification;

  Future<void> fetchPage() async {
    if (_isLoading || !_hasMore) return;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      PaginatedAntibioticResponse response;
      
      if (_searchQuery.isNotEmpty) {
        response = await _repository.searchAntibiotics(
          page: _currentPage,
          searchTerm: _searchQuery,
        );
      } 
      else {
        response = await _repository.fetchAntibiotics(
          page: _currentPage,
          groupId: _filterGroupId,
          classification: _filterClassification,
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

  void applyFilter({String? groupId, String? classification}) {
    _filterGroupId = groupId;
    _filterClassification = classification;
    _searchQuery = ''; 
    _resetAndFetch();
  }

  void clearFilters() {
    _filterGroupId = null;
    _filterClassification = null;
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

  Future<AntibioticDetail> fetchAntibioticDetail(String id) {
    return _repository.fetchAntibioticDetail(id);
  }

  Future<List<AntibioticGroupSummary>> fetchAntibioticGroupsList() {
    return _repository.fetchAntibioticGroupsList();
  }
}