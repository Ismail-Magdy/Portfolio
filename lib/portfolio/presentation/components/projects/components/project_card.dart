import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ismailmagdy/core/theme/app_colors.dart';
import 'package:ismailmagdy/portfolio/presentation/components/projects/components/project_details_screen.dart';
import 'package:ismailmagdy/portfolio/presentation/components/projects/widgets/liquid_glass_arrow.dart';
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
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _isHovered && !widget.project.isComingSoon
                  ? AppColors.primary.withValues(alpha: 0.4)
                  : Colors.white.withValues(alpha: 0.06),
              width: 1.5,
            ),
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
            borderRadius: BorderRadius.circular(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                          Opacity(
                            opacity: widget.project.isComingSoon ? 0.3 : 1.0,
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
                          if (widget.project.isComingSoon)
                            Positioned(
                              top: 16,
                              right: 16,
                              child: AnimatedBuilder(
                                animation: _rippleController,
                                builder: (context, child) {
                                  // Pulsing opacity between 0.6 and 1.0
                                  final pulse =
                                      0.6 +
                                      (0.4 *
                                          (0.5 +
                                              0.5 *
                                                  Curves.easeInOut.transform(
                                                    (_rippleController.value <=
                                                            0.5
                                                        ? _rippleController
                                                                  .value *
                                                              2
                                                        : (1 -
                                                                  _rippleController
                                                                      .value) *
                                                              2),
                                                  )));

                                  return Opacity(opacity: pulse, child: child);
                                },
                                child: ClipRRect(
                                  borderRadius: .circular(4),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                      sigmaX: 8,
                                      sigmaY: 8,
                                    ),
                                    child: Container(
                                      padding: const .symmetric(
                                        horizontal: 10,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withValues(
                                          alpha: 0.4,
                                        ),
                                        borderRadius: .circular(10),
                                        border: .all(
                                          color: Colors.white.withValues(
                                            alpha: 0.1,
                                          ),
                                          width: 0.5,
                                        ),
                                      ),
                                      child: Text(
                                        "COMING SOON",
                                        style: GoogleFonts.poppins(
                                          fontSize: 10,
                                          fontWeight: .w600,
                                          letterSpacing: 2.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Title + Liquid Glass Arrow
                Container(
                  padding: const .symmetric(horizontal: 14, vertical: 14),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: .topCenter,
                      end: .bottomCenter,
                      colors: [
                        const Color(0xFF0D2137),
                        AppColors.backgroundDark,
                      ],
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.project.title,
                          style: GoogleFonts.poppins(
                            fontSize: 17,
                            fontWeight: .w600,
                            color: AppColors.textDark,
                          ),
                          maxLines: 1,
                          overflow: .ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Liquid glass animated arrow (hide if coming soon)
                      if (!widget.project.isComingSoon)
                        LiquidGlassArrow(controller: _rippleController),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
