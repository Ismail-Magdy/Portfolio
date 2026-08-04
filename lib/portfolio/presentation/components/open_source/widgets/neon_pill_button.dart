import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NeonPillButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final bool isPrimary;
  final VoidCallback onTap;

  const NeonPillButton({
    super.key,
    required this.icon,
    required this.label,
    required this.isPrimary,
    required this.onTap,
  });

  @override
  State<NeonPillButton> createState() => NeonPillButtonState();
}

class NeonPillButtonState extends State<NeonPillButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final Color accentColor = widget.isPrimary
        ? Colors.cyanAccent
        : const Color(0xFF818CF8);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          padding: const .symmetric(horizontal: 18, vertical: 10),
          transform: Matrix4.identity()
            ..scale(_isHovered ? 1.05 : 1.0, _isHovered ? 1.05 : 1.0),
          transformAlignment: .center,
          decoration: BoxDecoration(
            borderRadius: .circular(100),
            color: _isHovered
                ? accentColor.withValues(alpha: 0.12)
                : Colors.white.withValues(alpha: 0.03),
            border: .all(
              color: _isHovered
                  ? accentColor.withValues(alpha: 0.6)
                  : accentColor.withValues(alpha: 0.2),
              width: 1,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: accentColor.withValues(alpha: 0.25),
                      blurRadius: 16,
                      spreadRadius: -4,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : [],
          ),
          child: Row(
            mainAxisSize: .min,
            children: [
              Icon(
                widget.icon,
                size: 14,
                color: _isHovered
                    ? accentColor
                    : accentColor.withValues(alpha: 0.7),
              ),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: GoogleFonts.inter(
                  fontSize: 12.5,
                  fontWeight: .w600,
                  color: _isHovered
                      ? accentColor
                      : accentColor.withValues(alpha: 0.7),
                  letterSpacing: 0.3,
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