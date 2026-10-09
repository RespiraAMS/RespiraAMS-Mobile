import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../design_system/design_system.dart';
import '../models/pathogen.dart';

class PathogenDetailScreen extends StatefulWidget {
  final Pathogen pathogen;

  const PathogenDetailScreen({super.key, required this.pathogen});

  @override
  State<PathogenDetailScreen> createState() => _PathogenDetailScreenState();
}

class _PathogenDetailScreenState extends State<PathogenDetailScreen> {


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
                title: widget.pathogen.name,
                subtitle: 'Tác nhân gây bệnh',
                onBack: () => Navigator.pop(context),
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(Spacing.group, 8, Spacing.group, Spacing.screen),
                children: [
                  // 1. Hero Card
                  Container(
                    padding: const EdgeInsets.all(Spacing.block),
                    decoration: BoxDecoration(
                      color: c.primarySoft,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 52, height: 52,
                          decoration: BoxDecoration(color: c.surface, shape: BoxShape.circle),
                          child: Icon(LucideIcons.bug, color: c.iconPrimary, size: 24),
                        ),
                        const SizedBox(width: Spacing.control),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(widget.pathogen.name, type: AppTextType.h3, fontWeight: FontWeight.w700),
                              const SizedBox(height: 4),
                              AppText('Tác nhân gây bệnh', type: AppTextType.caption),
                              if (widget.pathogen.isAtypical) ...[
                                    const SizedBox(width: 12),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: c.warningSoft,
                                        borderRadius: AppRadius.full,
                                      ),
                                      child: AppText('Không điển hình', type: AppTextType.label, color: c.warning),
                                    ),
                                  ]
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: Spacing.section),

                  AppText('Mô tả', type: AppTextType.button, fontWeight: FontWeight.w700),
                  const SizedBox(height: Spacing.control),
                  AppText(
                    widget.pathogen.description,
                    type: AppTextType.body,
                    color: c.textPrimary,
                  ),
                  const SizedBox(height: Spacing.section),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}