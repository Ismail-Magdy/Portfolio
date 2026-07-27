import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ismailmagdy/core/theme/app_colors.dart';
import 'package:ismailmagdy/core/constants/app_strings.dart';
import 'package:ismailmagdy/portfolio/repositories/projects_repository.dart';
import 'project_card.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    //  final bool isDesktop = screenWidth >= 1024;
    final bool isTablet = screenWidth >= 600 && screenWidth < 1024;
    final bool isMobile = screenWidth < 600;

    final repository = ProjectsRepository();
    final projects = repository.getProjects();

    return Container(
      constraints: const BoxConstraints(maxWidth: 1200),
      padding: .symmetric(horizontal: isMobile ? 12.0 : 24.0, vertical: 80),
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
              crossAxisSpacing: 24,
              mainAxisSpacing: 24,
              childAspectRatio: isMobile
                  ? 1.5
                  : isTablet
                  ? 1.4
                  : 1.35,
            ),
            itemCount: projects.length,
            itemBuilder: (context, index) {
              return ProjectCard(project: projects[index]);
            },
          ),
          //
        ],
      ),
    );
  }
}
// 93