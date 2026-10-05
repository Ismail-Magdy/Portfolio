import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ismailmagdy/core/constants/app_strings.dart';
import 'package:ismailmagdy/core/helpers/spacing.dart';
import 'package:ismailmagdy/core/theme/app_colors.dart';
import 'package:ismailmagdy/portfolio/presentation/components/hero/functions/hero_functions.dart';

class BuildContentWidget extends StatelessWidget {
  const BuildContentWidget({super.key, required this.socialLinks});
  final List socialLinks;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      mainAxisAlignment: .center,
      children: [
        // IAM Text
        Text(
          AppStrings.greeting,
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: .w400,
            color: AppColors.textDark.withValues(alpha: 0.8),
          ),
        ),
        //
        verticalSpace(8),
        // Name
        Text(
          AppStrings.name,
          style: GoogleFonts.poppins(
            fontSize: 48,
            fontWeight: .bold,
            color: AppColors.textDark,
          ),
        ),
        //
        verticalSpace(16),
        // Title
        Text(
          AppStrings.title,
          style: GoogleFonts.poppins(
            fontSize: 32,
            fontWeight: .w600,
            color: AppColors.primary,
          ),
        ),
        //
        verticalSpace(24),
        // Description
        Text(
          AppStrings.aboutDescription.split('\n\n')[0],
          style: GoogleFonts.poppins(
            fontSize: 16,
            height: 1.6,
            color: AppColors.textDark.withValues(alpha: 0.8),
          ),
        ),
        //
        verticalSpace(32),
        // Two Buttons
        Row(
          children: [
            // Download CV Button
            MaterialButton(
              onPressed: downloadCV,
              color: AppColors.primary,
              textColor: Colors.white,
              padding: const .symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: .circular(8)),
              child: Text(
                AppStrings.downloadCV,
                style: GoogleFonts.poppins(fontSize: 16, fontWeight: .w600),
              ),
            ),
            //
            horizontalSpace(16),
            // Contact Button
            OutlinedButton(
              onPressed: contactWhatsApp,
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primary,
                side: const BorderSide(color: AppColors.primary, width: 2),
                padding: const .symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: .circular(8)),
              ),
              child: Text(
                AppStrings.contact,
                style: GoogleFonts.poppins(fontSize: 16, fontWeight: .w600),
              ),
            ),
            //
          ],
        ),
        //
        verticalSpace(32),
        // Social Icons Row
        Row(
          children: [
            for (var link in socialLinks)
              Padding(
                padding: const .only(right: 16),
                child: InkWell(
                  onTap: () => launchSocial(link.url),
                  borderRadius: .circular(8),
                  child: Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      color: AppColors.cardBackgroundDark,
                      borderRadius: .circular(8),
                      border: .all(
                        color: AppColors.primary.withValues(alpha: 0.3),
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: FaIcon(
                        getIconForPlatform(link.platform),
                        color: AppColors.primary,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
        //
      ],
    );
  }
}
// 192
