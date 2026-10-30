import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../design_system/design_system.dart';
import '../../../core/network/api_client.dart';
import '../providers/risk_factor_provider.dart';
import '../../suspected_causes/models/pathogen_summary.dart';
import '../providers/risk_factor_service.dart';
import 'risk_factor_detail_screen.dart';

class RiskFactorListScreen extends StatefulWidget {
  const RiskFactorListScreen({super.key});

  @override
  State<RiskFactorListScreen> createState() => _RiskFactorListScreenState();
}

class _RiskFactorListScreenState extends State<RiskFactorListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RiskFactorProvider>().fetchPage();
    });
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      context.read<RiskFactorProvider>().fetchPage();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _showFilterBottomSheet() {
    final provider = context.read<RiskFactorProvider>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: context.respiraColors.background,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) => _FilterBottomSheet(provider: provider),
    );
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
                title: 'Yếu tố nguy cơ',
                subtitle: 'Theo tác nhân gây bệnh',
                onBack: () => Navigator.pop(context),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Spacing.group),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText('Danh sách yếu tố', type: AppTextType.bodyMedium, fontWeight: FontWeight.w700),
                  Consumer<RiskFactorProvider>(
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
              child: Consumer<RiskFactorProvider>(
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
                          Icon(LucideIcons.folderSearch, size: 48, color: c.textSecondary.withValues(alpha: 0.5)),
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
                    separatorBuilder: (_, _) => const SizedBox(height: Spacing.control),
                    itemBuilder: (context, index) {
                      if (index == provider.items.length) {
                        return Padding(
                          padding: const EdgeInsets.all(Spacing.group),
                          child: Center(
                            child: provider.errorMessage != null
                                ? GestureDetector(
                                    onTap: () => provider.fetchPage(),
                                    child: AppText('Không thể tải thêm. Nhấn thử lại', type: AppTextType.caption, color: c.error),
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
                              builder: (_) => ChangeNotifierProvider(
                                create: (_) {
                                  final apiClient = ApiClient(); 
                                  final repo = RiskFactorRepository(apiClient: apiClient);
                                  return RiskFactorProvider(repo);
                                },
                                child: RiskFactorDetailScreen(riskFactorId: item.id),
                              ),
                            ),
                          );
                        },
                        child: AppSurface(
                          padding: const EdgeInsets.symmetric(horizontal: Spacing.group, vertical: Spacing.control),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(item.criterion.name, type: AppTextType.bodyMedium, fontWeight: FontWeight.w600),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  Icon(LucideIcons.bug, size: 14, color: c.textSecondary),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: AppText(item.pathogen.name, type: AppTextType.caption, color: c.textSecondary),
                                  ),
                                ],
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
  final RiskFactorProvider provider;

  const _FilterBottomSheet({required this.provider});

  @override
  State<_FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<_FilterBottomSheet> {
  String? _selectedPathogenId;
  late Future<List<PathogenSummary>> _pathogenListFuture;

  @override
  void initState() {
    super.initState();
    _selectedPathogenId = widget.provider.filterPathogenId;
    _pathogenListFuture = widget.provider.fetchPathogensList();
  }

  void _apply() {
    widget.provider.applyFilter(pathogenId: _selectedPathogenId);
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

          AppText('Tác nhân', type: AppTextType.bodyMedium, fontWeight: FontWeight.w600),
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