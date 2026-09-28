import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ismailmagdy/core/constants/app_strings.dart';
import 'package:ismailmagdy/core/theme/app_colors.dart';
import 'package:ismailmagdy/portfolio/presentation/components/skills/skill_chip.dart';
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

  /// Returns an IconData for each skill name
  IconData _getSkillIcon(String name) {
    switch (name.toLowerCase()) {
      case "flutter":
        return Icons.flutter_dash;
      case "dart":
        return Icons.code;
      case "state management":
        return Icons.account_tree;
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
      case "supabase":
        return Icons.cloud;
      case "git":
        return Icons.merge_type;
      case "github":
        return Icons.hub;
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

  /// Returns a proficiency level (0.0 – 1.0) for each skill.
  double _getSkillLevel(String name) {
    switch (name.toLowerCase()) {
      case "flutter":
        return 0.92;
      case "dart":
        return 0.90;
      case "state management":
        return 0.85;
      case "clean architecture":
        return 0.80;
      case "solid":
        return 0.82;
      case "mvvm":
        return 0.78;
      case "rest apis":
        return 0.88;
      case "firebase":
        return 0.85;
      case "sqlite":
        return 0.70;
      case "supabase":
        return 0.65;
      case "git":
        return 0.88;
      case "github":
        return 0.85;
      case "java":
        return 0.60;
      case "c++":
        return 0.55;
      case "python":
        return 0.58;
      default:
        return 0.50;
    }
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
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 20 : 80,
          vertical: 80,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //
                Text(
                  AppStrings.skillsTitle,
                  style: GoogleFonts.poppins(
                    fontSize: isMobile ? 28 : 32,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
                //
                const SizedBox(height: 50),
                //
                // Category groups
                ...grouped.entries.map((entry) {
                  return _buildCategoryGroup(
                    entry.key,
                    entry.value,
                    allSkills.indexOf(entry.value.first),
                    isMobile,
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

  Widget _buildCategoryGroup(
    String category,
    List skills,
    int startIndex,
    bool isMobile,
  ) {
    final cardWidth = isMobile ? 160.0 : 220.0;

    return Padding(
      padding: const EdgeInsets.only(bottom: 36),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //
          // Category label
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Text(
              category,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textDark.withValues(alpha: 0.45),
                letterSpacing: 1.5,
              ),
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
                  icon: _getSkillIcon(skill.name),
                  level: _getSkillLevel(skill.name),
                  index: globalIndex,
                  isVisible: _isVisible,
                  entranceController: _entranceController,
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
