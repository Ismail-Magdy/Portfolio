import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ismailmagdy/core/constants/app_strings.dart';
import 'package:ismailmagdy/core/helpers/spacing.dart';
import 'package:ismailmagdy/core/theme/app_colors.dart';
import 'package:ismailmagdy/portfolio/repositories/experience_repository.dart';
import 'package:ismailmagdy/portfolio/presentation/components/experience/experience_card.dart';
import 'package:ismailmagdy/core/animations/experience/staggered_fade_in.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final repository = ExperienceRepository();
    final experiences = repository.getExperiences();

    return Container(
      constraints: const BoxConstraints(maxWidth: 1200),
      padding: .symmetric(horizontal: isMobile ? 40 : 80, vertical: 80),

      child: Column(
        crossAxisAlignment: .start,
        children: [
          //
          Text(
            AppStrings.professionalExperience,
            style: GoogleFonts.poppins(
              fontSize: 36,
              fontWeight: .bold,
              color: AppColors.textDark,
            ),
          ),
          //
          verticalSpace(8),
          //
          Text(
            AppStrings.myProfessionalJourneyInMobileDevelopment,
            style: GoogleFonts.poppins(
              fontSize: 18,
              color: AppColors.textDark.withValues(alpha: 0.7),
            ),
          ),
          //
          verticalSpace(60),
          //
          ...experiences.asMap().entries.map((entry) {
            final index = entry.key;
            final experience = entry.value;
            return StaggeredFadeIn(
              index: index,
              child: ExperienceCard(
                experience: experience,
                index: index,
                total: experiences.length,
                isMobile: isMobile,
              ),
            );
          }),
          //
        ],
      ),
    );
  }
}
