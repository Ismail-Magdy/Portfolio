import 'package:flutter/material.dart';
import 'package:ismailmagdy/core/constants/app_images.dart';
import 'package:ismailmagdy/core/theme/app_colors.dart';
import 'package:ismailmagdy/features/portfolio/presentation/components/hero/portrait_background.dart';

class PortraitContainer extends StatelessWidget {
  const PortraitContainer({super.key});

  @override
  Widget build(BuildContext context) {
    const double containerSize = 520.0;

    return SizedBox(
      width: containerSize,
      height: containerSize,
      child: Stack(
        alignment: .center,
        children: [
          const PortraitBackground(width: containerSize, height: containerSize),

          Container(
            width: containerSize * 0.85,
            height: containerSize * 0.85,
            decoration: BoxDecoration(
              shape: .circle,
              border: .all(
                color: AppColors.primaryRedesign.withValues(alpha: 0.8),
                width: 3,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.backgroundDark.withValues(alpha: 0.5),
                  blurRadius: 30,
                  spreadRadius: 10,
                ),
              ],
            ),
            child: ClipOval(
              child: Image.asset(AppImages.profileImage, fit: .cover),
            ),
          ),
        ],
      ),
    );
  }
}
//59