import 'package:flutter/material.dart';
import '../models/suspected_cause.dart';
import '../models/pathogen_summary.dart';
import 'suspected_cause_service.dart';

class SuspectedCauseProvider extends ChangeNotifier {
  final SuspectedCauseRepository _repository;

  SuspectedCauseProvider(this._repository);

  final List<SuspectedCause> _items = [];
  List<SuspectedCause> get items => _items;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _hasMore = true;
  bool get hasMore => _hasMore;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  int _currentPage = 1;

  String? _filterPathogenId;
  String? _filterSeverity;
  String? _filterTreatmentSite;

  String? get filterPathogenId => _filterPathogenId;
  String? get filterSeverity => _filterSeverity;
  String? get filterTreatmentSite => _filterTreatmentSite;

  bool get hasActiveFilters => _filterPathogenId != null || _filterSeverity != null || _filterTreatmentSite != null;

  Future<void> fetchPage() async {
    if (_isLoading || !_hasMore) return;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _repository.fetchSuspectedCauses(
        page: _currentPage,
        pathogenId: _filterPathogenId,
        severity: _filterSeverity,
        treatmentSite: _filterTreatmentSite,
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

  void applyFilter({String? pathogenId, String? severity, String? treatmentSite}) {
    _filterPathogenId = pathogenId;
    _filterSeverity = severity;
    _filterTreatmentSite = treatmentSite;
    _resetAndFetch();
  }

  void clearFilters() {
    _filterPathogenId = null;
    _filterSeverity = null;
    _filterTreatmentSite = null;
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

  Future<List<PathogenSummary>> fetchPathogensList() {
    return _repository.fetchPathogensList();
  }
}