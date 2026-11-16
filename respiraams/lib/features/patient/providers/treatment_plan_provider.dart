import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_client.dart';
import '../models/patient_dtos.dart';
import '../services/patient_service.dart';

/// `GET /treatment-plans/{id}` — full plan detail (read-only on mobile).
final treatmentPlanProvider =
    FutureProvider.autoDispose.family<TreatmentPlanDetailDto, String>((
      ref,
      id,
    ) {
      final service = PatientService(ref.watch(apiClientProvider));
      return service.getTreatmentPlan(id);
    });
