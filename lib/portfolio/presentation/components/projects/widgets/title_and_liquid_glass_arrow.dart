import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ismailmagdy/core/theme/app_colors.dart';
import 'package:ismailmagdy/portfolio/models/projects/project_model.dart';
import 'package:ismailmagdy/portfolio/presentation/components/projects/widgets/liquid_glass_arrow.dart';

class TitleAndLiquidGlassArrow extends StatelessWidget {
  const TitleAndLiquidGlassArrow({
    super.key,
    required this.projectTitle,
    required this.project,
    required this.rippleController,
  });

  final String projectTitle;
  final ProjectModel project;
  final AnimationController rippleController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const .symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: .topCenter,
          end: .bottomCenter,
          colors: [const Color(0xFF0D2137), AppColors.backgroundDark],
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              projectTitle,
              style: GoogleFonts.poppins(
                fontSize: 17,
                fontWeight: .w600,
                color: AppColors.textDark,
              ),
              maxLines: 1,
              overflow: .ellipsis,
            ),
          ),
          const SizedBox(width: 8),
          // Liquid glass animated arrow (hide if coming soon)
          if (!project.isComingSoon)
            LiquidGlassArrow(controller: rippleController),
        ],
      ),
    );
  }
}
