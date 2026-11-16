import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../design_system/design_system.dart';
import '../../../../l10n/l10n.dart';
import '../../../core/network/api_client.dart';
import '../../antibiotic/providers/antibiotic_provider.dart';
import '../../antibiotic/providers/antibiotic_service.dart';
import '../../antibiotic/screens/antibiotic_list_screen.dart';
import '../../antibioticGroup/providers/antibiotic_group_provider.dart';
import '../../antibioticGroup/providers/antibiotic_group_service.dart';
import '../../antibioticGroup/screens/antibiotic_group_list_screen.dart';
import '../../antibiogram/providers/antibiogram_provider.dart';
import '../../antibiogram/providers/antibiogram_service.dart';
import '../../antibiogram/screens/antibiogram_list_screen.dart';
import '../../clinical_metrics/providers/clinical_metric_provider.dart';
import '../../clinical_metrics/providers/clinical_metric_service.dart';
import '../../clinical_metrics/screens/clinical_metric_list_screen.dart';
import '../../clinical_variables/providers/clinical_variable_provider.dart';
import '../../clinical_variables/providers/clinical_variable_service.dart';
import '../../clinical_variables/screens/clinical_variable_list_screen.dart';
import '../../criteria/providers/criterion_provider.dart';
import '../../criteria/providers/criterion_service.dart';
import '../../criteria/screens/criterion_list_screen.dart';
import '../../pathogen/providers/pathogen_provider.dart';
import '../../pathogen/providers/pathogen_service.dart';
import '../../pathogen/screens/pathogen_list_screen.dart';
import '../../risk_factors/providers/risk_factor_provider.dart';
import '../../risk_factors/providers/risk_factor_service.dart';
import '../../risk_factors/screens/risk_factor_list_screen.dart';
import '../../suspected_causes/providers/suspected_cause_provider.dart';
import '../../suspected_causes/providers/suspected_cause_service.dart';
import '../../suspected_causes/screens/suspected_cause_list_screen.dart';
import '../../treatment_protocol/providers/treatment_protocol_provider.dart';
import '../../treatment_protocol/providers/treatment_protocol_service.dart';
import '../../treatment_protocol/screens/treatment_protocol_list_screen.dart';
import '../models/lookup_category.dart';

class CategoryGridItem extends StatelessWidget {
  final LookupCategory category;

  const CategoryGridItem({super.key, required this.category});

  void _open(BuildContext context) {
    switch (category.id) {
      case LookupCategoryId.antibiotics:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
              create: (_) {
                final apiClient = ApiClient();
                final repository = AntibioticRepository(apiClient: apiClient);
                return AntibioticProvider(repository);
              },
              child: const AntibioticListScreen(),
            ),
          ),
        );
      case LookupCategoryId.antibioticGroups:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
              create: (_) {
                final apiClient = ApiClient();
                final repository = AntibioticGroupRepository(apiClient: apiClient);
                return AntibioticGroupProvider(repository);
              },
              child: const AntibioticGroupListScreen(),
            ),
          ),
        );
      case LookupCategoryId.pathogens:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
              create: (_) {
                final apiClient = ApiClient();
                final repository = PathogenRepository(apiClient: apiClient);
                return PathogenProvider(repository);
              },
              child: const PathogenListScreen(),
            ),
          ),
        );
      case LookupCategoryId.antibiograms:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
              create: (_) {
                final apiClient = ApiClient();
                final repository = AntibiogramRepository(apiClient: apiClient);
                return AntibiogramProvider(repository);
              },
              child: const AntibiogramListScreen(),
            ),
          ),
        );
      case LookupCategoryId.treatmentProtocols:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
              create: (_) {
                final apiClient = ApiClient();
                final repository = TreatmentProtocolRepository(
                  apiClient: apiClient,
                );
                return TreatmentProtocolProvider(repository);
              },
              child: const TreatmentProtocolListScreen(),
            ),
          ),
        );
      case LookupCategoryId.clinicalVariables:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
              create: (_) {
                final apiClient = ApiClient();
                final repository = ClinicalVariableRepository(apiClient: apiClient);
                return ClinicalVariableProvider(repository);
              },
              child: const ClinicalVariableListScreen(),
            ),
          ),
        );
      case LookupCategoryId.suspectedCauses:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
              create: (_) {
                final apiClient = ApiClient();
                final repository = SuspectedCauseRepository(apiClient: apiClient);
                return SuspectedCauseProvider(repository);
              },
              child: const SuspectedCauseListScreen(),
            ),
          ),
        );
      case LookupCategoryId.criteria:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
              create: (_) {
                final apiClient = ApiClient();
                final repository = CriterionRepository(apiClient: apiClient);
                return CriterionProvider(repository);
              },
              child: const CriterionListScreen(),
            ),
          ),
        );
      case LookupCategoryId.riskFactors:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
              create: (_) {
                final apiClient = ApiClient();
                final repository = RiskFactorRepository(apiClient: apiClient);
                return RiskFactorProvider(repository);
              },
              child: const RiskFactorListScreen(),
            ),
          ),
        );
      case LookupCategoryId.clinicalMetrics:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
              create: (_) {
                final apiClient = ApiClient();
                final repository = ClinicalMetricRepository(apiClient: apiClient);
                return ClinicalMetricProvider(repository);
              },
              child: const ClinicalMetricListScreen(),
            ),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = context.respiraColors;
    final l10n = context.l10n;

    return GestureDetector(
      onTap: () => _open(context),
      child: AppSurface(
        radius: AppRadius.mdValue,
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Icon Container
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: c.primarySoft,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: AppIcon(
                  category.icon,
                  size: ControlSize.iconXl,
                  color: c.iconPrimary,
                ),
              ),
            ),

            // Texts
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category.id.title(l10n),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TypographyTokens.caption(
                    context,
                  ).copyWith(fontWeight: FontWeight.w600, color: c.textPrimary),
                ),
                const SizedBox(height: 2),
                Text(
                  category.id.subtitle(l10n),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 10,
                    height: 12 / 10,
                    color: c.textSecondary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
