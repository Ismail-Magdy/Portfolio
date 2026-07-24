import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ismailmagdy/core/constants/app_images.dart';
import 'package:ismailmagdy/core/constants/app_strings.dart';
import 'package:ismailmagdy/core/theme/app_colors.dart';
import 'package:ismailmagdy/core/constants/app_dimensions.dart';
import 'package:ismailmagdy/features/portfolio/presentation/screens/project_details_screen.dart';
import '../../../domain/models/project_model.dart';

class ProjectCard extends StatefulWidget {
  final ProjectModel project;

  const ProjectCard({super.key, required this.project});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _arrowController;
  late Animation<double> _arrowAnimation;

  @override
  void initState() {
    super.initState();
    _arrowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    _arrowAnimation = Tween<double>(begin: 0.0, end: 6.0).animate(
      CurvedAnimation(parent: _arrowController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _arrowController.dispose();
    super.dispose();
  }

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

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProjectDetailsScreen(project: widget.project),
          ),
        );
      },
      borderRadius: BorderRadius.circular(AppDimensions.cardBorderRadius),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppDimensions.cardBorderRadius),
        child: Container(
          color: AppColors.backgroundDark,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Project Image — takes remaining space
              Expanded(
                child: Hero(
                  tag: widget.project.title,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(AppDimensions.cardBorderRadius),
                      topRight: Radius.circular(AppDimensions.cardBorderRadius),
                    ),
                    child: Image.asset(
                      _getProjectImagePath(widget.project.title),
                      fit: BoxFit.cover,
                      width: double.infinity,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: AppColors.primary.withValues(alpha: 0.1),
                          child: const Icon(
                            Icons.image,
                            size: 50,
                            color: AppColors.primary,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              // Title + Animated Arrow
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.project.title,
                        style: GoogleFonts.poppins(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textDark,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Animated sliding arrow
                    AnimatedBuilder(
                      animation: _arrowAnimation,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(_arrowAnimation.value, 0),
                          child: child,
                        );
                      },
                      child: Icon(
                        Icons.keyboard_double_arrow_right,
                        color: AppColors.primary.withValues(alpha: 0.7),
                        size: 22,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
