import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/context_extensions.dart';
import '../../../../design_system/design_system.dart';
import '../models/patient.dart';
import '../models/patient_dtos.dart';
import '../providers/active_patient_provider.dart';
import '../providers/current_patient_provider.dart';
import '../providers/patient_detail_provider.dart';
import '../widgets/info_row_widget.dart';
import '../widgets/section_label_widget.dart';
import '../widgets/timeline_widget.dart';
import '../routes.dart';

/// Route `/patient/detail` — read-only profile and treatment timeline.
///
/// Loads the record from `GET /patients/{id}` (passed as query parameter)
/// and mirrors it into the active patient so progress/diagnosis screens
/// reflect the selection. Falls back to the active patient when no id is
/// supplied.
class PatientDetailScreen extends ConsumerWidget {
  const PatientDetailScreen({super.key, this.patientId});

  final String? patientId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = patientId;

    if (id != null && id.isNotEmpty) {
      ref.listen(patientDetailProvider(id), (_, next) {
        next.whenData(
          (dto) => ref
              .read(activePatientControllerProvider.notifier)
              .set(Patient.fromDetail(dto)),
        );
      });

      return ref.watch(patientDetailProvider(id)).when(
            loading: () => const _StateScaffold(
              child: CircularProgressIndicator(),
            ),
            error: (_, _) => const _StateScaffold(
              child: AppText(
                'Không thể tải hồ sơ bệnh nhân.',
                type: AppTextType.caption,
              ),
            ),
            data: (dto) => _ProfileView(
              patient: Patient.fromDetail(dto),
              statusLabel: _statusLabel(dto.treatmentOutcome),
              treatments: dto.treatments,
            ),
          );
    }

    final patient = ref.watch(currentPatientProvider);
    if (patient == null) {
      return const _StateScaffold(
        child: AppText('Chưa chọn bệnh nhân.', type: AppTextType.caption),
      );
    }
    return _ProfileView(patient: patient);
  }
}

String _statusLabel(PatientStatusDto outcome) => switch (outcome) {
      PatientStatusDto.inTreatment => 'Đang điều trị',
      PatientStatusDto.recovered => 'Hồi phục',
      PatientStatusDto.death => 'Tử vong',
      PatientStatusDto.outOfScope => 'Ngoài phạm vi điều trị',
    };

/// Shared shell for the loading / error / empty states.
class _StateScaffold extends StatelessWidget {
  const _StateScaffold({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Spacing.group),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppAppBar(
                title: 'Chi tiết bệnh nhân',
                subtitle: 'Thông tin chỉ đọc và tiến trình điều trị',
                onBack: () => context.goBackOr(PatientRoutes.list),
              ),
              Expanded(child: Center(child: child)),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileView extends StatelessWidget {
  const _ProfileView({
    required this.patient,
    this.statusLabel,
    this.treatments = const [],
  });

  final Patient patient;
  final String? statusLabel;
  final List<TreatmentItemDto> treatments;

  @override
  Widget build(BuildContext context) {
    final avatarGlyph = patient.gender == Gender.nam ? '👨🏻' : '👩🏾';
    final vitals = (patient.heightCm != null && patient.weightKg != null)
        ? '${patient.weightKg!.toStringAsFixed(0)} kg · '
            '${patient.heightCm!.toStringAsFixed(0)} cm'
        : '—';
    final entries = [
      for (var i = 0; i < treatments.length; i++)
        TreatmentTimelineEntry(
          dateLabel: 'Đợt ${i + 1}',
          title: 'Điều trị đã lưu',
          status: statusLabel ?? '',
        ),
    ];

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
                        title: 'Chi tiết bệnh nhân',
                        subtitle: 'Thông tin chỉ đọc và tiến trình điều trị',
                        onBack: () =>
                            context.goBackOr(PatientRoutes.list),
                      ),
                      const SizedBox(height: Spacing.block),
                      PatientHeader(
                        name: patient.name,
                        metadata:
                            '${patient.code} · ${patient.gender.displayName}',
                        avatarGlyph: avatarGlyph,
                      ),
                      const SizedBox(height: Spacing.section),
                      const SectionLabelWidget('Thông tin hồ sơ'),
                      const SizedBox(height: Spacing.xxs),
                      AppCard.divided(
                        [
                          InfoRowWidget(
                            label: 'Ngày sinh · Giới tính',
                            value:
                                '${patient.dob} · ${patient.gender.displayName}',
                          ),
                          InfoRowWidget(
                            label: 'BHYT',
                            value: patient.insurance,
                          ),
                          InfoRowWidget(
                            label: 'Địa chỉ',
                            value: patient.address,
                          ),
                          InfoRowWidget(
                            label: 'Thể trạng',
                            value: vitals,
                          ),
                          if (statusLabel != null)
                            InfoRowWidget(
                              label: 'Trạng thái điều trị',
                              value: statusLabel!,
                            ),
                        ],
                        padding: const EdgeInsets.symmetric(
                          horizontal: Spacing.group,
                        ),
                      ),
                      const SizedBox(height: Spacing.section),
                      const SectionLabelWidget('Tiến trình điều trị'),
                      const SizedBox(height: Spacing.inline),
                      Padding(
                        padding: const EdgeInsets.only(left: Spacing.xxs),
                        child: entries.isEmpty
                            ? const AppText(
                                'Chưa có diễn biến điều trị.',
                                type: AppTextType.caption,
                              )
                            : TimelineWidget(entries: entries),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: Spacing.block,
                          bottom: Spacing.lg,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: AppButton(
                                label: 'Thêm điều trị',
                                onPressed: () =>
                                    context.push(PatientRoutes.progress),
                              ),
                            ),
                            const SizedBox(width: Spacing.control),
                            Expanded(
                              child: AppButton(
                                label: 'Cập nhật trạng thái',
                                type: AppButtonType.outline,
                                onPressed: () =>
                                    context.push(PatientRoutes.progress),
                              ),
                            ),
                          ],
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
