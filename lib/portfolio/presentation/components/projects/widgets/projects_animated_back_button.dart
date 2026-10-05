import 'package:flutter/material.dart';
import 'package:ismailmagdy/core/theme/app_colors.dart';

class ProjectsAnimatedBackButton extends StatelessWidget {
  const ProjectsAnimatedBackButton({
    super.key,
    required this.backArrowAnimation,
  });

  final Animation<double> backArrowAnimation;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Container(
        width: 52,
        height: 52,
        decoration: BoxDecoration(
          shape: .circle,
          color: Colors.white.withValues(alpha: 0.08),
          border: .all(
            color: AppColors.primary.withValues(alpha: 0.35),
            width: 1.5,
          ),
        ),
        child: AnimatedBuilder(
          animation: backArrowAnimation,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(backArrowAnimation.value, 0),
              child: child,
            );
          },
          child: const Icon(
            Icons.keyboard_double_arrow_left,
            color: AppColors.primary,
            size: 26,
          ),
        ),
      ),
    );
  }
}
