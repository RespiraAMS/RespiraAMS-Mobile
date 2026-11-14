import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

import '../../../core/network/api_client.dart';
import '../../../core/network/api_response.dart';
import '../../authentication/providers/current_doctor_provider.dart';
import '../../authentication/services/doctor_service.dart';
import '../models/analysis_report.dart';
import '../services/analysis_service.dart';

final analysisServiceProvider = Provider<AnalysisService>(
  (ref) => AnalysisService(ref.watch(apiClientProvider)),
);

/// State of the analysis-report list (paged, newest first).
class AnalysisListState {
  const AnalysisListState({
    this.items = const [],
    this.isLoading = false,
    this.hasMore = true,
    this.page = 1,
    this.errorMessage,
  });

  final List<AnalysisReportListItem> items;
  final bool isLoading;
  final bool hasMore;

  /// Last page that was requested successfully.
  final int page;
  final String? errorMessage;

  bool get isEmpty => items.isEmpty;

  AnalysisListState copyWith({
    List<AnalysisReportListItem>? items,
    bool? isLoading,
    bool? hasMore,
    int? page,
    String? errorMessage,
    bool clearError = false,
  }) {
    return AnalysisListState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      hasMore: hasMore ?? this.hasMore,
      page: page ?? this.page,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}

class AnalysisListNotifier extends AutoDisposeNotifier<AnalysisListState> {
  static const _pageSize = 10;

  @override
  AnalysisListState build() => const AnalysisListState();

  /// Loads the next page; no-op while loading or after the last page.
  Future<void> loadNextPage() async {
    final current = state;
    if (current.isLoading || !current.hasMore) return;

    state = current.copyWith(isLoading: true, clearError: true);
    try {
      final paged = await ref
          .read(analysisServiceProvider)
          .getReports(page: current.page, size: _pageSize);

      state = state.copyWith(
        items: [...state.items, ...paged.items],
        isLoading: false,
        hasMore: paged.metadata.hasNextPage,
        page: current.page + 1,
      );
    } on ApiException catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.message);
    } on DioException catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: dioErrorMessage(e),
      );
    } catch (_) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: LocalApiError.loadData,
      );
    }
  }

  /// Drops every loaded page and fetches page 1 again.
  Future<void> refresh() async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final paged = await ref
          .read(analysisServiceProvider)
          .getReports(page: 1, size: _pageSize);

      state = state.copyWith(
        items: paged.items,
        isLoading: false,
        hasMore: paged.metadata.hasNextPage,
        page: 2,
      );
    } on ApiException catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.message);
    } on DioException catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: dioErrorMessage(e),
      );
    } catch (_) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: LocalApiError.loadData,
      );
    }
  }

  void clearError() => state = state.copyWith(clearError: true);
}

/// Paged snapshots. `autoDispose` resets the list every time the screen is
/// reopened, which keeps the data fresh after a report is created elsewhere.
final analysisListProvider =
    NotifierProvider.autoDispose<AnalysisListNotifier, AnalysisListState>(
      AnalysisListNotifier.new,
    );

/// Full snapshot of one report.
final analysisReportProvider =
    FutureProvider.autoDispose.family<AnalysisReport, String>((ref, id) {
      return ref.watch(analysisServiceProvider).getReport(id);
    });

/// `accountId → doctor display name`.
///
/// The analysis payload only carries the doctor's **account** id, while
/// `GET /doctors/{id}` resolves by **profile** id. Walking the roster once
/// and caching the map is cheaper than one 404 per doctor row.
final doctorNamesProvider = FutureProvider<Map<String, String>>((ref) async {
  final names = <String, String>{};

  try {
    final current = await ref.watch(currentDoctorProvider.future);
    if (current != null && current.accountId.isNotEmpty) {
      names[current.accountId] = current.fullName.trim();
    }
  } catch (_) {
    // The signed-in doctor may not have a profile (e.g. Admin accounts).
  }

  try {
    final service = ref.watch(doctorServiceProvider);
    var page = 1;
    const pageSize = 100;
    while (true) {
      final items = await service.listDoctors(page: page, size: pageSize);
      for (final doctor in items) {
        if (doctor.accountId.isEmpty) continue;
        final name = doctor.fullName.trim();
        if (name.isNotEmpty) names[doctor.accountId] = name;
      }
      if (items.length < pageSize) break;
      page++;
    }
  } catch (_) {
    // Names are cosmetic: fall back to the ids already collected.
  }

  return names;
});
