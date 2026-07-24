import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ismailmagdy/core/theme/app_colors.dart';
import 'package:ismailmagdy/features/portfolio/data/repositories/skills_repository.dart';
import 'package:ismailmagdy/features/portfolio/domain/models/skill_model.dart';
import 'package:ismailmagdy/features/portfolio/presentation/components/skills/widgets/bento_category_card.dart';

class AllSkillsModal extends StatelessWidget {
  const AllSkillsModal({super.key});

  @override
  Widget build(BuildContext context) {
    final skills = SkillsRepository().getSkills();

    // Group skills strictly dynamically by extracting the category
    final Map<String, List<SkillModel>> grouped = {};
    for (var skill in skills) {
      grouped.putIfAbsent(skill.category, () => []).add(skill);
    }

    // Vibrant array of colors to dynamically map to the unknown categories
    final accentColors = [
      AppColors.primaryRedesign,
      const Color(0xFF00BCD4),
      const Color(0xFF7C4DFF),
      const Color(0xFFFF6D00),
      const Color(0xFF00E676),
      const Color(0xFFE91E63),
    ];

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          children: [
            // ── Header ──
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Text(
                    "All Skills",
                    style: GoogleFonts.poppins(
                      fontSize: 32,
                      fontWeight: .bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      padding: const .all(8),
                      decoration: BoxDecoration(
                        shape: .circle,
                        color: AppColors.textDark.withValues(alpha: 0.1),
                      ),
                      child: Icon(
                        Icons.close_rounded,
                        color: AppColors.textDark,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ── Dynamic Bento Grid ──
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 10,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 800),
                    child: Wrap(
                      spacing: 20,
                      runSpacing: 20,
                      alignment: .center,
                      children: grouped.entries.toList().asMap().entries.map((
                        entry,
                      ) {
                        final index = entry.key;
                        final category = entry.value.key;
                        final categorySkills = entry.value.value;
                        final accent =
                            accentColors[index % accentColors.length];

                        return BentoCategoryCard(
                          category: category,
                          skills: categorySkills,
                          accent: accent,
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

void showAllSkillsModal(BuildContext context) {
  showGeneralDialog(
    context: context,
    pageBuilder: (context, anim1, anim2) {
      return const AllSkillsModal();
    },
    barrierDismissible: true,
    barrierLabel: "Close All Skills",
    barrierColor: Colors.black.withValues(alpha: 0.4),
    transitionDuration: const Duration(milliseconds: 350),
    transitionBuilder: (context, anim1, anim2, child) {
      return FadeTransition(
        opacity: anim1,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
          child: child,
        ),
      );
    },
  );
}
