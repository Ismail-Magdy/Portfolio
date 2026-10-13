import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ismailmagdy/core/helpers/spacing.dart';
import 'package:ismailmagdy/core/theme/app_colors.dart';

class GalleryBackButton extends StatefulWidget {
  const GalleryBackButton({super.key});

  @override
  State<GalleryBackButton> createState() => GalleryBackButtonState();
}

class GalleryBackButtonState extends State<GalleryBackButton> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: _hovering
                ? AppColors.primary.withValues(alpha: 0.15)
                : AppColors.primary.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _hovering
                  ? AppColors.primary.withValues(alpha: 0.5)
                  : AppColors.primary.withValues(alpha: 0.2),
            ),
          ),
          child: Row(
            mainAxisSize: .min,
            children: [
              Icon(
                Icons.arrow_back_ios_new,
                size: 18,
                color: AppColors.primary,
              ),
              horizontalSpace(8),
              Text(
                "Back",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: .w500,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
