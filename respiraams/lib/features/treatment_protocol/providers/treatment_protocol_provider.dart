import 'package:flutter/material.dart';

import '../../../core/network/api_response.dart';
import '../models/treatment_protocol.dart';
import 'treatment_protocol_service.dart';

/// Paged state of the treatment-protocol lookup screen.
///
/// Severity and treatment site are applied server-side (reset + refetch);
/// the search box filters the already-loaded pages client-side.
class TreatmentProtocolProvider extends ChangeNotifier {
  final TreatmentProtocolRepository _repository;

  TreatmentProtocolProvider(this._repository);

  final List<TreatmentProtocol> _items = [];

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _hasMore = true;
  bool get hasMore => _hasMore;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  int _currentPage = 1;
  ProtocolSeverity? _severityFilter;
  ProtocolTreatmentSite? _siteFilter;
  String _searchQuery = '';

  ProtocolSeverity? get severityFilter => _severityFilter;
  ProtocolTreatmentSite? get siteFilter => _siteFilter;

  /// True once at least one page has been loaded (used to distinguish
  /// "no data" from "no search match").
  bool get hasLoadedItems => _items.isNotEmpty;

  /// Items after the client-side search filter (pathogen / criterion /
  /// antibiotic names).
  List<TreatmentProtocol> get items {
    final query = _searchQuery.trim().toLowerCase();
    if (query.isEmpty) return List.unmodifiable(_items);
    return _items.where((item) {
      if (item.pathogens.any((p) => p.name.toLowerCase().contains(query))) {
        return true;
      }
      if (item.criteria.any((c) => c.name.toLowerCase().contains(query))) {
        return true;
      }
      return item.treatments.any(
        (combination) =>
            combination.any((a) => a.name.toLowerCase().contains(query)),
      );
    }).toList();
  }

  Future<void> fetchPage() async {
    if (_isLoading || !_hasMore) return;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _repository.fetchTreatmentProtocols(
        page: _currentPage,
        severity: _severityFilter?.wireValue,
        treatmentSite: _siteFilter?.wireValue,
      );

      _items.addAll(response.items);
      _hasMore = response.hasNextPage;
      _currentPage++;
    } catch (e) {
      debugPrint('Failed to load treatment protocols: $e');
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

  void setSeverityFilter(ProtocolSeverity? severity) {
    if (_severityFilter == severity) return;
    _severityFilter = severity;
    _reset();
  }

  void setSiteFilter(ProtocolTreatmentSite? site) {
    if (_siteFilter == site) return;
    _siteFilter = site;
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
