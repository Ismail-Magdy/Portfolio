import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ismailmagdy/core/constants/app_strings.dart';
import 'package:ismailmagdy/core/helpers/spacing.dart';
import 'package:ismailmagdy/core/theme/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

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
            fontWeight: FontWeight.w400,
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
            fontWeight: FontWeight.bold,
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
            fontWeight: FontWeight.w600,
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
              onPressed: _downloadCV,
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
              onPressed: _contactWhatsApp,
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primary,
                side: const BorderSide(color: AppColors.primary, width: 2),
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                AppStrings.contact,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
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
                  onTap: () => _launchSocial(link.url),
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
                    child: Icon(
                      _getIconForPlatform(link.platform),
                      color: AppColors.primary,
                      size: 20,
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

  /// Helper Functions

  // Download CV
  Future<void> _downloadCV() async {
    //
    final Uri cvUrl = Uri.parse(
      "https://drive.google.com/file/d/1osj_MnhsvdQw2aXMFUZ9p1PmsHEqgmCR/view?usp=sharing",
    );
    if (await canLaunchUrl(cvUrl)) {
      await launchUrl(cvUrl, webOnlyWindowName: "_blank");
    } else {}
  }

  // WhatsApp
  Future<void> _contactWhatsApp() async {
    final url = Uri.parse("https://wa.me/201206607906");
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  // Social
  Future<void> _launchSocial(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  // Get Icon
  IconData _getIconForPlatform(String platform) {
    switch (platform.toLowerCase()) {
      case "linkedin":
        return FontAwesomeIcons.linkedin;
      case "github":
        return FontAwesomeIcons.github;
      case "twitter":
        return FontAwesomeIcons.twitter;
      case "instagram":
        return FontAwesomeIcons.instagram;
      default:
        return FontAwesomeIcons.link;
    }
  }

  //
}
