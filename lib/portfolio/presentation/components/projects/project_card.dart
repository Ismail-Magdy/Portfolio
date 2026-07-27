import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ismailmagdy/core/theme/app_colors.dart';
import 'package:ismailmagdy/portfolio/presentation/components/projects/project_details_screen.dart';
import '../../../models/project_model.dart';

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
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ProjectDetailsScreen(project: widget.project),
            ),
          );
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          transform: Matrix4.identity()
            ..scale(_isHovered ? 1.03 : 1.0, _isHovered ? 1.03 : 1.0),
          transformAlignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.backgroundDark,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _isHovered
                  ? AppColors.primary.withValues(alpha: 0.4)
                  : Colors.white.withValues(alpha: 0.06),
              width: 1.5,
            ),
            boxShadow: _isHovered
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
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                      child: Image.asset(
                        widget.project.imageOut,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.fill,
                        alignment: Alignment.topCenter,
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
                // Title + Liquid Glass Arrow
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        const Color(0xFF0D2137),
                        AppColors.backgroundDark,
                      ],
                    ),
                  ),
                  child: Row(
                    children: [
                      //
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
                      //
                      const SizedBox(width: 8),
                      // Liquid glass animated arrow
                      _LiquidGlassArrow(controller: _rippleController),
                      //
                    ],
                  ),
                ),
                //
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// A "liquid glass" pulsing ripple effect around a north_east arrow icon.
/// Renders 3 concentric rings that expand outward and fade, creating
/// an Apple-like soft, continuous glowing glass effect.
class _LiquidGlassArrow extends StatelessWidget {
  final AnimationController controller;

  const _LiquidGlassArrow({required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 36,
      height: 36,
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return CustomPaint(
            painter: _LiquidGlassPainter(
              progress: controller.value,
              color: AppColors.primary,
            ),
            child: child,
          );
        },
        child: const Center(
          child: Icon(Icons.north_east, color: AppColors.primary, size: 18),
        ),
      ),
    );
  }
}

/// Custom painter that draws 3 staggered expanding/fading rings
/// to create the liquid glass ripple effect.
class _LiquidGlassPainter extends CustomPainter {
  final double progress;
  final Color color;

  _LiquidGlassPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = size.width / 2;

    // Draw 3 staggered rings
    for (int i = 0; i < 3; i++) {
      final ringProgress = (progress + i * 0.33) % 1.0;

      // Ease the progress for smoother feel
      final easedProgress = Curves.easeOut.transform(ringProgress);

      final radius = maxRadius * 0.4 + (maxRadius * 0.6 * easedProgress);

      // Fade out as the ring expands
      final opacity = (1.0 - easedProgress) * 0.35;

      if (opacity > 0.01) {
        // Glass-like gradient stroke
        final paint = Paint()
          ..color = color.withValues(alpha: opacity)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5 * (1.0 - easedProgress * 0.5);

        canvas.drawCircle(center, radius, paint);

        // Inner glow fill (very subtle)
        final glowPaint = Paint()
          ..color = color.withValues(alpha: opacity * 0.15)
          ..style = PaintingStyle.fill;

        canvas.drawCircle(center, radius, glowPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _LiquidGlassPainter oldDelegate) =>
      progress != oldDelegate.progress;
}
