import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../design_system/design_system.dart';
import '../../../../l10n/l10n.dart';
import '../models/clinical_variable.dart';
import '../providers/clinical_variable_provider.dart';
import '../widgets/formula_display_widget.dart';

class ClinicalVariableDetailScreen extends StatefulWidget {
  final String variableId;

  const ClinicalVariableDetailScreen({super.key, required this.variableId});

  @override
  State<ClinicalVariableDetailScreen> createState() => _ClinicalVariableDetailScreenState();
}

class _ClinicalVariableDetailScreenState extends State<ClinicalVariableDetailScreen> {
  late Future<ClinicalVariableDetail> _detailFuture;

  @override
  void initState() {
    super.initState();
    _detailFuture = context.read<ClinicalVariableProvider>().fetchVariableDetail(widget.variableId);
  }

  @override
  Widget build(BuildContext context) {
    final c = context.respiraColors;
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: c.background,
      body: SafeArea(
        child: FutureBuilder<ClinicalVariableDetail>(
          future: _detailFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Spacing.group, vertical: 8),
                    child: AppAppBar(
                      title: l10n.clinicalVariableDetailTitle,
                      subtitle: l10n.commonLoading,
                      onBack: () => Navigator.pop(context),
                    ),
                  ),
                  Expanded(child: Center(child: CircularProgressIndicator(color: c.primary))),
                ],
              );
            }

            if (!snapshot.hasData || snapshot.hasError) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Spacing.group, vertical: 8),
                    child: AppAppBar(
                      title: l10n.clinicalVariableDetailTitle,
                      subtitle: l10n.commonLoadFailedShort,
                      onBack: () => Navigator.pop(context),
                    ),
                  ),
                  Expanded(child: Center(child: AppText(l10n.commonLoadInfoError, color: c.error))),
                ],
              );
            }

            final detail = snapshot.data!;

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Spacing.group, vertical: 8),
                  child: AppAppBar(
                    title: detail.code,
                    subtitle: l10n.clinicalVariableTitle,
                    onBack: () => Navigator.pop(context),
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(Spacing.group, 8, Spacing.group, Spacing.screen),
                    children: [
                      // 1. Hero Card
                      Container(
                        padding: const EdgeInsets.all(Spacing.block),
                        decoration: BoxDecoration(
                          color: c.primarySoft,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 52, height: 52,
                              decoration: BoxDecoration(color: c.surface, shape: BoxShape.circle),
                              child: Icon(LucideIcons.clipboardList, color: c.iconPrimary, size: 24),
                            ),
                            const SizedBox(width: Spacing.control),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppText(detail.name, type: AppTextType.h3, fontWeight: FontWeight.w700),
                                  const SizedBox(height: 4),
                                  AppText(detail.category.label(l10n), type: AppTextType.caption),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: Spacing.section),

                      if (detail.description.isNotEmpty) ...[
                        AppText(l10n.pathogenDescription, type: AppTextType.bodyLarge, fontWeight: FontWeight.w700),
                        const SizedBox(height: Spacing.control),
                        AppText(detail.description, type: AppTextType.body, color: c.textPrimary),
                        const SizedBox(height: Spacing.section),
                      ],

                      AppText(l10n.clinicalVariableDetailConfig, type: AppTextType.bodyLarge, fontWeight: FontWeight.w700),
                      const SizedBox(height: Spacing.control),
                      AppCard.divided(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        [
                          _InfoRow(label: l10n.clinicalVariableValueType, value: detail.valueType.label(l10n)),
                          if (detail.canonicalUnit != null)
                            _InfoRow(label: l10n.clinicalVariableCanonicalUnit, value: detail.canonicalUnit!),
                          _InfoRow(
                            label: l10n.clinicalVariableIsRequired, 
                            value: detail.isRequired ? l10n.clinicalVariableRequiredYes : l10n.clinicalVariableOptional,
                            valueColor: detail.isRequired ? c.error : c.textPrimary,
                          ),
                        ],
                      ),
                      const SizedBox(height: Spacing.section),

                      if (detail.prerequisite != null && detail.prerequisite!.isNotEmpty) ...[
                        AppText(l10n.clinicalVariablePrerequisite, type: AppTextType.bodyLarge, fontWeight: FontWeight.w700),
                        const SizedBox(height: Spacing.control),
                        
                        FormulaDisplayWidget(rawFormula: detail.prerequisite!),
                        
                        const SizedBox(height: Spacing.section),
                      ],

                      if (detail.valueType == ValueType.numeric && (detail.acceptedRange != null || detail.normalRange != null)) ...[
                        AppText(l10n.clinicalVariableRange, type: AppTextType.bodyLarge, fontWeight: FontWeight.w700),
                        const SizedBox(height: Spacing.control),
                        AppCard.divided(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          [
                            if (detail.acceptedRange != null)
                              _InfoRow(label: l10n.clinicalVariableAccepted, value: detail.acceptedRange!.formatDisplay(l10n)),
                            if (detail.normalRange != null)
                              _InfoRow(
                                label: l10n.clinicalVariableNormal, 
                                value: detail.normalRange!.formatDisplay(l10n),
                                valueColor: c.success,
                              ),
                          ],
                        ),
                        const SizedBox(height: Spacing.section),
                      ],

                      if (detail.valueType == ValueType.categorical && detail.acceptedValues != null && detail.acceptedValues!.isNotEmpty) ...[
                        AppText(l10n.clinicalVariableOptions, type: AppTextType.bodyLarge, fontWeight: FontWeight.w700),
                        const SizedBox(height: Spacing.control),
                        AppCard.divided(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          detail.acceptedValues!.map((val) => _ListRow(title: val)).toList(),
                        ),
                        const SizedBox(height: Spacing.section),
                      ],
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const _InfoRow({required this.label, required this.value, this.valueColor});

  @override
  Widget build(BuildContext context) {
    final c = context.respiraColors;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText(label, type: AppTextType.label, color: c.textSecondary),
          Expanded(
            child: AppText(
              value, 
              type: AppTextType.label, 
              color: valueColor ?? c.textPrimary, 
              fontWeight: FontWeight.w600,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}

class _ListRow extends StatelessWidget {
  final String title;

  const _ListRow({required this.title});

  @override
  Widget build(BuildContext context) {
    final c = context.respiraColors;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      child: SizedBox(
        width: double.infinity,
        child: AppText(title, type: AppTextType.bodyMedium, color: c.textPrimary, fontWeight: FontWeight.w500),
      ),
    );
  }
}