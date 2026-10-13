import 'package:flutter/material.dart';
import 'package:ismailmagdy/core/theme/app_colors.dart';
import 'package:ismailmagdy/portfolio/models/experience/experience_model.dart';
import 'package:ismailmagdy/portfolio/presentation/components/experience/widgets/gallery_back_button.dart';
import 'package:ismailmagdy/portfolio/presentation/components/experience/widgets/gallery_header_section.dart';
import 'package:ismailmagdy/portfolio/presentation/components/experience/widgets/gallery_image_card.dart';
import 'package:ismailmagdy/portfolio/presentation/components/experience/widgets/photo_count_badge.dart';

class ExperienceGalleryPage extends StatelessWidget {
  const ExperienceGalleryPage({super.key, required this.experience});
  final ExperienceModel experience;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth < 1200;

    int crossAxisCount = 3;
    if (isMobile) {
      crossAxisCount = 1;
    } else if (isTablet) {
      crossAxisCount = 2;
    }

    final horizontalPadding = isMobile ? 20.0 : (isTablet ? 48.0 : 80.0);

    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: CustomScrollView(
        slivers: [
          // Back button app bar
          SliverToBoxAdapter(
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: .symmetric(
                  horizontal: horizontalPadding,
                  vertical: 24,
                ),
                child: Row(
                  children: [
                    //
                    GalleryBackButton(),
                    //
                    const Spacer(),
                    // Photo count badge
                    if (experience.images.isNotEmpty)
                      //
                      PhotoCountBadge(
                        experienceImagesLength:
                            "${experience.images.length} Photos",
                      ),
                    //
                  ],
                ),
              ),
            ),
          ),

          // Header Section
          SliverToBoxAdapter(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: Padding(
                  padding: .symmetric(horizontal: horizontalPadding),
                  child: GalleryHeaderSection(
                    experience: experience,
                    isMobile: isMobile,
                  ),
                ),
              ),
            ),
          ),
          //
          // Photo Grid
          if (experience.images.isNotEmpty)
            //
            SliverPadding(
              padding: .only(
                left: horizontalPadding,
                right: horizontalPadding,
                bottom: 80,
              ),
              sliver: SliverLayoutBuilder(
                builder: (context, constraints) {
                  return SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      childAspectRatio: 4 / 3,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => GalleryImageCard(
                        imagePath: experience.images[index],
                        index: index,
                        allImages: experience.images,
                      ),
                      childCount: experience.images.length,
                    ),
                  );
                },
              ),
            ),
          //
        ],
      ),
    );
  }
}
