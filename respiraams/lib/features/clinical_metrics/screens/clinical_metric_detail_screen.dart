import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../design_system/design_system.dart';
import '../models/clinical_metric.dart';
import '../providers/clinical_metric_provider.dart';
// Import Widget hiển thị Formula từ phần trước
import '../../clinical_variables/widgets/formula_display_widget.dart';

class ClinicalMetricDetailScreen extends StatefulWidget {
  final String metricId;

  const ClinicalMetricDetailScreen({super.key, required this.metricId});

  @override
  State<ClinicalMetricDetailScreen> createState() => _ClinicalMetricDetailScreenState();
}

class _ClinicalMetricDetailScreenState extends State<ClinicalMetricDetailScreen> {
  late Future<ClinicalMetricDetail> _detailFuture;

  @override
  void initState() {
    super.initState();
    _detailFuture = context.read<ClinicalMetricProvider>().fetchMetricDetail(widget.metricId);
  }

  @override
  Widget build(BuildContext context) {
    final c = context.respiraColors;

    return Scaffold(
      backgroundColor: c.background,
      body: SafeArea(
        child: FutureBuilder<ClinicalMetricDetail>(
          future: _detailFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Spacing.group, vertical: 8),
                    child: AppAppBar(
                      title: 'Chi tiết thang điểm',
                      subtitle: 'Đang tải...',
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
                      title: 'Chi tiết thang điểm',
                      subtitle: 'Lỗi tải dữ liệu',
                      onBack: () => Navigator.pop(context),
                    ),
                  ),
                  Expanded(child: Center(child: AppText('Không tải được thông tin: ${snapshot.error}', color: c.error))),
                ],
              );
            }

            final detail = snapshot.data!;

            final majorRules = detail.rules.where((r) => r.isMajorRule == true).toList();
            final minorRules = detail.rules.where((r) => r.isMajorRule != true).toList();

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Spacing.group, vertical: 8),
                  child: AppAppBar(
                    title: detail.code,
                    subtitle: 'Thang điểm đánh giá',
                    onBack: () => Navigator.pop(context),
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(Spacing.group, 8, Spacing.group, Spacing.screen),
                    children: [
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
                              child: Icon(LucideIcons.stethoscope, color: c.iconPrimary, size: 24),
                            ),
                            const SizedBox(width: Spacing.control),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppText(detail.name, type: AppTextType.h3, fontWeight: FontWeight.w700),
                                  const SizedBox(height: 4),
                                  AppText('Phiên bản: ${detail.version}', type: AppTextType.caption),
                                  if (detail.isApplied) ...[
                                    const SizedBox(height: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(color: c.successSoft, borderRadius: AppRadius.full),
                                      child: AppText('Đang áp dụng', type: AppTextType.caption, color: c.success),
                                    )
                                  ]
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: Spacing.section),

                      AppText('Thông tin chung', type: AppTextType.bodyLarge, fontWeight: FontWeight.w700),
                      const SizedBox(height: Spacing.control),
                      AppCard.divided(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        [
                          _InfoRow(label: 'Mã', value: detail.code),
                          _InfoRow(label: 'Phát hành', value: detail.publisher),
                          if (detail.description.isNotEmpty)
                          _InfoRow(label: 'Mô tả', value: detail.description),
                        ],
                      ),
                      const SizedBox(height: Spacing.section),

                      if (majorRules.isNotEmpty) ...[
                        AppText('Tiêu chí chính', type: AppTextType.bodyLarge, fontWeight: FontWeight.w700),
                        const SizedBox(height: Spacing.control),
                        ...majorRules.map((rule) => Padding(
                          padding: const EdgeInsets.only(bottom: Spacing.control),
                          child: _RuleCard(rule: rule, isMajor: true),
                        )),
                        const SizedBox(height: Spacing.group),
                      ],

                      if (minorRules.isNotEmpty) ...[
                        AppText(
                          majorRules.isNotEmpty ? 'Tiêu chí phụ' : 'Các tiêu chí tính điểm', 
                          type: AppTextType.bodyLarge, 
                          fontWeight: FontWeight.w700
                        ),
                        const SizedBox(height: Spacing.control),
                        ...minorRules.map((rule) => Padding(
                          padding: const EdgeInsets.only(bottom: Spacing.control),
                          child: _RuleCard(rule: rule, isMajor: false),
                        )),
                      ],
                      const SizedBox(height: Spacing.screen),
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

class _RuleCard extends StatelessWidget {
  final MetricRule rule;
  final bool isMajor;

  const _RuleCard({required this.rule, required this.isMajor});

  @override
  Widget build(BuildContext context) {
    final c = context.respiraColors;
    
    return AppSurface(
      padding: const EdgeInsets.all(Spacing.group),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: AppText(rule.criterion.name, type: AppTextType.bodyMedium, fontWeight: FontWeight.w600),
              ),
              if (rule.scoreFunction != null) ...[
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: c.surfaceSecondary, borderRadius: BorderRadius.circular(6)),
                  child: AppText(
                    '+ ${rule.scoreFunction} điểm', 
                    type: AppTextType.label, 
                    color: c.primary,
                  ),
                ),
              ]
            ],
          ),
          const SizedBox(height: Spacing.control),
          FormulaDisplayWidget(rawFormula: rule.criterion.formula),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final c = context.respiraColors;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText(label, type: AppTextType.label, color: c.textSecondary),
          const SizedBox(width: 16),
          Expanded(
            child: AppText(
              value, 
              type: AppTextType.label, 
              color: c.textPrimary, 
              fontWeight: FontWeight.w600,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}