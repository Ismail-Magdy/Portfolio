import 'package:flutter/material.dart';
import 'package:ismailmagdy/core/theme/app_colors.dart';
import 'package:ismailmagdy/portfolio/models/experience/experience_model.dart';
import 'package:ismailmagdy/portfolio/presentation/components/experience/components/experience_gallery_page.dart';
import 'package:ismailmagdy/portfolio/presentation/components/experience/widgets/experience_card_content.dart';

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
          transformAlignment: .center,
          decoration: BoxDecoration(
            color: AppColors.cardBackgroundDark,
            borderRadius: .circular(16),
            border: .all(
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
          child: ExperienceCardContent(
            experience: experience,
            hasImages: hasImages,
            hovering: _hovering,
          ),
        ),
      ),
    );
  }
}
// 231
