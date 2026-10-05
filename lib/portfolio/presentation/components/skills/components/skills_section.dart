import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ismailmagdy/core/constants/app_strings.dart';
import 'package:ismailmagdy/core/theme/app_colors.dart';
import 'package:ismailmagdy/portfolio/presentation/components/skills/components/skills_category_group.dart';
import 'package:ismailmagdy/portfolio/repositories/skills/skills_repository.dart';
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

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final allSkills = SkillsRepository().getSkills();

    // Group skills by category
    final Map<String, List<dynamic>> grouped = {};
    for (final skill in allSkills) {
      grouped.putIfAbsent(skill.category, () => []).add(skill);
    }

    return VisibilityDetector(
      key: const Key("skills-section-visibility"),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.15 && !_isVisible) {
          setState(() => _isVisible = true);
          _entranceController.forward();
        }
      },
      child: Padding(
        padding: .symmetric(horizontal: isMobile ? 20 : 80, vertical: 80),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Column(
              crossAxisAlignment: .center,
              children: [
                //
                Text(
                  AppStrings.skillsTitle,
                  style: GoogleFonts.poppins(
                    fontSize: isMobile ? 28 : 32,
                    fontWeight: .bold,
                    color: AppColors.textDark,
                  ),
                ),
                //
                const SizedBox(height: 50),
                //
                // Category groups
                ...grouped.entries.map((entry) {
                  return SkillsCategoryGroup(
                    cardWidth: isMobile ? 160.0 : 220.0,
                    category: entry.key,
                    entranceController: _entranceController,
                    isMobile: isMobile,
                    isVisible: _isVisible,
                    skills: entry.value,
                    startIndex: allSkills.indexOf(entry.value.first),
                  );
                }),
                //
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// 231
