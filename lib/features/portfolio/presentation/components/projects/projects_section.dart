import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ismailmagdy/core/helpers/spacing.dart';
import 'package:ismailmagdy/core/theme/app_colors.dart';
import 'package:ismailmagdy/core/constants/app_dimensions.dart';
import 'package:ismailmagdy/core/constants/app_strings.dart';
import 'package:ismailmagdy/features/portfolio/data/repositories/projects_repository.dart';
import 'project_card.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final bool isDesktop = screenWidth >= 1024;
    final bool isTablet = screenWidth >= 600 && screenWidth < 1024;
    final bool isMobile = screenWidth < 600;

    final repository = ProjectsRepository();
    final projects = repository.getProjects();

    return Container(
      constraints: const BoxConstraints(
        maxWidth: AppDimensions.maxContentWidth,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? (12.0) : (AppDimensions.sectionPadding * 0.4),
        vertical: 80,
      ),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          // Text Project
          Text(
            AppStrings.projectsTitle,
            style: GoogleFonts.poppins(
              fontSize: 36,
              fontWeight: .bold,
              color: AppColors.textDark,
            ),
          ),
          //
          verticalSpace(40),
          //
          // All Projects
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile
                  ? 1
                  : isTablet
                  ? 2
                  : 3,
              crossAxisSpacing: 50,
              mainAxisSpacing: 24,
              childAspectRatio: isDesktop
                  ? 0.599
                  : isTablet
                  ? 0.5
                  : 0.72,
            ),
            itemCount: projects.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  border: .all(
                    color: AppColors.primaryRedesign.withValues(alpha: 0.5),
                    width: 1,
                  ),
                  borderRadius: .circular(AppDimensions.cardBorderRadius),
                ),
                child: ProjectCard(project: projects[index]),
              );
            },
          ),
          //
        ],
      ),
    );
  }
}
// 93