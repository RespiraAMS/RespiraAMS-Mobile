import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../design_system/design_system.dart';
import '../../../core/network/api_client.dart';
import '../providers/pathogen_provider.dart';
import '../providers/pathogen_service.dart';
import 'pathogen_detail_screen.dart';

class PathogenListScreen extends StatefulWidget {
  const PathogenListScreen({super.key});

  @override
  State<PathogenListScreen> createState() => _PathogenListScreenState();
}

class _PathogenListScreenState extends State<PathogenListScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PathogenProvider>().fetchPage();
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
      context.read<PathogenProvider>().fetchPage();
    }
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (mounted) {
        context.read<PathogenProvider>().search(query);
      }
    });
  }

  void _showFilterBottomSheet() {
    FocusScope.of(context).unfocus();
    
    final provider = context.read<PathogenProvider>();
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
                title: 'Tác nhân gây bệnh',
                subtitle: 'Mô tả và độ nhạy',
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
                        hintText: 'Tìm kiếm tác nhân...',
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
                  // NÚT BỘ LỌC (FILTER)
                  Consumer<PathogenProvider>(
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
              child: Consumer<PathogenProvider>(
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
                                    child: AppText('Không thể tải thêm. Nhấn để thử lại', type: AppTextType.caption, color: c.error),
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
                                  final repository = PathogenRepository(apiClient: apiClient);
                                  return PathogenProvider(repository);
                                },
                                child: PathogenDetailScreen(pathogen: item),
                              ),
                            ),
                          )
                        },
                        child: AppSurface(
                          padding: const EdgeInsets.symmetric(horizontal: Spacing.group, vertical: Spacing.control),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: AppText(item.name, type: AppTextType.bodyMedium, fontWeight: FontWeight.w600),
                                  ),
                                  if (item.isAtypical) ...[
                                    const SizedBox(width: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: c.warningSoft,
                                        borderRadius: AppRadius.full,
                                      ),
                                      child: AppText('Không điển hình', type: AppTextType.label, color: c.warning),
                                    ),
                                  ],
                                ],
                              ),
                              const SizedBox(height: 4),
                              AppText(
                                item.description, 
                                type: AppTextType.caption, 
                                maxLines: 2, 
                                overflow: TextOverflow.ellipsis,
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
  final PathogenProvider provider;

  const _FilterBottomSheet({required this.provider});

  @override
  State<_FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<_FilterBottomSheet> {
  bool? _selectedIsAtypical;

  @override
  void initState() {
    super.initState();
    _selectedIsAtypical = widget.provider.filterIsAtypical;
  }

  void _apply() {
    widget.provider.applyFilter(isAtypical: _selectedIsAtypical);
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
          AppText('Bộ lọc tác nhân', type: AppTextType.h3, fontWeight: FontWeight.bold),
          const SizedBox(height: Spacing.section),

          AppText('Phân loại tác nhân', type: AppTextType.bodyMedium, fontWeight: FontWeight.w600),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              _buildChoiceChip('Tất cả', _selectedIsAtypical == null, () => setState(() => _selectedIsAtypical = null)),
              _buildChoiceChip('Vi khuẩn điển hình', _selectedIsAtypical == false, () => setState(() => _selectedIsAtypical = false)),
              _buildChoiceChip('Không điển hình', _selectedIsAtypical == true, () => setState(() => _selectedIsAtypical = true)),
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