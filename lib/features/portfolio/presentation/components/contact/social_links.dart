import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ismailmagdy/core/constants/app_strings.dart';
import 'package:ismailmagdy/core/helpers/spacing.dart';
import 'package:ismailmagdy/core/theme/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ismailmagdy/core/animations/pulse_animation.dart';

class SocialLinks extends StatelessWidget {
  const SocialLinks({super.key, required this.socialLinks});
  final List socialLinks;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Text(
          AppStrings.socialMedia,
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: .w600,
            color: AppColors.textDark,
          ),
        ),
        //
        verticalSpace(20),
        //
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: socialLinks
              .map(
                (link) => PulseAnimation(
                  child: GestureDetector(
                    onTap: () => _launchUrl(link.url),
                    child: Container(
                      padding: const .all(16),
                      decoration: BoxDecoration(
                        color: AppColors.cardBackgroundDark,
                        borderRadius: .circular(12),
                        border: .all(
                          color: AppColors.primary.withValues(alpha: 0.3),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: .min,
                        children: [
                          FaIcon(
                            _getIconForPlatform(link.platform),
                            color: AppColors.primary,
                            size: 20,
                          ),
                          horizontalSpace(8),
                          Text(
                            link.platform,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: .w500,
                              color: AppColors.textDark,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  IconData _getIconForPlatform(String platform) {
    switch (platform.toLowerCase()) {
      case AppStrings.linkedin:
        return FontAwesomeIcons.linkedin;
      case AppStrings.githubText:
        return FontAwesomeIcons.github;
      case AppStrings.twitter:
        return FontAwesomeIcons.twitter;
      case AppStrings.instagram:
        return FontAwesomeIcons.instagram;
      default:
        return FontAwesomeIcons.link;
    }
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: .externalApplication);
    }
  }
}
