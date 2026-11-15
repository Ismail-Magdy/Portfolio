import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ismailmagdy/core/helpers/spacing.dart';
import 'package:ismailmagdy/core/theme/app_colors.dart';
import 'package:ismailmagdy/portfolio/models/experience/experience_model.dart';

class ExperienceCardContent extends StatelessWidget {
  const ExperienceCardContent({
    super.key,
    required this.experience,
    required this.hasImages,
    required this.hovering,
  });

  final ExperienceModel experience;
  final bool hasImages;
  final bool hovering;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const .all(28),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          // Period badge
          Container(
            padding: const .symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: .circular(20),
              border: .all(
                color: AppColors.primary.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Text(
              experience.period,
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: .w500,
                color: AppColors.primary,
              ),
            ),
          ),
          //
          verticalSpace(16),
          // Title
          Text(
            experience.title,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: .bold,
              color: AppColors.textDark,
              height: 1.3,
            ),
          ),
          //
          verticalSpace(6),
          // Company
          Text(
            experience.company,
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: .w500,
              color: AppColors.primary.withValues(alpha: 0.8),
              height: 1.4,
            ),
          ),
          //
          verticalSpace(16),
          // Description
          Text(
            experience.description,
            style: GoogleFonts.poppins(
              fontSize: 14,
              height: 1.7,
              color: AppColors.textDark.withValues(alpha: 0.75),
            ),
          ),
          //
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
          //
          // View Gallery → hint
          if (hasImages) ...[
            //
            verticalSpace(20),
            //
            Align(
              alignment: .centerRight,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 250),
                opacity: hovering ? 1.0 : 0.6,
                child: Row(
                  mainAxisSize: .min,
                  children: [
                    //
                    Icon(
                      Icons.photo_library_outlined,
                      size: 16,
                      color: AppColors.primary,
                    ),
                    //
                    horizontalSpace(6),
                    //
                    Text(
                      "View Gallery",
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: .w600,
                        color: AppColors.primary,
                      ),
                    ),
                    //
                  ],
                ),
              ),
            ),
            //
          ],
        ],
      ),
    );
  }
}
