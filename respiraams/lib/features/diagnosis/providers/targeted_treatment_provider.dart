import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/clinical_dtos.dart';

part 'targeted_treatment_provider.g.dart';

/// Demo pathogen list. The backend does not expose a targeted-therapy
/// contract yet, so the app keeps this flow on local demo data.
@Riverpod(keepAlive: true)
Future<List<PathogenItemDto>> pathogenList(PathogenListRef ref) async {
  return const [
    PathogenItemDto(id: 'demo-klebsiella', name: 'Klebsiella pneumoniae'),
  ];
}

/// Demo targeted diagnosis for the given pathogen.
@Riverpod(keepAlive: true)
Future<TargetedDiagnoseResultDto> targetedDiagnoseResult(
  TargetedDiagnoseResultRef ref,
  String pathogenId,
) async {
  return const TargetedDiagnoseResultDto(
    crcl: 78,
    recommendations: [
      AntibioticResultDto(
        id: 'demo-meropenem',
        name: 'Meropenem',
        antibioticGroupName: 'Carbapenem',
        classification: 'Beta-lactam',
        dosages: [DosageDto(routeOfAdministration: 'Intravenous', dose: '1g')],
      ),
      AntibioticResultDto(
        id: 'demo-ciprofloxacin',
        name: 'Ciprofloxacin',
        antibioticGroupName: 'Fluoroquinolone',
        classification: 'Quinolone',
        dosages: [DosageDto(routeOfAdministration: 'Oral', dose: '500mg')],
      ),
    ],
  );
}

/// Selected antibiotic IDs of the targeted-treatment screen.
@riverpod
class TargetedSelectionController extends _$TargetedSelectionController {
  @override
  Set<String> build() => {};

  void toggle(String optionId) {
    final next = {...state};
    if (!next.remove(optionId)) {
      next.add(optionId);
    }
    state = next;
  }
}
