import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../design_system/design_system.dart';
import '../providers/suspected_cause_provider.dart';
import '../models/suspected_cause.dart';
import '../models/pathogen_summary.dart';

class SuspectedCauseListScreen extends StatefulWidget {
  const SuspectedCauseListScreen({super.key});

  @override
  State<SuspectedCauseListScreen> createState() => _SuspectedCauseListScreenState();
}

class _SuspectedCauseListScreenState extends State<SuspectedCauseListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SuspectedCauseProvider>().fetchPage();
    });
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      context.read<SuspectedCauseProvider>().fetchPage();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _showFilterBottomSheet() {
    final provider = context.read<SuspectedCauseProvider>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: context.respiraColors.background,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) => _FilterBottomSheet(provider: provider),
    );
  }

  String _translateSeverity(DiseaseSeverity s) {
    switch (s) {
      case DiseaseSeverity.mild: return 'Nhẹ';
      case DiseaseSeverity.moderate: return 'Trung bình';
      case DiseaseSeverity.severe: return 'Nặng';
      default: return 'Khác';
    }
  }

  String _translateSite(TreatmentSite s) {
    switch (s) {
      case TreatmentSite.outpatient: return 'Ngoại trú';
      case TreatmentSite.inpatient: return 'Nội trú';
      case TreatmentSite.intensiveCareUnit: return 'ICU';
      default: return 'Khác';
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = context.respiraColors;

    return Scaffold(
      backgroundColor: c.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Spacing.group, vertical: 8),
              child: AppAppBar(
                title: 'Nguyên nhân nghi ngờ',
                subtitle: 'Mức độ & Nơi điều trị',
                onBack: () => Navigator.pop(context),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Spacing.group),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText('Danh sách tác nhân', type: AppTextType.bodyMedium, fontWeight: FontWeight.w700),
                  Consumer<SuspectedCauseProvider>(
                    builder: (context, provider, child) {
                      final hasFilter = provider.hasActiveFilters;
                      return GestureDetector(
                        onTap: _showFilterBottomSheet,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: hasFilter ? c.primary : c.surface,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            LucideIcons.listFilter, 
                            color: hasFilter ? Colors.white : c.iconPrimary, 
                            size: 20,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: Spacing.control),

            Expanded(
              child: Consumer<SuspectedCauseProvider>(
                builder: (context, provider, child) {
                  if (provider.errorMessage != null && provider.items.isNotEmpty) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      showAppToast(context, provider.errorMessage!);
                      provider.clearError();
                    });
                  }

                  if (provider.items.isEmpty && provider.isLoading) {
                    return Center(child: CircularProgressIndicator(color: c.primary));
                  }

                  if (provider.items.isEmpty && !provider.isLoading) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(LucideIcons.folderSearch, size: 48, color: c.textSecondary.withOpacity(0.5)),
                          const SizedBox(height: 16),
                          AppText('Không tìm thấy kết quả nào.', color: c.textSecondary),
                        ],
                      ),
                    );
                  }

                  return ListView.separated(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(Spacing.group),
                    itemCount: provider.items.length + (provider.hasMore ? 1 : 0),
                    separatorBuilder: (_, __) => const SizedBox(height: Spacing.control),
                    itemBuilder: (context, index) {
                      if (index == provider.items.length) {
                        return Padding(
                          padding: const EdgeInsets.all(Spacing.group),
                          child: Center(child: CircularProgressIndicator(color: c.primary)),
                        );
                      }

                      final item = provider.items[index];
                      Color sevColor = c.error; Color sevBg = c.errorSoft;
                      if (item.severity == DiseaseSeverity.mild) { sevColor = c.success; sevBg = c.successSoft; }
                      else if (item.severity == DiseaseSeverity.moderate) { sevColor = c.warning; sevBg = c.warningSoft; }

                      return AppSurface(
                        padding: const EdgeInsets.symmetric(horizontal: Spacing.group, vertical: Spacing.control),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(item.pathogenName, type: AppTextType.bodyMedium, fontWeight: FontWeight.w600),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                _buildTag(c, LucideIcons.activity, _translateSeverity(item.severity), bg: sevBg, color: sevColor),
                                const SizedBox(width: 8),
                                _buildTag(c, LucideIcons.mapPin, _translateSite(item.treatmentSite)),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTag(dynamic c, IconData icon, String label, {Color? bg, Color? color}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: bg ?? c.background, borderRadius: AppRadius.full),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color ?? c.textSecondary),
          const SizedBox(width: 4),
          AppText(label, type: AppTextType.caption, color: color),
        ],
      ),
    );
  }
}


class _FilterBottomSheet extends StatefulWidget {
  final SuspectedCauseProvider provider;

  const _FilterBottomSheet({required this.provider});

  @override
  State<_FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<_FilterBottomSheet> {
  String? _selectedSeverity;
  String? _selectedSite;
  String? _selectedPathogenId;
  
  late Future<List<PathogenSummary>> _pathogenListFuture;

  @override
  void initState() {
    super.initState();
    _selectedSeverity = widget.provider.filterSeverity;
    _selectedSite = widget.provider.filterTreatmentSite;
    _selectedPathogenId = widget.provider.filterPathogenId;

    _pathogenListFuture = widget.provider.fetchPathogensList();
  }

  void _apply() {
    widget.provider.applyFilter(
      severity: _selectedSeverity,
      treatmentSite: _selectedSite,
      pathogenId: _selectedPathogenId,
    );
    Navigator.pop(context);
  }

  void _reset() {
    widget.provider.clearFilters();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final c = context.respiraColors;
    
    return Padding(
      padding: const EdgeInsets.all(Spacing.group),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(width: 40, height: 4, decoration: BoxDecoration(color: c.borderSubtle, borderRadius: BorderRadius.circular(2))),
          ),
          const SizedBox(height: Spacing.section),
          AppText('Bộ lọc dữ liệu', type: AppTextType.h3, fontWeight: FontWeight.bold),
          const SizedBox(height: Spacing.section),

          AppText('Tác nhân (Pathogen)', type: AppTextType.bodyMedium, fontWeight: FontWeight.w600),
          const SizedBox(height: 8),
          FutureBuilder<List<PathogenSummary>>(
            future: _pathogenListFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return AppText('Không tải được danh sách tác nhân', color: c.error);
              }
              
              final pathogens = snapshot.data ?? [];
              
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: c.surface,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String?>(
                    isExpanded: true,
                    value: _selectedPathogenId,
                    hint: AppText('Tất cả tác nhân', color: c.textSecondary),
                    dropdownColor: c.surface,
                    icon: Icon(LucideIcons.chevronDown, color: c.iconDefault),
                    items: [
                      DropdownMenuItem(
                        value: null,
                        child: AppText('Tất cả tác nhân'),
                      ),
                      ...pathogens.map((p) => DropdownMenuItem(
                        value: p.id,
                        child: AppText(p.name),
                      )),
                    ],
                    onChanged: (val) => setState(() => _selectedPathogenId = val),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: Spacing.section),

          AppText('Mức độ nghiêm trọng', type: AppTextType.bodyMedium, fontWeight: FontWeight.w600),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8, runSpacing: 8,
            children: [
              _buildChoiceChip('Tất cả', _selectedSeverity == null, () => setState(() => _selectedSeverity = null)),
              _buildChoiceChip('Nhẹ', _selectedSeverity == 'Mild', () => setState(() => _selectedSeverity = 'Mild')),
              _buildChoiceChip('Trung bình', _selectedSeverity == 'Moderate', () => setState(() => _selectedSeverity = 'Moderate')),
              _buildChoiceChip('Nặng', _selectedSeverity == 'Severe', () => setState(() => _selectedSeverity = 'Severe')),
            ],
          ),
          const SizedBox(height: Spacing.section),

          AppText('Nơi điều trị', type: AppTextType.bodyMedium, fontWeight: FontWeight.w600),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8, runSpacing: 8,
            children: [
              _buildChoiceChip('Tất cả', _selectedSite == null, () => setState(() => _selectedSite = null)),
              _buildChoiceChip('Ngoại trú', _selectedSite == 'Outpatient', () => setState(() => _selectedSite = 'Outpatient')),
              _buildChoiceChip('Nội trú', _selectedSite == 'Inpatient', () => setState(() => _selectedSite = 'Inpatient')),
              _buildChoiceChip('ICU', _selectedSite == 'IntensiveCareUnit', () => setState(() => _selectedSite = 'IntensiveCareUnit')),
            ],
          ),
          const SizedBox(height: Spacing.section),

          Row(
            children: [
              Expanded(
                child: AppButton(
                  label: 'Xóa bộ lọc',
                  onPressed: _reset,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: AppButton(
                  label: 'Áp dụng',
                  onPressed: _apply,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24), 
        ],
      ),
    );
  }

  Widget _buildChoiceChip(String label, bool isSelected, VoidCallback onTap) {
    final c = context.respiraColors;
    return ChoiceChip(
      label: AppText(label, color: isSelected ? Colors.white : c.textPrimary),
      selected: isSelected,
      onSelected: (_) => onTap(),
      selectedColor: c.primary,
      backgroundColor: c.surface,
      showCheckmark: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: isSelected ? c.primary : c.borderSubtle),
      ),
    );
  }
}