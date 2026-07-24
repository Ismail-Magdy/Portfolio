import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ismailmagdy/core/constants/app_links.dart';
import 'package:ismailmagdy/core/helpers/spacing.dart';
import 'package:ismailmagdy/core/theme/app_colors.dart';
import 'package:ismailmagdy/core/constants/app_dimensions.dart';
import 'package:ismailmagdy/core/constants/app_strings.dart';
import 'package:ismailmagdy/features/portfolio/data/repositories/social_links_repository.dart';
import 'package:ismailmagdy/features/portfolio/presentation/components/contact/contact_item.dart';
import 'package:ismailmagdy/features/portfolio/presentation/components/contact/social_links.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  Future<void> _launchEmail() async {
    final email = Uri.parse(AppLinks.emailFormat);
    if (await canLaunchUrl(email)) {
      await launchUrl(email);
    }
  }

  Future<void> _launchPhone() async {
    final phone = Uri.parse(AppLinks.phoneFormat);
    if (await canLaunchUrl(phone)) {
      await launchUrl(phone);
    }
  }

  Future<void> _launchWhatsApp() async {
    final url = Uri.parse(AppLinks.whatsAppFormat);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: .externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final repository = SocialLinksRepository();
    final socialLinks = repository.getSocialLinks();

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
          // Text Contact
          Text(
            AppStrings.contactTitle,
            style: GoogleFonts.poppins(
              fontSize: 36,
              fontWeight: .bold,
              color: AppColors.textDark,
            ),
          ),
          //
          verticalSpace(40),
          //
          if (isMobile)
            Column(
              crossAxisAlignment: .start,
              children: [
                //
                ContactItem(
                  icon: Icons.email,
                  label: AppStrings.email,
                  value: AppStrings.myEmail,
                  onTap: _launchEmail,
                ),
                //
                verticalSpace(24),
                //
                ContactItem(
                  icon: Icons.phone,
                  label: AppStrings.phone,
                  value: AppStrings.phoneNumber,
                  onTap: _launchPhone,
                ),
                //
                verticalSpace(24),
                //
                ContactItem(
                  icon: FontAwesomeIcons.whatsapp,
                  label: AppStrings.whatsApp,
                  value: AppStrings.whatsAppNumber,
                  onTap: _launchWhatsApp,
                ),
                //
                verticalSpace(40),
                //
                SocialLinks(socialLinks: socialLinks),
                //
              ],
            )
          else
            Row(
              crossAxisAlignment: .start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      //
                      ContactItem(
                        icon: Icons.email,
                        label: AppStrings.email,
                        value: AppStrings.myEmail,
                        onTap: _launchEmail,
                      ),
                      //
                      verticalSpace(24),
                      //
                      ContactItem(
                        icon: Icons.phone,
                        label: AppStrings.phone,
                        value: AppStrings.phoneNumber,
                        onTap: _launchPhone,
                      ),
                      //
                      verticalSpace(24),
                      //
                      ContactItem(
                        icon: FontAwesomeIcons.whatsapp,
                        label: AppStrings.whatsApp,
                        value: AppStrings.whatsAppNumber,
                        onTap: _launchWhatsApp,
                      ),
                      //
                    ],
                  ),
                ),
                //
                horizontalSpace(60),
                //
                Expanded(child: SocialLinks(socialLinks: socialLinks)),
                //
              ],
            ),
        ],
      ),
    );
  }
}
