import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ismailmagdy/core/helpers/spacing.dart';
import 'package:ismailmagdy/core/theme/app_colors.dart';

class PhotoCountBadge extends StatelessWidget {
  const PhotoCountBadge({super.key, required this.experienceImagesLength});
  final String experienceImagesLength;

  @override
  Widget build(BuildContext context) {
    return //
    Container(
      padding: const .symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: .circular(20),
        border: .all(color: AppColors.primary.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: .min,
        children: [
          Icon(
            Icons.photo_library_outlined,
            size: 16,
            color: AppColors.primary,
          ),
          horizontalSpace(8),
          Text(
            experienceImagesLength,
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: .w500,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
    //
  }
}
