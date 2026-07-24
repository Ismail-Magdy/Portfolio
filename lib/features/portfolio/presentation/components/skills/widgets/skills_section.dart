import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ismailmagdy/core/constants/app_dimensions.dart';
import 'package:ismailmagdy/core/constants/app_strings.dart';
import 'package:ismailmagdy/core/helpers/spacing.dart';
import 'package:ismailmagdy/core/theme/app_colors.dart';
import 'package:ismailmagdy/features/portfolio/data/repositories/skills_repository.dart';
import 'package:ismailmagdy/features/portfolio/domain/models/skill_model.dart';
import 'package:ismailmagdy/features/portfolio/presentation/components/skills/widgets/all_skills_modal.dart';
import 'package:ismailmagdy/features/portfolio/presentation/components/skills/customs/floating_leaves_timeline.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Fetch ONLY the top 5 skills dynamically from the Data Layer
    final List<SkillModel> topSkills = SkillsRepository()
        .getSkills()
        .take(5)
        .toList();

    return Padding(
      padding: const .symmetric(
        horizontal: AppDimensions.sectionPadding,
        vertical: 80.0,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: AppDimensions.maxContentWidth,
          ),
          child: Column(
            crossAxisAlignment: .center,
            children: [
              Text(
                AppStrings.skillsTitle,
                style: GoogleFonts.poppins(
                  fontSize: 32,
                  fontWeight: .bold,
                  color: AppColors.textDark,
                ),
              ),
              verticalSpace(60),

              // Dynamic Floating Leaves Timeline
              FloatingLeavesTimeline(topSkills: topSkills),

              verticalSpace(60),

              // Explore All Skills Modal Trigger
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => showAllSkillsModal(context),
                  child: Container(
                    padding: const .symmetric(horizontal: 32, vertical: 16),
                    decoration: BoxDecoration(
                      borderRadius: .circular(30),
                      gradient: const LinearGradient(
                        colors: [AppColors.primaryRedesign, Color(0xFF00BCD4)],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryRedesign.withValues(
                            alpha: 0.25,
                          ),
                          blurRadius: 15,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Text(
                      "Explore All Skills",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: .w600,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
