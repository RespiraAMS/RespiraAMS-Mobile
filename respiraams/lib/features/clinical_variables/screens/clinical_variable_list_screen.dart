import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../design_system/design_system.dart';
import '../providers/clinical_variable_provider.dart';
import '../models/clinical_variable.dart';

class ClinicalVariableListScreen extends StatefulWidget {
  const ClinicalVariableListScreen({super.key});

  @override
  State<ClinicalVariableListScreen> createState() => _ClinicalVariableListScreenState();
}

class _ClinicalVariableListScreenState extends State<ClinicalVariableListScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ClinicalVariableProvider>().fetchPage();
    });
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      context.read<ClinicalVariableProvider>().fetchPage();
    }
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (mounted) {
        context.read<ClinicalVariableProvider>().search(query);
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
    final provider = context.read<ClinicalVariableProvider>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: context.respiraColors.background,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) => _FilterBottomSheet(provider: provider),
    );
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
      case VariableCategory.personalInformation: return 'Cá nhân';
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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Spacing.group, vertical: 8),
              child: AppAppBar(
                title: 'Biến số lâm sàng',
                subtitle: 'Quản lý tham số',
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
                        hintText: 'Tìm kiếm tên hoặc mã...',
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
                  Consumer<ClinicalVariableProvider>(
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
              child: Consumer<ClinicalVariableProvider>(
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
                          child: Center(child: CircularProgressIndicator(color: c.primary)),
                        );
                      }

                      final item = provider.items[index];
                      return AppSurface(
                        padding: const EdgeInsets.symmetric(horizontal: Spacing.group, vertical: Spacing.control),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(child: AppText(item.name, type: AppTextType.bodyMedium, fontWeight: FontWeight.w600)),
                                if (item.isRequired)
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(color: c.errorSoft, borderRadius: BorderRadius.circular(4)),
                                    child: AppText('Bắt buộc', type: AppTextType.caption, color: c.error),
                                  )
                              ],
                            ),
                            const SizedBox(height: 4),
                            AppText(item.code, type: AppTextType.caption, color: c.textSecondary),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                _buildTag(c, LucideIcons.layers, _translateCategory(item.category)),
                                const SizedBox(width: 8),
                                _buildTag(c, LucideIcons.type, _translateValueType(item.valueType)),
                                if (item.canonicalUnit != null) ...[
                                  const SizedBox(width: 8),
                                  _buildTag(c, LucideIcons.ruler, item.canonicalUnit!),
                                ]
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

  Widget _buildTag(dynamic c, IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: c.background, borderRadius: AppRadius.full),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: c.textSecondary),
          const SizedBox(width: 4),
          AppText(label, type: AppTextType.caption),
        ],
      ),
    );
  }
}

class _FilterBottomSheet extends StatefulWidget {
  final ClinicalVariableProvider provider;

  const _FilterBottomSheet({required this.provider});

  @override
  State<_FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<_FilterBottomSheet> {
  bool? _selectedIsRequired;
  String? _selectedValueType;
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    // Khôi phục trạng thái bộ lọc cũ từ Provider khi mở lại BottomSheet
    _selectedIsRequired = widget.provider.filterIsRequired;
    _selectedValueType = widget.provider.filterValueType;
    _selectedCategory = widget.provider.filterCategory;
  }

  void _apply() {
    widget.provider.applyFilter(
      isRequired: _selectedIsRequired,
      valueType: _selectedValueType,
      category: _selectedCategory,
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

          AppText('Tính bắt buộc', type: AppTextType.bodyMedium, fontWeight: FontWeight.w600),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              _buildChoiceChip('Tất cả', _selectedIsRequired == null, () => setState(() => _selectedIsRequired = null)),
              _buildChoiceChip('Bắt buộc', _selectedIsRequired == true, () => setState(() => _selectedIsRequired = true)),
              _buildChoiceChip('Không bắt buộc', _selectedIsRequired == false, () => setState(() => _selectedIsRequired = false)),
            ],
          ),
          const SizedBox(height: Spacing.section),

          AppText('Phân loại', type: AppTextType.bodyMedium, fontWeight: FontWeight.w600),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildChoiceChip('Tất cả', _selectedCategory == null, () => setState(() => _selectedCategory = null)),
              _buildChoiceChip('Lâm sàng', _selectedCategory == 'Clinical', () => setState(() => _selectedCategory = 'Clinical')),
              _buildChoiceChip('Cận lâm sàng', _selectedCategory == 'Paraclinical', () => setState(() => _selectedCategory = 'Paraclinical')),
              _buildChoiceChip('Cá nhân', _selectedCategory == 'PersonalInformation', () => setState(() => _selectedCategory = 'PersonalInformation')),
            ],
          ),
          const SizedBox(height: Spacing.section),

          AppText('Loại giá trị', type: AppTextType.bodyMedium, fontWeight: FontWeight.w600),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildChoiceChip('Tất cả', _selectedValueType == null, () => setState(() => _selectedValueType = null)),
              _buildChoiceChip('Nhập số', _selectedValueType == 'Numeric', () => setState(() => _selectedValueType = 'Numeric')),
              _buildChoiceChip('Có/Không', _selectedValueType == 'Boolean', () => setState(() => _selectedValueType = 'Boolean')),
              _buildChoiceChip('Phân loại', _selectedValueType == 'Categorical', () => setState(() => _selectedValueType = 'Categorical')),
            ],
          ),
          const SizedBox(height: Spacing.section),

          // Nút bấm
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