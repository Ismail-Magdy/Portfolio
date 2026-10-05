import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ismailmagdy/core/helpers/spacing.dart';
import 'package:ismailmagdy/core/theme/app_colors.dart';
import 'package:ismailmagdy/core/constants/app_strings.dart';
import 'package:ismailmagdy/portfolio/presentation/components/hero/functions/hero_functions.dart';
import 'package:ismailmagdy/portfolio/repositories/social/social_links_repository.dart';
import 'package:url_launcher/url_launcher.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  ///
  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: .externalApplication);
    }
  }

  //
  @override
  Widget build(BuildContext context) {
    final repository = SocialLinksRepository();
    final socialLinks = repository.getSocialLinks();

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
      padding: const .symmetric(vertical: 40),
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
                        getIconForPlatform(link.platform),
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
// 94
