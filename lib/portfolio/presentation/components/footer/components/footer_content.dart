import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ismailmagdy/core/constants/app_strings.dart';
import 'package:ismailmagdy/core/helpers/spacing.dart';
import 'package:ismailmagdy/core/theme/app_colors.dart';
import 'package:ismailmagdy/portfolio/models/social_links/social_link_model.dart';
import 'package:ismailmagdy/portfolio/presentation/components/footer/components/footer_flutter_bird_logo.dart';
import 'package:ismailmagdy/portfolio/presentation/components/footer/functions/footer_functions.dart';
import 'package:url_launcher/url_launcher.dart';

class FooterContent extends StatelessWidget {
  const FooterContent({super.key, required this.socialLinks});

  final List<SocialLinkModel> socialLinks;

  @override
  Widget build(BuildContext context) {
    return Column(
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
        verticalSpace(12),
        //
        FooterFlutterBirdLogo(),
        //
      ],
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: .externalApplication);
    }
  }
}
