import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ismailmagdy/core/helpers/spacing.dart';
import 'package:ismailmagdy/core/theme/app_colors.dart';
import 'package:ismailmagdy/portfolio/models/experience/experience_model.dart';

class ExperienceCard extends StatelessWidget {
  const ExperienceCard({super.key, required this.experience});
  final ExperienceModel experience;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
      decoration: BoxDecoration(
        color: AppColors.cardBackgroundDark,
        borderRadius: .circular(16),
        border: .all(
          color: AppColors.primary.withValues(alpha: 0.15),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.03),
            blurRadius: 40,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Padding(
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
          ],
        ),
      ),
    );
  }
}
// 141
