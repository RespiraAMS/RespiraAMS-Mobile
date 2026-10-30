import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../design_system/design_system.dart';

class FormulaDisplayWidget extends StatelessWidget {
  final String rawFormula;

  const FormulaDisplayWidget({super.key, required this.rawFormula});

  @override
  Widget build(BuildContext context) {
    if (rawFormula.isEmpty) return const SizedBox.shrink();

    final c = context.respiraColors;

    final tokenRegex = RegExp(
      r'("[^"]*"|\b(?:AND|OR|NOT|If|then|else|true|false)\b|\d+(?:\.\d+)?|[=><≥≤≠\+\-×÷]|[\(\)]|[A-Za-z_][A-Za-z0-9_\-]*|\s+)',
    );

    final matches = tokenRegex.allMatches(rawFormula);
    final List<Widget> children = [];

    for (final match in matches) {
      final token = match.group(0);
      if (token == null || token.trim().isEmpty) continue; 
      
      children.add(_buildTokenWidget(token, context, c));
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(Spacing.group),
      decoration: BoxDecoration(
        color: c.surfaceSecondary, 
        borderRadius: AppRadius.md, 
        border: Border.all(color: c.borderSubtle), 
      ),
      child: Wrap(
        spacing: 6,
        runSpacing: Spacing.inline, // 8px
        crossAxisAlignment: WrapCrossAlignment.center,
        children: children,
      ),
    );
  }

  Widget _buildTokenWidget(String token, BuildContext context, RespiraColors c) {
    if (token.startsWith('"') && token.endsWith('"')) {
      return _buildChip(token, c.warningSoft, c.warning);
    }
    
    if (['AND', 'OR', 'If', 'then', 'else'].contains(token)) {
      return SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 12, height: 16,
                  margin: const EdgeInsets.only(right: Spacing.inline, bottom: 6),
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(color: c.borderStrong, width: 2),
                      bottom: BorderSide(color: c.borderStrong, width: 2),
                    ),
                  ),
                ),
                _buildChip(token, c.infoSoft, c.info, isBold: true),
              ],
            ),
          ),
        ),
      );
    }
    
    if (token == 'NOT') {
      return _buildChip(token, c.infoSoft, c.info, isBold: true);
    }
    
    if (token == 'true' || token == 'false' || num.tryParse(token) != null) {
      return _buildChip(token, c.errorSoft, c.error, isBold: true);
    }
    
    if (RegExp(r'^[=><≥≤≠\+\-×÷]$').hasMatch(token)) {
      return Text(
        token, 
        style: TextStyle(color: c.error, fontWeight: FontWeight.bold, fontSize: 16),
      );
    }
    
    if (token == '(' || token == ')') {
      return Text(
        token, 
        style: TextStyle(color: c.textTertiary, fontWeight: FontWeight.w300, fontSize: 18),
      );
    }
    
    if (RegExp(r'^[A-Za-z_][A-Za-z0-9_\-]*$').hasMatch(token)) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: c.successSoft,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: c.success.withValues(alpha: 0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppIcon(LucideIcons.clipboardList, size: ControlSize.iconSm, color: c.success),
            const SizedBox(width: 4),
            Text(
              token, 
              style: TextStyle(color: c.success, fontWeight: FontWeight.w600, fontSize: 13),
            ),
          ],
        ),
      );
    }

    return AppText(token, type: AppTextType.bodyMedium);
  }

  Widget _buildChip(String text, Color bg, Color textColor, {bool isBold = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(6)),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontWeight: isBold ? FontWeight.w700 : FontWeight.w600,
          fontSize: 13,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}