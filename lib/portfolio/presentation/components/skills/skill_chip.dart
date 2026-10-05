import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ismailmagdy/core/theme/app_colors.dart';
import 'package:ismailmagdy/portfolio/models/skills/skill_model.dart';
class SkillCard extends StatefulWidget {
  final SkillModel skill;
  final IconData icon;
  final double level;
  final int index;
  final bool isVisible;
  final AnimationController entranceController;

  const SkillCard({
    super.key,
    required this.skill,
    required this.icon,
    required this.level,
    required this.index,
    required this.isVisible,
    required this.entranceController,
  });

  @override
  State<SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<SkillCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final totalSkills = 15;
    final staggerFraction = widget.index / totalSkills;
    final startDelay = staggerFraction * 0.5;
    final endDelay = startDelay + 0.5;

    return AnimatedBuilder(
      animation: widget.entranceController,
      builder: (context, child) {
        final progress =
            ((widget.entranceController.value - startDelay) /
                    (endDelay - startDelay))
                .clamp(0.0, 1.0);
        final curvedProgress = Curves.easeOutCubic.transform(progress);
        final opacityProgress = Curves.easeOut.transform(progress);

        return Opacity(
          opacity: opacityProgress,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - curvedProgress)),
            child: child,
          ),
        );
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          transform: Matrix4.diagonal3Values(
            _isHovered ? 1.02 : 1.0,
            _isHovered ? 1.02 : 1.0,
            1.0,
          ),
          transformAlignment: Alignment.center,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: AppColors.cardBackgroundDark,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _isHovered
                  ? AppColors.primary.withValues(alpha: 0.4)
                  : AppColors.primary.withValues(alpha: 0.08),
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              //
              Row(
                children: [
                  //
                  Icon(
                    widget.icon,
                    size: 20,
                    color: _isHovered
                        ? AppColors.primary
                        : AppColors.primary.withValues(alpha: 0.6),
                  ),
                  //
                  const SizedBox(width: 12),
                  //
                  Expanded(
                    child: Text(
                      widget.skill.name,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textDark.withValues(alpha: 0.9),
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),
                  //
                ],
              ),
              //
              const SizedBox(height: 12),
              //
              // Thin progress bar
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: 3,
                  child: LinearProgressIndicator(
                    value: widget.level,
                    backgroundColor: AppColors.primary.withValues(alpha: 0.08),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      _isHovered
                          ? AppColors.primary
                          : AppColors.primary.withValues(alpha: 0.45),
                    ),
                  ),
                ),
              ),
              //
            ],
          ),
        ),
      ),
    );
  }
}
