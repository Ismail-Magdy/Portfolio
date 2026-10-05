import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ismailmagdy/core/constants/app_strings.dart';
import 'package:ismailmagdy/core/helpers/spacing.dart';
import 'package:ismailmagdy/core/theme/app_colors.dart';
import 'package:ismailmagdy/portfolio/presentation/components/experience/desktop_timeline.dart';
import 'package:ismailmagdy/portfolio/presentation/components/experience/mobile_timeline.dart';
import 'package:ismailmagdy/portfolio/repositories/experience/experience_repository.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTabletOrDesktop = !isMobile;
    final repository = ExperienceRepository();
    final experiences = repository.getExperiences();

    return Container(
      constraints: const BoxConstraints(maxWidth: 1200),
      padding: .symmetric(horizontal: isMobile ? 20 : 80, vertical: 80),
      child: Column(
        crossAxisAlignment: .center,
        children: [
          // Section Header
          Column(
            children: [
              //
              Text(
                AppStrings.professionalExperience,
                textAlign: .center,
                style: GoogleFonts.poppins(
                  fontSize: isMobile ? 28 : 36,
                  fontWeight: .bold,
                  color: AppColors.textDark,
                ),
              ),
              //
              verticalSpace(8),
              //
              Text(
                AppStrings.myProfessionalJourneyInMobileDevelopment,
                textAlign: .center,
                style: GoogleFonts.poppins(
                  fontSize: isMobile ? 15 : 18,
                  color: AppColors.textDark.withValues(alpha: 0.7),
                ),
              ),
              //
            ],
          ),
          //
          verticalSpace(60),
          // Timelines
          if (isTabletOrDesktop)
            DesktopTimeline(experiences: experiences)
          //
          else
            MobileTimeline(experiences: experiences),
          //
        ],
      ),
    );
  }
}
// 356
