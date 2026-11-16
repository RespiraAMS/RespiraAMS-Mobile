import 'package:flutter/material.dart';
import '../../../core/network/api_response.dart';
import '../models/criterion.dart';
import 'criterion_service.dart';

class CriterionProvider extends ChangeNotifier {
  final CriterionRepository _repository;

  CriterionProvider(this._repository);

  final List<Criterion> _items = [];
  List<Criterion> get items {
    final query = _searchQuery.trim().toLowerCase();
    if (query.isEmpty) return _items;
    return _items
        .where((item) => item.name.toLowerCase().contains(query))
        .toList();
  }

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
      final response = await _repository.fetchCriteria(
        page: _currentPage,
      );
      
      _items.addAll(response.items);
      _hasMore = response.hasNextPage;
      _currentPage++;
    } catch (e) {
      debugPrint('Failed to load criteria: $e');
      _errorMessage = LocalApiError.loadData;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void search(String query) {
    if (_searchQuery == query) return;
    // `/criteria` has no server-side search; filter the loaded pages locally.
    _searchQuery = query;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}