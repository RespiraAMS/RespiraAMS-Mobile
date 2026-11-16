import 'dart:async';

import 'package:flutter/material.dart';

import '../../../core/network/api_response.dart';
import '../models/treatment_protocol.dart';
import 'treatment_protocol_service.dart';

/// Paged state of the treatment-protocol lookup screen.
///
/// Severity, treatment site, pathogen and criterion filters are applied
/// server-side (reset + refetch); the search box filters the already-loaded
/// pages client-side.
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
  Set<String> _pathogenIds = {};
  Set<String> _criteriaIds = {};
  String _searchQuery = '';

  List<TreatmentProtocolFilterOption> _pathogenOptions = const [];
  List<TreatmentProtocolFilterOption> _criteriaOptions = const [];
  bool _isLoadingOptions = false;
  bool _optionsLoaded = false;
  String? _optionsError;

  /// Incremented on every reset so responses of superseded requests are
  /// discarded instead of being appended to the new filter's list.
  int _requestToken = 0;

  ProtocolSeverity? get severityFilter => _severityFilter;
  ProtocolTreatmentSite? get siteFilter => _siteFilter;
  Set<String> get pathogenIds => Set.unmodifiable(_pathogenIds);
  Set<String> get criteriaIds => Set.unmodifiable(_criteriaIds);

  List<TreatmentProtocolFilterOption> get pathogenOptions => _pathogenOptions;
  List<TreatmentProtocolFilterOption> get criteriaOptions => _criteriaOptions;
  bool get isLoadingOptions => _isLoadingOptions;
  String? get optionsError => _optionsError;

  bool get hasActiveFilters =>
      _severityFilter != null ||
      _siteFilter != null ||
      _pathogenIds.isNotEmpty ||
      _criteriaIds.isNotEmpty;

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

    final token = _requestToken;
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _repository.fetchTreatmentProtocols(
        page: _currentPage,
        severity: _severityFilter?.wireValue,
        treatmentSite: _siteFilter?.wireValue,
        pathogenIds: _pathogenIds.toList(),
        criteriaIds: _criteriaIds.toList(),
      );

      if (token != _requestToken) return;
      _items.addAll(response.items);
      _hasMore = response.hasNextPage;
      _currentPage++;
    } catch (e) {
      if (token != _requestToken) return;
      debugPrint('Failed to load treatment protocols: $e');
      _errorMessage = LocalApiError.loadData;
    } finally {
      if (token == _requestToken) {
        _isLoading = false;
        notifyListeners();
      }
    }
  }

  /// Loads the pathogen/criterion lists shown by the filter sheet. Cached
  /// after the first successful load; pass [force] to reload.
  Future<void> loadFilterOptions({bool force = false}) async {
    if (_isLoadingOptions) return;
    if (_optionsLoaded && !force) return;

    _isLoadingOptions = true;
    _optionsError = null;
    notifyListeners();

    try {
      final results = await Future.wait([
        _repository.fetchPathogenOptions(),
        _repository.fetchCriterionOptions(),
      ]);
      _pathogenOptions = results[0];
      _criteriaOptions = results[1];
      _optionsLoaded = true;
    } catch (e) {
      debugPrint('Failed to load protocol filter options: $e');
      _optionsError = LocalApiError.loadData;
    } finally {
      _isLoadingOptions = false;
      notifyListeners();
    }
  }

  void search(String query) {
    if (_searchQuery == query) return;
    _searchQuery = query;
    notifyListeners();
  }

  void applyFilters({
    ProtocolSeverity? severity,
    ProtocolTreatmentSite? treatmentSite,
    Set<String> pathogenIds = const {},
    Set<String> criteriaIds = const {},
  }) {
    final unchanged = severity == _severityFilter &&
        treatmentSite == _siteFilter &&
        _sameSet(pathogenIds, _pathogenIds) &&
        _sameSet(criteriaIds, _criteriaIds);
    if (unchanged) return;

    _severityFilter = severity;
    _siteFilter = treatmentSite;
    _pathogenIds = {...pathogenIds};
    _criteriaIds = {...criteriaIds};
    _reset();
  }

  void clearFilters() {
    if (!hasActiveFilters) return;
    _severityFilter = null;
    _siteFilter = null;
    _pathogenIds = {};
    _criteriaIds = {};
    _reset();
  }

  /// Kept for callers that only tweak one enum filter.
  void setSeverityFilter(ProtocolSeverity? severity) => applyFilters(
        severity: severity,
        treatmentSite: _siteFilter,
        pathogenIds: _pathogenIds,
        criteriaIds: _criteriaIds,
      );

  void setSiteFilter(ProtocolTreatmentSite? site) => applyFilters(
        severity: _severityFilter,
        treatmentSite: site,
        pathogenIds: _pathogenIds,
        criteriaIds: _criteriaIds,
      );

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  Future<void> refresh() async {
    _requestToken++;
    _items.clear();
    _currentPage = 1;
    _hasMore = true;
    _isLoading = false;
    await fetchPage();
  }

  /// Discards the loaded pages and starts over with the current filters.
  void _reset() => unawaited(refresh());

  static bool _sameSet(Set<String> a, Set<String> b) =>
      a.length == b.length && a.every(b.contains);
}
