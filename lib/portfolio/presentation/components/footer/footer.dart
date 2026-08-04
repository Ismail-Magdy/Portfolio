import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ismailmagdy/core/helpers/spacing.dart';
import 'package:ismailmagdy/core/theme/app_colors.dart';
import 'package:ismailmagdy/core/constants/app_strings.dart';
import 'package:ismailmagdy/portfolio/repositories/social_links_repository.dart';
import 'package:url_launcher/url_launcher.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  ///
  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  ///
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

  //
  @override
  Widget build(BuildContext context) {
    final repository = SocialLinksRepository();
    final socialLinks = repository.getSocialLinks();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40),
      decoration: BoxDecoration(
        color: AppColors.cardBackgroundDark,
        border: Border(
          top: BorderSide(
            color: AppColors.textDark.withValues(alpha: 0.1),

            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          //
          Row(
            mainAxisAlignment: .center,
            children: socialLinks
                .map(
                  (link) => Padding(
                    padding: const .symmetric(horizontal: 16),
                    child: IconButton(
                      icon: FaIcon(
                        _getIconForPlatform(link.platform),
                        size: 24,
                        color: AppColors.primary,
                      ),
                      onPressed: () => _launchUrl(link.url),
                      tooltip: link.platform,
                    ),
                  ),
                )
                .toList(),
          ),
          //
          verticalSpace(20),
          //
          Text(
            AppStrings.copyright,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: AppColors.textDark.withValues(alpha: 0.6),
            ),
          ),
          //
        ],
      ),
    );
  }
}
