import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../design_system/design_system.dart';
import '../models/risk_factor.dart';
import '../providers/risk_factor_provider.dart';
// Import Widget hiển thị Formula
import '../../clinical_variables/widgets/formula_display_widget.dart';

class RiskFactorDetailScreen extends StatefulWidget {
  final String riskFactorId;

  const RiskFactorDetailScreen({super.key, required this.riskFactorId});

  @override
  State<RiskFactorDetailScreen> createState() => _RiskFactorDetailScreenState();
}

class _RiskFactorDetailScreenState extends State<RiskFactorDetailScreen> {
  late Future<RiskFactor> _detailFuture;

  @override
  void initState() {
    super.initState();
    _detailFuture = context.read<RiskFactorProvider>().fetchRiskFactorDetail(widget.riskFactorId);
  }

  @override
  Widget build(BuildContext context) {
    final c = context.respiraColors;

    return Scaffold(
      backgroundColor: c.background,
      body: SafeArea(
        child: FutureBuilder<RiskFactor>(
          future: _detailFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator(color: c.primary));
            }
            if (!snapshot.hasData || snapshot.hasError) {
              return Center(child: AppText('Không tải được thông tin', color: c.error));
            }

            final detail = snapshot.data!;

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Spacing.group, vertical: 8),
                  child: AppAppBar(
                    title: 'Chi tiết Yếu tố',
                    subtitle: 'Nguy cơ theo tác nhân',
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
                              child: Icon(LucideIcons.alertTriangle, color: c.iconPrimary, size: 24),
                            ),
                            const SizedBox(width: Spacing.control),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppText(detail.criterion.name, type: AppTextType.h3, fontWeight: FontWeight.w700),
                                  const SizedBox(height: 4),
                                  AppText('Yếu tố nguy cơ', type: AppTextType.caption),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: Spacing.section),

                      AppText('Tác nhân liên quan', type: AppTextType.bodyLarge, fontWeight: FontWeight.w700),
                      const SizedBox(height: Spacing.control),
                      AppSurface(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        child: Row(
                          children: [
                            Icon(LucideIcons.bug, size: 20, color: c.textPrimary),
                            const SizedBox(width: 12),
                            Expanded(
                              child: AppText(
                                detail.pathogen.name, 
                                type: AppTextType.bodyMedium, 
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            if (detail.pathogen.isAtypical == true)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(color: c.warningSoft, borderRadius: AppRadius.full),
                                child: AppText('Không điển hình', type: AppTextType.label, color: c.warning),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: Spacing.section),

                      AppText('Công thức điều kiện', type: AppTextType.bodyLarge, fontWeight: FontWeight.w700),
                      const SizedBox(height: Spacing.control),
                      FormulaDisplayWidget(rawFormula: detail.criterion.formula),
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