import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../design_system/design_system.dart';
import '../providers/clinical_metric_provider.dart';
import 'clinical_metric_detail_screen.dart';

class ClinicalMetricListScreen extends StatefulWidget {
  const ClinicalMetricListScreen({super.key});

  @override
  State<ClinicalMetricListScreen> createState() => _ClinicalMetricListScreenState();
}

class _ClinicalMetricListScreenState extends State<ClinicalMetricListScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ClinicalMetricProvider>().fetchPage();
    });
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      context.read<ClinicalMetricProvider>().fetchPage();
    }
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (mounted) {
        context.read<ClinicalMetricProvider>().search(query);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _showFilterBottomSheet() {
    FocusScope.of(context).unfocus();
    
    final provider = context.read<ClinicalMetricProvider>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: context.respiraColors.background,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) => _FilterBottomSheet(provider: provider),
    ).then((_) {
      if (provider.hasActiveFilters) {
        _searchController.clear();
      }
    });
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
                title: 'Thang điểm lâm sàng',
                subtitle: 'Các bộ tiêu chí & Đánh giá',
                onBack: () => Navigator.pop(context),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Spacing.group),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      onChanged: _onSearchChanged,
                      decoration: InputDecoration(
                        hintText: 'Tìm kiếm tên thang điểm...',
                        hintStyle: TextStyle(color: c.textSecondary),
                        prefixIcon: Icon(LucideIcons.search, color: c.iconDefault, size: 20),
                        filled: true,
                        fillColor: c.surface,
                        contentPadding: const EdgeInsets.symmetric(vertical: 0),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                      ),
                      style: TextStyle(color: c.textPrimary),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // NÚT LỌC (FILTER)
                  Consumer<ClinicalMetricProvider>(
                    builder: (context, provider, child) {
                      final hasFilter = provider.hasActiveFilters;
                      return GestureDetector(
                        onTap: _showFilterBottomSheet,
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: hasFilter ? c.primary : c.surface,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            LucideIcons.listFilter, 
                            color: hasFilter ? Colors.white : c.iconPrimary, 
                            size: 24,
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
              child: Consumer<ClinicalMetricProvider>(
                builder: (context, provider, child) {
                  // Xử lý báo lỗi
                  if (provider.errorMessage != null && provider.items.isNotEmpty) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      showAppToast(context, provider.errorMessage!);
                      provider.clearError();
                    });
                  }

                  if (provider.items.isEmpty && provider.isLoading) {
                    return Center(child: CircularProgressIndicator(color: c.primary));
                  }
                  
                  if (provider.items.isEmpty && provider.errorMessage != null) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppText(provider.errorMessage!, color: c.error),
                          const SizedBox(height: 12),
                          GestureDetector(
                            onTap: () => provider.fetchPage(),
                            child: AppSurface(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              child: AppText('Thử lại', color: c.primary),
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  if (provider.items.isEmpty && !provider.isLoading) {
                    return Center(child: AppText('Không tìm thấy kết quả nào.', color: c.textSecondary));
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
                          child: Center(
                            child: provider.errorMessage != null
                                ? GestureDetector(
                                    onTap: () => provider.fetchPage(),
                                    child: AppText('Không thể tải thêm. Nhấn để thử lại', type: AppTextType.caption, color: c.error),
                                  )
                                : CircularProgressIndicator(color: c.primary),
                          ),
                        );
                      }

                      final item = provider.items[index];
                      
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ChangeNotifierProvider.value(
                                value: provider, 
                                child: ClinicalMetricDetailScreen(metricId: item.id),
                              ),
                            ),
                          );
                        },
                        child: AppSurface(
                          padding: const EdgeInsets.symmetric(horizontal: Spacing.group, vertical: Spacing.group),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: AppText(
                                      item.name, 
                                      type: AppTextType.bodyMedium, 
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  if (item.isApplied)
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(color: c.successSoft, borderRadius: BorderRadius.circular(4)),
                                      child: AppText('Đang áp dụng', type: AppTextType.caption, color: c.success),
                                    )
                                ],
                              ),
                              const SizedBox(height: 4),
                              AppText(item.code, type: AppTextType.caption, color: c.primary),
                              const SizedBox(height: 8),
                              AppText(item.description, type: AppTextType.caption, maxLines: 2, overflow: TextOverflow.ellipsis),
                            ],
                          ),
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
}

class _FilterBottomSheet extends StatefulWidget {
  final ClinicalMetricProvider provider;

  const _FilterBottomSheet({required this.provider});

  @override
  State<_FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<_FilterBottomSheet> {
  bool? _selectedIsApplied;

  @override
  void initState() {
    super.initState();
    _selectedIsApplied = widget.provider.filterIsApplied;
  }

  void _apply() {
    widget.provider.applyFilter(isApplied: _selectedIsApplied);
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

          AppText('Trạng thái áp dụng', type: AppTextType.bodyMedium, fontWeight: FontWeight.w600),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              _buildChoiceChip('Tất cả', _selectedIsApplied == null, () => setState(() => _selectedIsApplied = null)),
              _buildChoiceChip('Đang áp dụng', _selectedIsApplied == true, () => setState(() => _selectedIsApplied = true)),
              _buildChoiceChip('Ngưng áp dụng', _selectedIsApplied == false, () => setState(() => _selectedIsApplied = false)),
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