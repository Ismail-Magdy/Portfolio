import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ismailmagdy/core/helpers/spacing.dart';
import 'package:ismailmagdy/core/theme/app_colors.dart';
import 'package:ismailmagdy/portfolio/models/experience/experience_model.dart';
import 'package:ismailmagdy/portfolio/presentation/screens/experience_gallery_page.dart';

class ExperienceCard extends StatefulWidget {
  const ExperienceCard({super.key, required this.experience});
  final ExperienceModel experience;

  @override
  State<ExperienceCard> createState() => _ExperienceCardState();
}

class _ExperienceCardState extends State<ExperienceCard> {
  bool _hovering = false;

  void _navigateToGallery() {
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        reverseTransitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (context, animation, secondaryAnimation) =>
            ExperienceGalleryPage(experience: widget.experience),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic,
          );
          return FadeTransition(
            opacity: curvedAnimation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.05),
                end: Offset.zero,
              ).animate(curvedAnimation),
              child: child,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final experience = widget.experience;
    final hasImages = experience.images.isNotEmpty;

    return MouseRegion(
      cursor: hasImages ? SystemMouseCursors.click : SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: hasImages ? _navigateToGallery : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          transform: Matrix4.identity()
            ..scale(
              _hovering && hasImages ? 1.02 : 1.0,
              _hovering && hasImages ? 1.02 : 1.0,
            ),
          transformAlignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.cardBackgroundDark,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _hovering && hasImages
                  ? AppColors.primary.withValues(alpha: 0.4)
                  : AppColors.primary.withValues(alpha: 0.15),
              width: 1,
            ),
            // Shadows
            boxShadow: [
              BoxShadow(
                color: _hovering && hasImages
                    ? AppColors.primary.withValues(alpha: 0.08)
                    : Colors.black.withValues(alpha: 0.2),
                blurRadius: _hovering && hasImages ? 28 : 20,
                offset: const Offset(0, 8),
              ),
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.03),
                blurRadius: 40,
                spreadRadius: 2,
              ),
            ],
            //
          ),
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Period badge
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    experience.period,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                //
                verticalSpace(16),
                // Title
                Text(
                  experience.title,
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                    height: 1.3,
                  ),
                ),
                //
                verticalSpace(6),
                // Company
                Text(
                  experience.company,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primary.withValues(alpha: 0.8),
                    height: 1.4,
                  ),
                ),
                //
                verticalSpace(16),
                // Description
                Text(
                  experience.description,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    height: 1.7,
                    color: AppColors.textDark.withValues(alpha: 0.75),
                  ),
                ),
                //
                verticalSpace(20),
                // Technologies
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: experience.technologies
                      .map(
                        (tech) => Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color:
                                  AppColors.primary.withValues(alpha: 0.2),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            tech,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color:
                                  AppColors.primary.withValues(alpha: 0.9),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
                //
                // "View Gallery →" hint
                if (hasImages) ...[
                  verticalSpace(20),
                  Align(
                    alignment: Alignment.centerRight,
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 250),
                      opacity: _hovering ? 1.0 : 0.6,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.photo_library_outlined,
                            size: 16,
                            color: AppColors.primary,
                          ),
                          horizontalSpace(6),
                          Text(
                            'View Gallery',
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary,
                            ),
                          ),
                          horizontalSpace(4),
                          Icon(
                            Icons.arrow_forward_rounded,
                            size: 16,
                            color: AppColors.primary,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
