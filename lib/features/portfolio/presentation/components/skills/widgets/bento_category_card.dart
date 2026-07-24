import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../domain/models/skill_model.dart';

class BentoCategoryCard extends StatelessWidget {
  final String category;
  final List<SkillModel> skills;
  final Color accent;

  const BentoCategoryCard({
    super.key,
    required this.category,
    required this.skills,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      padding: const .all(24),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: .circular(24),
        border: .all(color: accent.withValues(alpha: 0.3), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: accent.withValues(alpha: 0.05),
            blurRadius: 15,
            spreadRadius: 2,
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          // Row for category text + small accent decoration
          Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(shape: .circle, color: accent),
              ),
              const SizedBox(width: 10),
              Text(
                category,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: .bold,
                  color: AppColors.textDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: skills.map((skill) {
              return Container(
                padding: const .symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: .circular(10),
                  color: accent.withValues(alpha: 0.1),
                  border: .all(color: accent.withValues(alpha: 0.5)),
                ),
                child: Text(
                  skill.name,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: .w500,
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
//