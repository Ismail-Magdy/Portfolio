import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ismailmagdy/core/constants/app_strings.dart';
import 'package:ismailmagdy/core/theme/app_colors.dart';
import 'package:ismailmagdy/features/portfolio/data/repositories/skills_repository.dart';
import 'package:ismailmagdy/features/portfolio/domain/models/skill_model.dart';
import 'package:visibility_detector/visibility_detector.dart';

class SkillsSection extends StatefulWidget {
  const SkillsSection({super.key});

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection>
    with SingleTickerProviderStateMixin {
  bool _isVisible = false;
  late AnimationController _entranceController;

  @override
  void initState() {
    super.initState();
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
  }

  @override
  void dispose() {
    _entranceController.dispose();
    super.dispose();
  }

  /// Returns an IconData for each skill name.
  IconData _getSkillIcon(String name) {
    switch (name.toLowerCase()) {
      case "flutter":
        return Icons.flutter_dash;
      case "dart":
        return Icons.code;
      case "clean architecture":
        return Icons.architecture;
      case "solid":
        return Icons.verified;
      case "mvvm":
        return Icons.layers;
      case "rest apis":
        return Icons.api;
      case "firebase":
        return Icons.local_fire_department;
      case "sqlite":
        return Icons.storage;
      case "git":
        return Icons.merge_type;
      case "java":
        return Icons.coffee;
      case "c++":
        return Icons.terminal;
      case "python":
        return Icons.data_object;
      default:
        return Icons.star;
    }
  }

  @override
  Widget build(BuildContext context) {
    final allSkills = SkillsRepository().getSkills();

    return VisibilityDetector(
      key: const Key("skills-section-visibility"),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.15 && !_isVisible) {
          setState(() => _isVisible = true);
          _entranceController.forward();
        }
      },
      child: Padding(
        padding: const .symmetric(horizontal: 80, vertical: 80.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Column(
              crossAxisAlignment: .center,
              children: [
                // Section Title
                Text(
                  AppStrings.skillsTitle,
                  style: GoogleFonts.poppins(
                    fontSize: 32,
                    fontWeight: .bold,
                    color: AppColors.textDark,
                  ),
                ),
                //
                const SizedBox(height: 50),
                // Skills Wrap
                Wrap(
                  alignment: .center,
                  spacing: 16,
                  runSpacing: 16,
                  children: allSkills.asMap().entries.map((entry) {
                    final index = entry.key;
                    final skill = entry.value;
                    return _SkillChip(
                      skill: skill,
                      index: index,
                      totalSkills: allSkills.length,
                      isVisible: _isVisible,
                      entranceController: _entranceController,
                      icon: _getSkillIcon(skill.name),
                    );
                  }).toList(),
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

/// A single premium skill chip with staggered entrance and hover effect.
class _SkillChip extends StatefulWidget {
  final SkillModel skill;
  final int index;
  final int totalSkills;
  final bool isVisible;
  final AnimationController entranceController;
  final IconData icon;

  const _SkillChip({
    required this.skill,
    required this.index,
    required this.totalSkills,
    required this.isVisible,
    required this.entranceController,
    required this.icon,
  });

  @override
  State<_SkillChip> createState() => _SkillChipState();
}

class _SkillChipState extends State<_SkillChip> {
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
          transformAlignment: Alignment.center,
          child: ClipRRect(
            borderRadius: .circular(14),
            child: BackdropFilter(
              filter: .blur(sigmaX: 8, sigmaY: 8),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                padding: const .symmetric(horizontal: 22, vertical: 14),
                decoration: BoxDecoration(
                  color: _isHovered
                      ? AppColors.primary.withValues(alpha: 0.12)
                      : Colors.white.withValues(alpha: 0.05),
                  borderRadius: .circular(14),
                  border: .all(
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
                        fontWeight: .w500,
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
