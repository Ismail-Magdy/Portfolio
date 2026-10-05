import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ismailmagdy/core/theme/app_colors.dart';

class PackageActionButton extends StatefulWidget {
  final FaIconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isPrimary;
  final bool isBlueprint;

  const PackageActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    required this.isPrimary,
    required this.isBlueprint,
  });

  @override
  State<PackageActionButton> createState() => PackageActionButtonState();
}

class PackageActionButtonState extends State<PackageActionButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const .symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: _isHovered && widget.isPrimary
                ? AppColors.primary.withValues(alpha: 0.08)
                : Colors.transparent,
            borderRadius: .circular(8),
            border: .all(
              color: _isHovered
                  ? (widget.isPrimary
                        ? AppColors.primary.withValues(alpha: 0.4)
                        : Colors.white.withValues(alpha: 0.2))
                  : (widget.isPrimary
                        ? AppColors.primary.withValues(alpha: 0.2)
                        : Colors.white.withValues(alpha: 0.08)),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: .min,
            children: [
              FaIcon(
                widget.icon,
                size: 13,
                color: widget.isPrimary
                    ? AppColors.primary
                    : Colors.white.withValues(alpha: 0.5),
              ),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: .w600,
                  color: widget.isPrimary
                      ? AppColors.primary
                      : Colors.white.withValues(alpha: 0.5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
