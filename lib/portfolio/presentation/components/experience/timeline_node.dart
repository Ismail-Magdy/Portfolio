import 'package:flutter/material.dart';
import 'package:ismailmagdy/core/theme/app_colors.dart';

class TimelineNode extends StatelessWidget {
  const TimelineNode({super.key, this.size = 16});
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.primary,
        shape: BoxShape.circle,
        boxShadow: [
          // Outer glow
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.5),
            blurRadius: 12,
            spreadRadius: 2,
          ),
          // Inner bright ring
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 6,
            spreadRadius: 1,
          ),
        ],
      ),
      // Inner bright core
      child: Center(
        child: Container(
          width: size * 0.45,
          height: size * 0.45,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
