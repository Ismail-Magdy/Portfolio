import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ismailmagdy/core/theme/app_colors.dart';
import 'package:ismailmagdy/portfolio/presentation/components/skills/components/skill_chip.dart';
import 'package:ismailmagdy/portfolio/presentation/components/skills/functions/skills_functions.dart';

class SkillsCategoryGroup extends StatelessWidget {
  const SkillsCategoryGroup({
    super.key,
    required this.category,
    required this.skills,
    required this.startIndex,
    required this.isMobile,
    required this.entranceController,
    required this.isVisible,
    required this.cardWidth,
  });

  final String category;
  final List skills;
  final int startIndex;
  final bool isMobile;
  final AnimationController entranceController;
  final bool isVisible;
  final double cardWidth;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const .only(bottom: 36),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          // Category label
          Padding(
            padding: const .only(bottom: 16),
            child: Builder(
              builder: (context) {
                return Text(
                  category,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: .w600,
                    color: AppColors.textDark.withValues(alpha: 0.45),
                    letterSpacing: 1.5,
                  ),
                );
              },
            ),
          ),
          //
          // Grid of skill cards
          Wrap(
            spacing: 14,
            runSpacing: 14,
            children: skills.asMap().entries.map((entry) {
              final globalIndex = startIndex + entry.key;
              final skill = entry.value;
              return SizedBox(
                width: cardWidth,
                child: SkillCard(
                  skill: skill,
                  icon: getSkillIcon(skill.name),
                  level: getSkillLevel(skill.name),
                  index: globalIndex,
                  isVisible: isVisible,
                  entranceController: entranceController,
                ),
              );
            }).toList(),
          ),
          //
        ],
      ),
    );
  }
}
