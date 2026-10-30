import 'package:flutter/material.dart';
import '../models/risk_factor.dart';
import '../../suspected_causes/models/pathogen_summary.dart';
import 'risk_factor_service.dart';

class RiskFactorProvider extends ChangeNotifier {
  final RiskFactorRepository _repository;

  RiskFactorProvider(this._repository);

  final List<RiskFactor> _items = [];
  List<RiskFactor> get items => _items;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _hasMore = true;
  bool get hasMore => _hasMore;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  int _currentPage = 1;

  // Filter States
  String? _filterPathogenId;
  String? get filterPathogenId => _filterPathogenId;

  bool get hasActiveFilters => _filterPathogenId != null;

  Future<void> fetchPage() async {
    if (_isLoading || !_hasMore) return;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _repository.fetchRiskFactors(
        page: _currentPage,
        pathogenId: _filterPathogenId,
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

  void applyFilter({String? pathogenId}) {
    _filterPathogenId = pathogenId;
    _resetAndFetch();
  }

  void clearFilters() {
    _filterPathogenId = null;
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

  // Proxy Functions
  Future<RiskFactor> fetchRiskFactorDetail(String id) {
    return _repository.fetchRiskFactorDetail(id);
  }

  Future<List<PathogenSummary>> fetchPathogensList() {
    return _repository.fetchPathogensList();
  }
}