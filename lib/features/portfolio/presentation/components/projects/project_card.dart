import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ismailmagdy/core/constants/app_images.dart';
import 'package:ismailmagdy/core/constants/app_strings.dart';
import 'package:ismailmagdy/core/helpers/spacing.dart';
import 'package:ismailmagdy/core/theme/app_colors.dart';
import 'package:ismailmagdy/core/constants/app_dimensions.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ismailmagdy/features/portfolio/presentation/components/projects/github_button.dart';
import '../../../domain/models/project_model.dart';

class ProjectCard extends StatelessWidget {
  final ProjectModel project;

  const ProjectCard({super.key, required this.project});

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: .externalApplication);
    }
  }

  ///
  String _getProjectImagePath(String projectTitle) {
    switch (projectTitle.toLowerCase()) {
      case AppStrings.mealMonkey:
        return AppImages.mealMonkeyImage;
      case AppStrings.bookShop:
        return AppImages.bookShopImage;
      case AppStrings.portfolioWebsite:
        return AppImages.portfolioImage;
      case AppStrings.joby:
        return AppImages.jobyImage;
      default:
        return AppImages.mealMonkeyImage;
    }
  }

  //
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Card(
      color: AppColors.backgroundDark,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: .circular(AppDimensions.cardBorderRadius),
      ),
      child: Column(
        crossAxisAlignment: .start,
        mainAxisSize: .min,
        children: [
          // Project Image
          Container(
            width: .infinity,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: .circular(AppDimensions.cardBorderRadius),
            ),
            child: ClipRRect(
              borderRadius: const .only(
                topLeft: .circular(AppDimensions.cardBorderRadius),
                topRight: .circular(AppDimensions.cardBorderRadius),
              ),
              // Image
              child: Image.asset(
                _getProjectImagePath(project.title),
                fit: .cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    child: Icon(
                      Icons.image,
                      size: 50,
                      color: AppColors.primary,
                    ),
                  );
                },
              ),
            ),
          ),
          //
          Padding(
            padding: .all(20),
            child: Column(
              crossAxisAlignment: .start,
              mainAxisSize: .min,
              children: [
                // Project Title
                Text(
                  project.title,
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: .bold,
                    color: AppColors.textDark,
                  ),
                ),
                //
                verticalSpace(12),
                //
                // Project Description
                Text(
                  project.description,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    height: 1.6,
                    color: AppColors.textDark.withValues(alpha: 0.7),
                  ),
                  maxLines: 3,
                  overflow: .ellipsis,
                ),
                //
                verticalSpace(12),
                //
                // Tech Stack
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: project.techStack
                      .map(
                        (tech) => Container(
                          padding: const .symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.2),
                            borderRadius: .circular(20),
                          ),
                          child: Text(
                            tech,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: AppColors.primary,
                              fontWeight: .w500,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
                //
                verticalSpace(isMobile ? 16 : 40),
                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: GithubButton(
                        onPressed: () => _launchUrl(project.githubUrl),
                      ),
                    ),
                    if (project.liveDemoUrl != null) ...[
                      horizontalSpace(12),
                      //
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => _launchUrl(project.liveDemoUrl!),
                          icon: const FaIcon(FontAwesomeIcons.globe, size: 16),
                          label: const Text(AppStrings.liveDemo),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            padding: const .symmetric(vertical: 12),
                          ),
                        ),
                      ),
                      //
                    ],
                  ],
                ),
                //
              ],
            ),
          ),
        ],
      ),
    );
  }
}
// 202