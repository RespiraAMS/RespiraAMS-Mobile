import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/context_extensions.dart';
import '../../../../design_system/design_system.dart';
import '../models/clinical_dtos.dart';
import '../models/diagnosis_result.dart';
import '../providers/diagnosis_flow_provider.dart';
import '../providers/diagnosis_tab_controller.dart';
import '../widgets/risk_pill_widget.dart';
import '../widgets/stat_tile_widget.dart';

import '../routes.dart';

/// Route `/diagnosis-result` — wizard output (result summary · suspected
/// pathogens · evidences), rendered from the real `POST /diagnose/empirical`
/// response.
class DiagnosisResultScreen extends ConsumerWidget {
  const DiagnosisResultScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final result = ref.watch(diagnosisFlowControllerProvider).result;
    final tab = ref.watch(diagnosisTabControllerProvider);
    final tabController = ref.read(diagnosisTabControllerProvider.notifier);

    if (result == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Spacing.group),
          child: LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AppAppBar(
                        title: 'Kết quả chẩn đoán',
                        subtitle: 'Kinh nghiệm · Viêm phổi cộng đồng',
                        onBack: () => context.goBackOr(DiagnosisRoutes.wizard),
                      ),
                      const SizedBox(height: Spacing.inline + 4),
                      AppSegmentedTabs<DiagnosisTab>(
                        segments: [
                          for (final t in DiagnosisTab.values) (t, t.label),
                        ],
                        selected: tab,
                        onChanged: tabController.select,
                      ),
                      const SizedBox(height: Spacing.section),
                      switch (tab) {
                        DiagnosisTab.result => _ResultTab(result: result),
                        DiagnosisTab.suspected =>
                          _SuspectedTab(result: result),
                        DiagnosisTab.evidences =>
                          _EvidencesTab(evidences: result.evidences),
                      },
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: Spacing.block,
                          bottom: Spacing.lg,
                        ),
                        child: AppButton(
                          label: 'Lưu kết quả',
                          expand: true,
                          onPressed: () => showAppToast(
                            context,
                            'Tính năng đang phát triển.',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TypographyTokens.bodyLarge(
        context,
      ).copyWith(fontWeight: FontWeight.w700),
    );
  }
}

String _severityLabel(String severity) => switch (severity) {
      'Mild' => 'Nhẹ',
      'Moderate' => 'Trung bình',
      'Severe' => 'Nặng',
      _ => severity,
    };

String _siteLabel(String site) => switch (site) {
      'Inpatient' => 'Nội trú',
      'IntensiveCareUnit' => 'ICU',
      _ => 'Ngoại trú',
    };

class _ResultTab extends StatelessWidget {
  const _ResultTab({required this.result});

  final DiagnoseResultDto result;

  @override
  Widget build(BuildContext context) {
    final c = context.respiraColors;
    final severityIsHigh = result.severity == 'Severe';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const _SectionTitle('Chẩn đoán'),
        const SizedBox(height: Spacing.xxs + 4),
        AppSurface(
          radius: AppRadius.mdValue,
          color: c.surfaceSecondary,
          borderColor: Colors.transparent,
          padding: const EdgeInsets.all(Spacing.group - 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Viêm phổi cộng đồng',
                style:
                    TypographyTokens.h3(context).copyWith(color: c.textPrimary),
              ),
              const SizedBox(height: Spacing.xxxs),
              AppText('Chẩn đoán kinh nghiệm', type: AppTextType.caption),
            ],
          ),
        ),
        const SizedBox(height: Spacing.section),
        const _SectionTitle('Đánh giá'),
        const SizedBox(height: Spacing.control - 4),
        Row(
          children: [
            Expanded(
              child: StatTileWidget(
                label: 'Mức độ',
                value: _severityLabel(result.severity),
                tone: StatTileTone.primary,
              ),
            ),
            const SizedBox(width: Spacing.group),
            Expanded(
              child: StatTileWidget(
                label: 'Điều trị',
                value: _siteLabel(result.treatmentSite),
              ),
            ),
          ],
        ),
        const SizedBox(height: Spacing.block - 4),
        RiskPillWidget(
          label: severityIsHigh ? 'Nguy cơ cao' : 'Nguy cơ thấp',
          isHigh: severityIsHigh,
        ),
        if (result.isPatientPregnantOrInLactationPhase) ...[
          const SizedBox(height: Spacing.control),
          const ClinicalAlert(
            severity: ClinicalSeverity.needsAttention,
            title: 'Bệnh nhân đang mang thai / cho con bú',
            description: 'Cân nhắc kỹ trước khi chỉ định kháng sinh.',
          ),
        ],
        if (result.missingVariables.isNotEmpty) ...[
          const SizedBox(height: Spacing.control),
          ClinicalAlert(
            severity: ClinicalSeverity.needsAttention,
            title: 'Thiếu thông tin cần thiết',
            description: result.missingVariables
                .map((v) => v.name)
                .take(6)
                .join(', '),
          ),
        ],
        const SizedBox(height: Spacing.control + 4),
        AppText(
          'Kết quả cần được bác sĩ xác nhận trước khi áp dụng điều trị.',
          type: AppTextType.caption,
        ),
      ],
    );
  }
}

class _SuspectedTab extends StatelessWidget {
  const _SuspectedTab({required this.result});

  final DiagnoseResultDto result;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const _SectionTitle('Căn nguyên nghi ngờ cao'),
        const SizedBox(height: Spacing.control + 4),
        if (result.heavySuspected.isEmpty)
          const AppText('Không có dữ liệu.', type: AppTextType.caption)
        else
          AppCard.divided([
            for (final pathogen in result.heavySuspected)
              _RefRow(title: pathogen.name),
          ]),
        const SizedBox(height: Spacing.section),
        const _SectionTitle('Căn nguyên cần lưu ý'),
        const SizedBox(height: Spacing.control + 4),
        if (result.worthSuspected.isEmpty)
          const AppText('Không có dữ liệu.', type: AppTextType.caption)
        else
          AppCard.divided([
            for (final pathogen in result.worthSuspected)
              _RefRow(title: pathogen.name),
          ]),
      ],
    );
  }
}

class _RefRow extends StatelessWidget {
  const _RefRow({required this.title, this.trailing});

  final String title;
  final String? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Spacing.control,
        vertical: Spacing.group,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TypographyTokens.body(context)
                  .copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          if (trailing != null)
            AppText(trailing!, type: AppTextType.caption),
        ],
      ),
    );
  }
}

class _EvidencesTab extends StatelessWidget {
  const _EvidencesTab({required this.evidences});

  final List<EvidenceDto> evidences;

  @override
  Widget build(BuildContext context) {
    // Only criteria that actually contributed points are meaningful here.
    final scored = evidences
        .where((e) => e.score != null && e.score != 0)
        .toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const _SectionTitle('Bằng chứng lâm sàng'),
        const SizedBox(height: Spacing.control + 4),
        if (scored.isEmpty)
          const AppText('Không có dữ liệu.', type: AppTextType.caption)
        else
          AppCard.divided([
            for (final evidence in scored)
              _RefRow(
                title: evidence.source,
                trailing: _evidenceTrailing(evidence),
              ),
          ]),
      ],
    );
  }

  String? _evidenceTrailing(EvidenceDto evidence) {
    if (evidence.score != null) return 'Điểm ${evidence.score}';
    if (evidence.isMajor == true) return 'Chính';
    if (evidence.isMajor == false) return 'Phụ';
    return null;
  }
}
