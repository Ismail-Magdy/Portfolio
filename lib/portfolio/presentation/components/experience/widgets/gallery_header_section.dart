import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ismailmagdy/core/helpers/spacing.dart';
import 'package:ismailmagdy/core/theme/app_colors.dart';
import 'package:ismailmagdy/portfolio/models/experience/experience_model.dart';

class GalleryHeaderSection extends StatelessWidget {
  const GalleryHeaderSection({
    super.key,
    required this.experience,
    required this.isMobile,
  });
  final ExperienceModel experience;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        verticalSpace(16),
        // Period badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.primary.withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          child: Text(
            experience.period,
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.primary,
            ),
          ),
        ),
        verticalSpace(20),
        // Title
        Text(
          experience.title,
          style: GoogleFonts.poppins(
            fontSize: isMobile ? 28 : 40,
            fontWeight: .bold,
            color: AppColors.textDark,
            height: 1.2,
          ),
        ),
        verticalSpace(12),
        // Company
        Text(
          experience.company,
          style: GoogleFonts.poppins(
            fontSize: isMobile ? 16 : 20,
            fontWeight: .w500,
            color: AppColors.primary,
            height: 1.4,
          ),
        ),
        verticalSpace(24),
        // Description
        Text(
          experience.description,
          style: GoogleFonts.poppins(
            fontSize: isMobile ? 14 : 16,
            height: 1.8,
            color: AppColors.textDark.withValues(alpha: 0.7),
          ),
        ),
        verticalSpace(20),
        // Technologies
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: experience.technologies
              .map(
                (tech) => Container(
                  padding: const .symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.08),
                    borderRadius: .circular(8),
                    border: .all(
                      color: AppColors.primary.withValues(alpha: 0.2),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    tech,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: AppColors.primary.withValues(alpha: 0.9),
                      fontWeight: .w500,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
        verticalSpace(48),
        // Gallery divider
        if (experience.images.isNotEmpty) ...[
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 1,
                  color: Colors.white.withValues(alpha: 0.08),
                ),
              ),
              Padding(
                padding: const .symmetric(horizontal: 20),
                child: Text(
                  "GALLERY",
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: .w600,
                    color: AppColors.primary.withValues(alpha: 0.6),
                    letterSpacing: 3,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 1,
                  color: Colors.white.withValues(alpha: 0.08),
                ),
              ),
            ],
          ),
          verticalSpace(32),
        ],
      ],
    );
  }
}
