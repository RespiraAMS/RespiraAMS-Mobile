import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_client.dart';
import '../../patient/models/patient_dtos.dart';
import '../../patient/services/patient_service.dart';

/// Snapshot shown on the welcome screen, backed by `GET /patients`.
class WelcomeSummary {
  const WelcomeSummary({
    required this.totalPatients,
    required this.treatingPatients,
    required this.syncedAt,
  });

  /// `metadata.totalItemCount` of the roster.
  final int totalPatients;

  /// Patients whose outcome is `InTreatment` (counted over the first 100 rows).
  final int treatingPatients;

  /// When the snapshot was fetched (shown as "synced at HH:mm").
  final DateTime syncedAt;
}

/// Loads the workspace summary for the post-login welcome page.
///
/// The roster endpoint has no outcome filter, so the treating count is derived
/// from the first page (capped at 100 patients).
final AutoDisposeFutureProvider<WelcomeSummary> welcomeSummaryProvider =
    FutureProvider.autoDispose<WelcomeSummary>((ref) async {
  final service = PatientService(ref.watch(apiClientProvider));
  final page = await service.getPatients(page: 1, size: 100);
  final treating = page.items
      .where((item) => item.treatmentOutcome == PatientStatusDto.inTreatment)
      .length;

  return WelcomeSummary(
    totalPatients: page.metadata.totalItemCount,
    treatingPatients: treating,
    syncedAt: DateTime.now(),
  );
});
