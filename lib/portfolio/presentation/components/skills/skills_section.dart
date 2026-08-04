import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ismailmagdy/core/constants/app_strings.dart';
import 'package:ismailmagdy/core/theme/app_colors.dart';
import 'package:ismailmagdy/portfolio/presentation/components/skills/skill_chip.dart';
import 'package:ismailmagdy/portfolio/repositories/skills_repository.dart';
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
                    return SkillChip(
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
