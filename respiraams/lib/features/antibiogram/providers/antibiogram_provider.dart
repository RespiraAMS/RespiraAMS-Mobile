import 'package:flutter/material.dart';

import '../../../core/network/api_response.dart';
import '../models/antibiogram.dart';
import 'antibiogram_service.dart';

/// Paged state of the antibiogram lookup screen.
///
/// The MIC filter is applied server-side (reset + refetch); the search box
/// filters the already-loaded pages client-side because the endpoint has no
/// `searchTerm`.
class AntibiogramProvider extends ChangeNotifier {
  final AntibiogramRepository _repository;

  AntibiogramProvider(this._repository);

  final List<Antibiogram> _items = [];

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _hasMore = true;
  bool get hasMore => _hasMore;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  int _currentPage = 1;
  MicCategory? _micFilter;
  String _searchQuery = '';

  MicCategory? get micFilter => _micFilter;

  /// True once at least one page has been loaded (used to distinguish
  /// "no data" from "no search match").
  bool get hasLoadedItems => _items.isNotEmpty;

  /// Items after the client-side search filter.
  List<Antibiogram> get items {
    final query = _searchQuery.trim().toLowerCase();
    if (query.isEmpty) return List.unmodifiable(_items);
    return _items.where((item) {
      if (item.pathogen.name.toLowerCase().contains(query)) return true;
      return item.antibiotics.any(
        (antibiotic) => antibiotic.name.toLowerCase().contains(query),
      );
    }).toList();
  }

  Future<void> fetchPage() async {
    if (_isLoading || !_hasMore) return;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _repository.fetchAntibiograms(
        page: _currentPage,
        micCategory: _micFilter?.wireValue,
      );

      _items.addAll(response.items);
      _hasMore = response.hasNextPage;
      _currentPage++;
    } catch (e) {
      debugPrint('Failed to load antibiograms: $e');
      _errorMessage = LocalApiError.loadData;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void search(String query) {
    if (_searchQuery == query) return;
    _searchQuery = query;
    notifyListeners();
  }

  void setMicFilter(MicCategory? category) {
    if (_micFilter == category) return;
    _micFilter = category;
    _reset();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  Future<void> refresh() async {
    _reset();
  }

  void _reset() {
    _items.clear();
    _currentPage = 1;
    _hasMore = true;
    _isLoading = false;
    fetchPage();
  }
}
