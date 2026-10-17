import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../design_system/design_system.dart';
import '../../../core/network/api_client.dart';
import '../providers/antibiotic_group_provider.dart';
import '../providers/antibiotic_group_service.dart';
import '../models/antibiotic_group_summary.dart';
import 'antibiotic_group_detail_screen.dart';

class AntibioticGroupListScreen extends StatefulWidget {
  const AntibioticGroupListScreen({super.key});

  @override
  State<AntibioticGroupListScreen> createState() => _AntibioticGroupListScreenState();
}

class _AntibioticGroupListScreenState extends State<AntibioticGroupListScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AntibioticGroupProvider>().fetchPage();
    });

    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      context.read<AntibioticGroupProvider>().fetchPage();
    }
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (mounted) {
        context.read<AntibioticGroupProvider>().search(query);
      }
    });
  }

  void _showFilterBottomSheet() {
    FocusScope.of(context).unfocus();
    
    final provider = context.read<AntibioticGroupProvider>();
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
                title: 'Nhóm kháng sinh',
                subtitle: 'Phân loại và mô tả',
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
                        hintText: 'Tìm kiếm nhóm...',
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
                  // NÚT FILTER
                  Consumer<AntibioticGroupProvider>(
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
              child: Consumer<AntibioticGroupProvider>(
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
                    return Center(
                      child: AppText('Không tìm thấy kết quả nào.', color: c.textSecondary),
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
                          child: Center(
                            child: provider.errorMessage != null
                                ? GestureDetector(
                                    onTap: () => provider.fetchPage(),
                                    child: AppText(
                                      'Không thể tải thêm. Nhấn để thử lại',
                                      type: AppTextType.caption,
                                      color: c.error,
                                    ),
                                  )
                                : CircularProgressIndicator(color: c.primary),
                          ),
                        );
                      }

                      final item = provider.items[index];
                      return GestureDetector(
                        onTap: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ChangeNotifierProvider(
                                create: (_) {
                                  final apiClient = ApiClient(); 
                                  final repository = AntibioticGroupRepository(apiClient: apiClient);
                                  return AntibioticGroupProvider(repository);
                                },
                                child: AntibioticGroupDetailScreen(group: item),
                              ),
                            ),
                          )
                        },
                        child: AppSurface(
                          padding: const EdgeInsets.symmetric(
                            horizontal: Spacing.group,
                            vertical: Spacing.control,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(
                                item.name,
                                type: AppTextType.bodyMedium,
                                fontWeight: FontWeight.w600,
                              ),
                              if (item.parentName != null) ...[
                                const SizedBox(height: 4),
                                AppText(item.parentName!, type: AppTextType.caption),
                              ],
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
  final AntibioticGroupProvider provider;

  const _FilterBottomSheet({required this.provider});

  @override
  State<_FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<_FilterBottomSheet> {
  String? _selectedParentId;
  late Future<List<AntibioticGroupSummary>> _groupsFuture;

  @override
  void initState() {
    super.initState();
    _selectedParentId = widget.provider.filterParentId;
    _groupsFuture = widget.provider.fetchGroupList();
  }

  void _apply() {
    widget.provider.applyFilter(parentId: _selectedParentId);
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

          AppText('Nhóm kháng sinh cha (Parent)', type: AppTextType.bodyMedium, fontWeight: FontWeight.w600),
          const SizedBox(height: 8),
          FutureBuilder<List<AntibioticGroupSummary>>(
            future: _groupsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return AppText('Không tải được danh sách nhóm', color: c.error);
              }
              
              final groups = snapshot.data ?? [];
              
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: c.surface,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String?>(
                    isExpanded: true,
                    value: _selectedParentId,
                    hint: AppText('Tất cả', color: c.textSecondary),
                    dropdownColor: c.surface,
                    icon: Icon(LucideIcons.chevronDown, color: c.iconDefault),
                    items: [
                      DropdownMenuItem(
                        value: null,
                        child: AppText('Tất cả'),
                      ),
                      ...groups.map((p) => DropdownMenuItem(
                        value: p.id,
                        child: AppText(p.name),
                      )),
                    ],
                    onChanged: (val) => setState(() => _selectedParentId = val),
                  ),
                ),
              );
            },
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
}