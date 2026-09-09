import 'package:flutter/material.dart';
import 'package:ismailmagdy/core/theme/app_colors.dart';
import 'package:ismailmagdy/portfolio/presentation/components/projects/widgets/liquid_glass_painter.dart';

class LiquidGlassArrow extends StatelessWidget {
  final AnimationController controller;

  const LiquidGlassArrow({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: SizedBox(
        width: 36,
        height: 36,
        child: AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return CustomPaint(
              painter: LiquidGlassPainter(
                progress: controller.value,
                color: AppColors.primary,
              ),
              child: child,
            );
          },
          child: const Center(
            child: Icon(Icons.north_east, color: AppColors.primary, size: 18),
          ),
        ),
      ),
    );
  }
}
