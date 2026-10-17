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
            
            // Thanh Tìm kiếm
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Spacing.group),
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
            const SizedBox(height: Spacing.control),

            Expanded(
              child: Consumer<ClinicalMetricProvider>(
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
                                value: provider, // Dùng lại provider hiện tại để gọi hàm fetch detail
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