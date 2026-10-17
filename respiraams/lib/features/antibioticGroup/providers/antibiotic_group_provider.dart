import 'package:flutter/material.dart';
import '../../antibiotic/models/antibiotic.dart';
import '../models/antibiotic_group.dart';
import '../models/antibiotic_group_summary.dart';
import 'antibiotic_group_service.dart';

class AntibioticGroupProvider extends ChangeNotifier {
  final AntibioticGroupRepository _repository;

  AntibioticGroupProvider(this._repository);

  final List<AntibioticGroup> _items = [];
  List<AntibioticGroup> get items => _items;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _hasMore = true;
  bool get hasMore => _hasMore;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  int _currentPage = 1;
  String _searchQuery = '';

  String? _filterParentId;

  bool get hasActiveFilters => _filterParentId != null;
  String? get filterParentId => _filterParentId;

  Future<void> fetchPage() async {
    if (_isLoading || !_hasMore) return;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      PaginatedGroupResponse response;

      if (_searchQuery.isNotEmpty) {
        response = await _repository.searchGroups(
          page: _currentPage,
          searchTerm: _searchQuery,
        );
      } 
      else {
        response = await _repository.fetchGroups(
          page: _currentPage,
          parentId: _filterParentId,
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

  void applyFilter({String? parentId}) {
    _filterParentId = parentId;
    _searchQuery = ''; 
    _resetAndFetch();
  }

  void clearFilters() {
    _filterParentId = null;
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

  Future<List<Antibiotic>> fetchAntibioticsByGroupId(String groupId) {
    return _repository.fetchAntibioticsByGroupId(groupId);
  }

  Future<List<AntibioticGroupSummary>> fetchGroupList() {
    return _repository.fetchGroupList();
  }
}