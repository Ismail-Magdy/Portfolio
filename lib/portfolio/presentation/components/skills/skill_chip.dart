import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ismailmagdy/core/theme/app_colors.dart';
import 'package:ismailmagdy/portfolio/models/skills/skill_model.dart';

/// A single premium skill chip with staggered entrance and hover effect.
class SkillChip extends StatefulWidget {
  final SkillModel skill;
  final int index;
  final int totalSkills;
  final bool isVisible;
  final AnimationController entranceController;
  final IconData icon;

  const SkillChip({
    super.key,
    required this.skill,
    required this.index,
    required this.totalSkills,
    required this.isVisible,
    required this.entranceController,
    required this.icon,
  });

  @override
  State<SkillChip> createState() => SkillChipState();
}

class SkillChipState extends State<SkillChip> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    // Staggered entrance timing
    final staggerFraction = widget.index / widget.totalSkills;
    final startDelay = staggerFraction * 0.5; // first 50% of the animation
    final endDelay = startDelay + 0.5;

    return AnimatedBuilder(
      animation: widget.entranceController,
      builder: (context, child) {
        final progress =
            ((widget.entranceController.value - startDelay) /
                    (endDelay - startDelay))
                .clamp(0.0, 1.0);
        final curvedProgress = Curves.easeOutBack.transform(progress);
        final opacityProgress = Curves.easeOut.transform(progress);

        return Opacity(
          opacity: opacityProgress,
          child: Transform.scale(
            scale: 0.5 + (curvedProgress * 0.5),
            child: child,
          ),
        );
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
          transform: Matrix4.identity()..scale(_isHovered ? 1.08 : 1.0),
          transformAlignment: .center,
          child: ClipRRect(
            borderRadius: .circular(14),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                padding: const .symmetric(horizontal: 22, vertical: 14),
                decoration: BoxDecoration(
                  color: _isHovered
                      ? AppColors.primary.withValues(alpha: 0.12)
                      : Colors.white.withValues(alpha: 0.05),
                  borderRadius: .circular(14),
                  border: Border.all(
                    color: _isHovered
                        ? AppColors.primary.withValues(alpha: 0.6)
                        : AppColors.primary.withValues(alpha: 0.25),
                    width: 1,
                  ),
                  boxShadow: _isHovered
                      ? [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.2),
                            blurRadius: 20,
                            spreadRadius: 2,
                          ),
                        ]
                      : [],
                ),
                child: Row(
                  mainAxisSize: .min,
                  children: [
                    Icon(
                      widget.icon,
                      size: 18,
                      color: _isHovered
                          ? AppColors.primary
                          : AppColors.primary.withValues(alpha: 0.7),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      widget.skill.name,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: _isHovered
                            ? AppColors.textDark
                            : AppColors.textDark.withValues(alpha: 0.85),
                        letterSpacing: 0.3,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
