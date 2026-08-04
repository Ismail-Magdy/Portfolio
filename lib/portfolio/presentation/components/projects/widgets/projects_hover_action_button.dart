import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ismailmagdy/core/theme/app_colors.dart';

/// Extracted stateful hover button for clean hover state management.
class HoverActionButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final String url;
  final bool isPrimary;
  final List<Color>? gradientColors;
  final VoidCallback onTap;

  const HoverActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.url,
    required this.isPrimary,
    this.gradientColors,
    required this.onTap,
  });

  @override
  State<HoverActionButton> createState() => HoverActionButtonState();
}

class HoverActionButtonState extends State<HoverActionButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final hasGradient =
        widget.gradientColors != null && widget.gradientColors!.length >= 2;
    final baseColor = hasGradient
        ? widget.gradientColors!.first
        : AppColors.primary;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          padding: const .symmetric(horizontal: 20, vertical: 12),
          transform: Matrix4.identity()
            ..scale(_isHovered ? 1.05 : 1.0, _isHovered ? 1.05 : 1.0),
          transformAlignment: .center,
          decoration: BoxDecoration(
            color: _isHovered
                ? (widget.isPrimary
                      ? baseColor.withValues(alpha: 0.15)
                      : AppColors.textDark.withValues(alpha: 0.1))
                : Colors.transparent,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: _isHovered
                  ? (widget.isPrimary
                        ? baseColor.withValues(alpha: 0.6)
                        : AppColors.textDark.withValues(alpha: 0.5))
                  : (widget.isPrimary
                        ? AppColors.primary.withValues(alpha: 0.35)
                        : AppColors.textDark.withValues(alpha: 0.3)),
              width: 1.5,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: baseColor.withValues(alpha: 0.2),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          child: Row(
            mainAxisSize: .min,
            children: [
              FaIcon(
                widget.icon,
                size: 16,
                color: widget.isPrimary
                    ? AppColors.primary
                    : AppColors.textDark,
              ),
              const SizedBox(width: 10),
              Text(
                widget.label,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: .w600,
                  color: widget.isPrimary
                      ? AppColors.primary
                      : AppColors.textDark,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//