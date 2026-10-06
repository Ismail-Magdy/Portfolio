import 'package:flutter/material.dart';
import 'package:ismailmagdy/core/theme/app_colors.dart';
import 'package:ismailmagdy/portfolio/presentation/components/footer/components/footer_content.dart';
import 'package:ismailmagdy/portfolio/repositories/social/social_links_repository.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

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
      child: FooterContent(socialLinks: socialLinks),
    );
  }
}
// 94
