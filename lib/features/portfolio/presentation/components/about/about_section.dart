import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ismailmagdy/core/helpers/spacing.dart';
import 'package:ismailmagdy/core/theme/app_colors.dart';
import 'package:ismailmagdy/core/constants/app_dimensions.dart';
import 'package:ismailmagdy/core/constants/app_strings.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Container(
      constraints: const BoxConstraints(
        maxWidth: AppDimensions.maxContentWidth,
      ),
      padding: .symmetric(
        horizontal: isMobile
            ? AppDimensions.mobileSectionPadding
            : AppDimensions.sectionPadding,
        vertical: 80,
      ),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          // About Me Text
          Text(
            AppStrings.aboutTitle,
            style: GoogleFonts.poppins(
              fontSize: 36,
              fontWeight: .bold,
              color: AppColors.textDark,
            ),
          ),
          //
          verticalSpace(24),
          // Description
          Text(
            AppStrings.aboutDescription,
            style: GoogleFonts.poppins(
              fontSize: 18,
              height: 1.8,
              color: AppColors.textDark,
            ),
          ),
          //
        ],
      ),
    );
  }
}
