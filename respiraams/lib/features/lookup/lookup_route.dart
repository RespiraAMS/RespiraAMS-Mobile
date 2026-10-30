import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../core/network/api_client.dart';
import '../antibiotic/providers/antibiotic_provider.dart';
import '../antibiotic/providers/antibiotic_service.dart';
import '../antibiotic/screens/antibiotic_list_screen.dart';
import '../antibioticGroup/providers/antibiotic_group_provider.dart';
import '../antibioticGroup/providers/antibiotic_group_service.dart';
import '../antibioticGroup/screens/antibiotic_group_list_screen.dart';
import '../pathogen/providers/pathogen_provider.dart';
import '../pathogen/providers/pathogen_service.dart';
import '../pathogen/screens/pathogen_list_screen.dart';
import 'screens/medical_lookup_screen.dart';

class LookupRoutes {
  static const lookup = '/lookup';
  static const pathogens = '/lookup/pathogens';
  static const antibiotics = '/lookup/antibiotics';
  static const antibioticGroups = '/lookup/antibiotic-groups';
  static const antibiograms = '/lookup/antibiograms';
  static const diseases = '/lookup/diseases';
}

final List<RouteBase> lookupRoutes = [
  GoRoute(
    path: LookupRoutes.lookup,
    builder: (context, state) => const MedicalLookupScreen(),
  ),
  GoRoute(
    path: LookupRoutes.pathogens,
    builder: (context, state) => ChangeNotifierProvider(
      create: (_) => PathogenProvider(
        PathogenRepository(apiClient: ApiClient()),
      ),
      child: const PathogenListScreen(),
    ),
  ),
  GoRoute(
    path: LookupRoutes.antibiotics,
    builder: (context, state) => ChangeNotifierProvider(
      create: (_) => AntibioticProvider(
        AntibioticRepository(apiClient: ApiClient()),
      ),
      child: const AntibioticListScreen(),
    ),
  ),
  GoRoute(
    path: LookupRoutes.antibioticGroups,
    builder: (context, state) => ChangeNotifierProvider(
      create: (_) => AntibioticGroupProvider(
        AntibioticGroupRepository(apiClient: ApiClient()),
      ),
      child: const AntibioticGroupListScreen(),
    ),
  ),
];
