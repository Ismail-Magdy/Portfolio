import 'package:flutter/material.dart';
import 'package:ismailmagdy/core/helpers/spacing.dart';
import 'package:ismailmagdy/portfolio/repositories/social_links_repository.dart';
import 'package:ismailmagdy/portfolio/presentation/components/hero/components/build_content_widget.dart';
import 'package:ismailmagdy/portfolio/presentation/components/hero/widgets/profile_image_widget.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final repository = SocialLinksRepository();
    final socialLinks = repository.getSocialLinks();

    return Container(
      constraints: const BoxConstraints(maxWidth: 1200),
      padding: EdgeInsets.only(
        left: isMobile ? 40 : 80,
        right: isMobile ? 40 : 80,
        top: 180,
        bottom: 80,
      ),
      child: isMobile
          // Mobile
          ? Column(
              crossAxisAlignment: .center,
              children: [
                // Image Mobile
                const ProfileImageWidget(),
                //
                verticalSpace(40),
                // Content Mobile
                BuildContentWidget(socialLinks: socialLinks),
                //
              ],
            )
          //
          // Not Mobile
          : Row(
              crossAxisAlignment: .center,
              children: [
                //
                Expanded(
                  flex: 1,
                  // Content Not Mobile
                  child: BuildContentWidget(socialLinks: socialLinks),
                ),
                horizontalSpace(60),
                // Image Not Mobile
                const Expanded(flex: 1, child: ProfileImageWidget()),
              ],
            ),
      //
    );
  }
}
