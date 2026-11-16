import 'package:flutter/material.dart';

import '../theme/theme_extensions.dart';

/// Flat circular avatar: a photo when [imageUrl] is set, otherwise a centered
/// glyph (emoji or initials).
///
/// The photo degrades to the glyph while loading and when the request fails,
/// so the layout never collapses and the screen stays usable offline.
class AvatarGlyphWidget extends StatelessWidget {
  const AvatarGlyphWidget({
    super.key,
    required this.glyph,
    this.size = 48,
    this.backgroundColor,
    this.borderColor,
    this.imageUrl,
  });

  final String glyph;
  final double size;
  final Color? backgroundColor;
  final Color? borderColor;

  /// Absolute URL of the avatar image (e.g. the doctor's `avatarUrl`).
  /// Empty/blank values fall back to [glyph].
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    final c = context.respiraColors;
    final url = (imageUrl ?? '').trim();

    return Container(
      width: size,
      height: size,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: backgroundColor ?? c.primarySoft,
        shape: BoxShape.circle,
        border: Border.all(color: borderColor ?? c.borderDefault),
      ),
      child: url.isEmpty
          ? _buildGlyph()
          : Image.network(
              url,
              width: size,
              height: size,
              fit: BoxFit.cover,
              gaplessPlayback: true,
              errorBuilder: (_, _, _) => _buildGlyph(),
              loadingBuilder: (context, child, progress) =>
                  progress == null ? child : _buildGlyph(),
            ),
    );
  }

  Widget _buildGlyph() {
    return Center(
      child: Text(glyph, style: TextStyle(fontSize: size * 0.58, height: 1)),
    );
  }
}
