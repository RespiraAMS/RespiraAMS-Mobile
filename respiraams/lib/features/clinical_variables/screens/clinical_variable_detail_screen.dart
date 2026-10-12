import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../design_system/design_system.dart';
import '../models/clinical_variable.dart';
import '../providers/clinical_variable_provider.dart';

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

  String _translateValueType(ValueType type) {
    switch (type) {
      case ValueType.numeric: return 'Nhập số';
      case ValueType.boolean: return 'Có / Không';
      case ValueType.categorical: return 'Phân loại';
      default: return 'Khác';
    }
  }

  String _translateCategory(VariableCategory cat) {
    switch (cat) {
      case VariableCategory.personalInformation: return 'Thông tin cá nhân';
      case VariableCategory.paraclinical: return 'Cận lâm sàng';
      case VariableCategory.clinical: return 'Lâm sàng';
      default: return 'Khác';
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = context.respiraColors;

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
                      title: 'Chi tiết biến số',
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
                      title: 'Chi tiết biến số',
                      subtitle: 'Lỗi tải dữ liệu',
                      onBack: () => Navigator.pop(context),
                    ),
                  ),
                  Expanded(child: Center(child: AppText('Không tải được thông tin: ${snapshot.error}', color: c.error))),
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
                    subtitle: 'Biến số lâm sàng',
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
                              child: Icon(LucideIcons.variable, color: c.iconPrimary, size: 24),
                            ),
                            const SizedBox(width: Spacing.control),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppText(detail.name, type: AppTextType.h3, fontWeight: FontWeight.w700),
                                  const SizedBox(height: 4),
                                  AppText(_translateCategory(detail.category), type: AppTextType.caption),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: Spacing.section),

                      if (detail.description.isNotEmpty) ...[
                        AppText('Mô tả', type: AppTextType.bodyLarge, fontWeight: FontWeight.w700),
                        const SizedBox(height: Spacing.control),
                        AppText(detail.description, type: AppTextType.body, color: c.textPrimary),
                        const SizedBox(height: Spacing.section),
                      ],

                      AppText('Cấu hình biến số', type: AppTextType.bodyLarge, fontWeight: FontWeight.w700),
                      const SizedBox(height: Spacing.control),
                      AppCard.divided(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        [
                          _InfoRow(label: 'Loại dữ liệu', value: _translateValueType(detail.valueType)),
                          if (detail.canonicalUnit != null)
                            _InfoRow(label: 'Đơn vị chuẩn', value: detail.canonicalUnit!),
                          _InfoRow(
                            label: 'Tính bắt buộc', 
                            value: detail.isRequired ? 'Bắt buộc nhập' : 'Tùy chọn',
                            valueColor: detail.isRequired ? c.error : c.textPrimary,
                          ),
                          if (detail.prerequisite != null)
                            _InfoRow(label: 'Điều kiện tiên quyết', value: detail.prerequisite!),
                        ],
                      ),
                      const SizedBox(height: Spacing.section),

                      if (detail.valueType == ValueType.numeric && (detail.acceptedRange != null || detail.normalRange != null)) ...[
                        AppText('Khoảng giá trị', type: AppTextType.bodyLarge, fontWeight: FontWeight.w700),
                        const SizedBox(height: Spacing.control),
                        AppCard.divided(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          [
                            if (detail.acceptedRange != null)
                              _InfoRow(label: 'Chấp nhận', value: detail.acceptedRange!.formatDisplay()),
                            if (detail.normalRange != null)
                              _InfoRow(
                                label: 'Bình thường', 
                                value: detail.normalRange!.formatDisplay(),
                                valueColor: c.success,
                              ),
                          ],
                        ),
                        const SizedBox(height: Spacing.section),
                      ],

                      if (detail.valueType == ValueType.categorical && detail.acceptedValues != null && detail.acceptedValues!.isNotEmpty) ...[
                        AppText('Danh sách lựa chọn', type: AppTextType.bodyLarge, fontWeight: FontWeight.w700),
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