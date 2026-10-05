import 'package:flutter/material.dart';
import 'package:ismailmagdy/core/theme/app_colors.dart';
import 'package:ismailmagdy/portfolio/presentation/components/projects/components/project_details_screen.dart';
import 'package:ismailmagdy/portfolio/presentation/components/projects/components/project_iscoming_soon_widget.dart';
import 'package:ismailmagdy/portfolio/presentation/components/projects/widgets/title_and_liquid_glass_arrow.dart';

import '../../../../models/projects/project_model.dart';

class ProjectCard extends StatefulWidget {
  final ProjectModel project;

  const ProjectCard({super.key, required this.project});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard>
    with TickerProviderStateMixin {
  late AnimationController _rippleController;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _rippleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..repeat();
  }

  @override
  void dispose() {
    _rippleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: widget.project.isComingSoon
          ? SystemMouseCursors.basic
          : SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.project.isComingSoon
            ? null
            : () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ProjectDetailsScreen(project: widget.project),
                ),
              ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          transform: Matrix4.identity()
            ..scale(
              _isHovered && !widget.project.isComingSoon ? 1.03 : 1.0,
              _isHovered && !widget.project.isComingSoon ? 1.03 : 1.0,
            ),
          transformAlignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.backgroundDark,
            borderRadius: .circular(16),
            border: Border.all(
              color: _isHovered && !widget.project.isComingSoon
                  ? AppColors.primary.withValues(alpha: 0.4)
                  : Colors.white.withValues(alpha: 0.06),
              width: 1.5,
            ),
            // Shadows
            boxShadow: _isHovered && !widget.project.isComingSoon
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.15),
                      blurRadius: 24,
                      spreadRadius: 2,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
          ),
          child: ClipRRect(
            borderRadius: .circular(16),
            child: Column(
              crossAxisAlignment: .stretch,
              children: [
                // Project Image
                Expanded(
                  child: Hero(
                    tag: widget.project.title,
                    child: ClipRRect(
                      borderRadius: const .vertical(top: .circular(16)),
                      child: Stack(
                        fit: .expand,
                        children: [
                          //
                          Opacity(
                            opacity: widget.project.isComingSoon ? 0.3 : 1.0,
                            child: ColorFiltered(
                              colorFilter: const .mode(
                                Colors.transparent,
                                .dst,
                              ),
                              child: Image.asset(
                                widget.project.imageOut,
                                width: .infinity,
                                height: .infinity,
                                fit: .fill,
                                alignment: .topCenter,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: AppColors.primary.withValues(
                                      alpha: 0.1,
                                    ),
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
                          //
                          if (widget.project.isComingSoon)
                            //
                            ProjectIscomingSoonWidget(
                              rippleController: _rippleController,
                            ),
                          //
                        ],
                      ),
                    ),
                  ),
                ),
                // Title + Liquid Glass Arrow
                TitleAndLiquidGlassArrow(
                  project: widget.project,
                  projectTitle: widget.project.title,
                  rippleController: _rippleController,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// 253
