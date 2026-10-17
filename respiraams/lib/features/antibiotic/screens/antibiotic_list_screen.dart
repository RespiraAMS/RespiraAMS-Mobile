import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import '../../../../design_system/design_system.dart';
import '../providers/antibiotic_provider.dart';
import '../models/antibiotic_group_summary.dart';
import 'antibiotic_detail_screen.dart';

class AntibioticListScreen extends StatefulWidget {
  const AntibioticListScreen({super.key});

  @override
  State<AntibioticListScreen> createState() => _AntibioticListScreenState();
}

class _AntibioticListScreenState extends State<AntibioticListScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<AntibioticProvider>();
      if (provider.items.isEmpty) {
        provider.fetchPage();
      }
    });

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      context.read<AntibioticProvider>().fetchPage();
    }
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (mounted) {
        context.read<AntibioticProvider>().search(query);
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
    
    final provider = context.read<AntibioticProvider>();
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
                title: 'Kháng sinh',
                subtitle: 'Danh mục hoạt chất',
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
                        hintText: 'Tìm kiếm kháng sinh...',
                        hintStyle: TextStyle(color: c.textSecondary),
                        prefixIcon: Icon(LucideIcons.search, color: c.iconDefault, size: 20),
                        filled: true,
                        fillColor: c.surface,
                        contentPadding: const EdgeInsets.symmetric(vertical: 0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      style: TextStyle(color: c.textPrimary),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Consumer<AntibioticProvider>(
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
              child: Consumer<AntibioticProvider>(
                builder: (context, provider, child) {
                  if (provider.errorMessage != null && provider.items.isNotEmpty) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      showAppToast(context, provider.errorMessage!);
                      provider.clearError();
                    });
                  }

                  if (provider.isLoading && provider.items.isEmpty) {
                    return Center(child: CircularProgressIndicator(color: c.primary));
                  }

                  if (provider.errorMessage != null && provider.items.isEmpty) {
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

                  if (provider.items.isEmpty) {
                    return Center(
                      child: AppText('Không tìm thấy kháng sinh nào', color: c.textSecondary),
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
                          padding: const EdgeInsets.symmetric(vertical: Spacing.control),
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
                      final Color tagBg = item.classification == 'Access' ? c.successSoft 
                                        : item.classification == 'Watch' ? c.warningSoft 
                                        : item.classification == 'Reserve' ? c.errorSoft
                                        : c.surfaceSecondary;
                      final Color tagText = item.classification == 'Access' ? c.success 
                                        : item.classification == 'Watch' ? c.warning 
                                        : item.classification == 'Reserve' ? c.error
                                        : c.textSecondary;

                      return GestureDetector(
                        onTap: () =>
                          Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ChangeNotifierProvider.value(
                              value: provider,
                              child: AntibioticDetailScreen(antibiotic: item),
                            ),
                          ),
                        ),
                        child: AppSurface(
                          padding: const EdgeInsets.symmetric(horizontal: Spacing.group, vertical: Spacing.control),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppText(item.name, type: AppTextType.bodyMedium, fontWeight: FontWeight.w600),
                                    const SizedBox(height: 4),
                                    AppText(item.groupName, type: AppTextType.caption),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(color: tagBg, borderRadius: AppRadius.full),
                                child: AppText(item.classification, type: AppTextType.label, color: tagText),
                              ),
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
  final AntibioticProvider provider;

  const _FilterBottomSheet({required this.provider});

  @override
  State<_FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<_FilterBottomSheet> {
  String? _selectedGroupId;
  String? _selectedClassification;
  late Future<List<AntibioticGroupSummary>> _groupsFuture;

  // Map enum Backend thành chuỗi UI
  final Map<String, String> _classifications = {
    'Access': 'Access',
    'AccessWatch': 'Access/Watch',
    'Watch': 'Watch',
    'Reserve': 'Reserve',
    'Unclassified': 'Chưa phân loại',
    'Others': 'Khác',
  };

  @override
  void initState() {
    super.initState();
    _selectedGroupId = widget.provider.filterGroupId;
    _selectedClassification = widget.provider.filterClassification;
    _groupsFuture = widget.provider.fetchAntibioticGroupsList();
  }

  void _apply() {
    widget.provider.applyFilter(
      groupId: _selectedGroupId,
      classification: _selectedClassification,
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
          AppText('Bộ lọc kháng sinh', type: AppTextType.h3, fontWeight: FontWeight.bold),
          const SizedBox(height: Spacing.section),

          AppText('Nhóm kháng sinh', type: AppTextType.bodyMedium, fontWeight: FontWeight.w600),
          const SizedBox(height: 8),
          FutureBuilder<List<AntibioticGroupSummary>>(
            future: _groupsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return AppText('Không tải được nhóm', color: c.error);
              }
              
              final groups = snapshot.data ?? [];
              
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(color: c.surface, borderRadius: BorderRadius.circular(12)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String?>(
                    isExpanded: true,
                    value: _selectedGroupId,
                    hint: AppText('Tất cả nhóm', color: c.textSecondary),
                    dropdownColor: c.surface,
                    icon: Icon(LucideIcons.chevronDown, color: c.iconDefault),
                    items: [
                      DropdownMenuItem(value: null, child: AppText('Tất cả nhóm')),
                      ...groups.map((g) => DropdownMenuItem(value: g.id, child: AppText(g.name))),
                    ],
                    onChanged: (val) => setState(() => _selectedGroupId = val),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: Spacing.section),

          AppText('Phân loại AWaRe', type: AppTextType.bodyMedium, fontWeight: FontWeight.w600),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8, runSpacing: 8,
            children: [
              _buildChoiceChip('Tất cả', _selectedClassification == null, () => setState(() => _selectedClassification = null)),
              ..._classifications.entries.map((entry) => _buildChoiceChip(
                entry.value, 
                _selectedClassification == entry.key, 
                () => setState(() => _selectedClassification = entry.key),
              )),
            ],
          ),
          const SizedBox(height: Spacing.section),

          // NÚT BẤM
          Row(
            children: [
              Expanded(child: AppButton(label: 'Xóa bộ lọc', onPressed: _reset)),
              const SizedBox(width: 16),
              Expanded(child: AppButton(label: 'Áp dụng', onPressed: _apply)),
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