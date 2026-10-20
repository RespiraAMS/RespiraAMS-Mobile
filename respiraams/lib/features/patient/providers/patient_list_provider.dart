import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/api_client.dart';
import '../../../core/network/api_response.dart';
import '../../../core/network/pagination_dto.dart';
import '../models/patient_dtos.dart';
import '../models/patient_summary.dart';
import '../services/patient_service.dart';

part 'patient_list_provider.freezed.dart';
part 'patient_list_provider.g.dart';

/// Triage filter chips of the patient list screen.
enum PatientListFilter { all, attention, highRisk }

/// Paged + filtered roster state backed by `GET /patients` (and
/// `GET /patients/search` when a query is present).
///
/// The backend does not support triage filtering; the chips are applied
/// client-side over the loaded pages (user-approved limitation).
@freezed
class PatientListState with _$PatientListState {
  const factory PatientListState({
    @Default('') String query,
    @Default(PatientListFilter.all) PatientListFilter filter,
    @Default(false) bool prioritySort,
    @Default(false) bool loading,
    @Default(false) bool loadingMore,
    @Default(false) bool hasMore,
    String? errorMessage,
    @Default([]) List<PatientSummary> patients,
    @Default(1) int page,
  }) = _PatientListState;
}

@Riverpod(keepAlive: true)
class PatientListController extends _$PatientListController {
  PatientService get _service =>
      PatientService(ref.watch(apiClientProvider));

  @override
  PatientListState build() => const PatientListState();

  void setQuery(String value) {
    state = state.copyWith(query: value);
    refresh();
  }

  void setFilter(PatientListFilter filter) =>
      state = state.copyWith(filter: filter);

  void togglePrioritySort() =>
      state = state.copyWith(prioritySort: !state.prioritySort);

  /// Reloads page 1 (also used by pull-to-refresh).
  Future<void> refresh() async {
    state = state.copyWith(loading: true, errorMessage: null, page: 1);
    try {
      final paged = await _fetch(page: 1);
      state = state.copyWith(
        loading: false,
        patients: _map(paged.items),
        hasMore: paged.metadata.hasNextPage,
        page: 1,
      );
    } on ApiException catch (e) {
      state = state.copyWith(loading: false, errorMessage: e.message);
    } on DioException catch (e) {
      state = state.copyWith(
        loading: false,
        errorMessage: dioErrorMessage(e),
      );
    }
  }

  /// Loads the next page.
  Future<void> loadMore() async {
    if (state.loadingMore || !state.hasMore) return;
    state = state.copyWith(loadingMore: true);
    try {
      final nextPage = state.page + 1;
      final paged = await _fetch(page: nextPage);
      state = state.copyWith(
        loadingMore: false,
        page: nextPage,
        hasMore: paged.metadata.hasNextPage,
        patients: [...state.patients, ..._map(paged.items)],
      );
    } on Exception {
      state = state.copyWith(loadingMore: false);
    }
  }

  /// Empty query → `GET /patients`; otherwise `GET /patients/search`.
  Future<Paged<PatientListItemDto>> _fetch({required int page}) {
    final query = state.query.trim();
    if (query.isEmpty) {
      return _service.getPatients(page: page);
    }
    return _service.searchPatients(searchTerm: query, page: page);
  }

  List<PatientSummary> _map(Iterable<PatientListItemDto> items) =>
      items.map((dto) {
        final status = switch (dto.treatmentOutcome) {
          PatientStatusDto.inTreatment => PatientStatus.treating,
          PatientStatusDto.recovered => PatientStatus.recovered,
          PatientStatusDto.death => PatientStatus.deceased,
          PatientStatusDto.outOfScope => PatientStatus.recovered,
        };
        return PatientSummary(
          id: dto.id,
          name: dto.fullName,
          code: dto.medicalRecordCode,
          genderLabel: dto.gender == 'Male' ? 'Nam' : 'Nữ',
          age: dto.age,
          status: status,
        );
      }).toList();
}

/// Applies the triage chips + priority sort over the loaded roster.
@riverpod
List<PatientSummary> visiblePatients(VisiblePatientsRef ref) {
  final listState = ref.watch(patientListControllerProvider);

  var patients = listState.patients.where((p) {
    return switch (listState.filter) {
      PatientListFilter.all => true,
      PatientListFilter.attention => p.status == PatientStatus.treating,
      PatientListFilter.highRisk => p.status == PatientStatus.deceased,
    };
  }).toList();

  if (listState.prioritySort) {
    int rank(PatientStatus s) => switch (s) {
          PatientStatus.deceased => 0,
          PatientStatus.treating => 1,
          PatientStatus.recovered => 2,
        };
    patients.sort((a, b) {
      final byRank = rank(a.status).compareTo(rank(b.status));
      return byRank != 0 ? byRank : a.name.compareTo(b.name);
    });
  }

  return patients;
}
