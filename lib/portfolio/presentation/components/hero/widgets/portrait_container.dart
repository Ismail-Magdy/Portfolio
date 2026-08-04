import 'dart:math';
import 'package:flutter/material.dart';
import 'package:ismailmagdy/core/constants/app_images.dart';
import 'package:ismailmagdy/core/theme/app_colors.dart';
import 'package:ismailmagdy/portfolio/presentation/components/hero/widgets/portrait_background.dart';

class PortraitContainer extends StatefulWidget {
  const PortraitContainer({super.key});

  @override
  State<PortraitContainer> createState() => _PortraitContainerState();
}

class _PortraitContainerState extends State<PortraitContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _rotationController;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double containerSize = 520.0;
    const double imageSize = containerSize * 0.70; // square image size
    final borderRadius = BorderRadius.circular(20);

    return SizedBox(
      width: containerSize,
      height: containerSize,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // The new tech background with grid and floating squares
          const PortraitBackground(width: containerSize, height: containerSize),

          // 3D Tilt effect on hover
          MouseRegion(
            onEnter: (_) => setState(() => _isHovered = true),
            onExit: (_) => setState(() => _isHovered = false),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateX(_isHovered ? 0.05 : 0)
                ..rotateY(_isHovered ? -0.05 : 0)
                ..scale(_isHovered ? 1.05 : 1.0),
              transformAlignment: FractionalOffset.center,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Rotating glowing border behind the image
                  AnimatedBuilder(
                    animation: _rotationController,
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: _rotationController.value * 2 * pi,
                        //
                        child: Container(
                          width: imageSize + 6,
                          height: imageSize + 6,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            gradient: SweepGradient(
                              colors: [
                                AppColors.primary.withValues(alpha: 0.1),
                                AppColors.primary,
                                AppColors.primary.withValues(alpha: 0.1),
                                AppColors.primary,
                                AppColors.primary.withValues(alpha: 0.1),
                              ],
                              stops: const [0.0, 0.25, 0.5, 0.75, 1.0],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withValues(alpha: 0.4),
                                blurRadius: 30,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                        ),
                        //
                      );
                    },
                  ),

                  // The actual square profile image
                  Container(
                    width: imageSize,
                    height: imageSize,
                    decoration: BoxDecoration(
                      color: AppColors.backgroundDark,
                      borderRadius: borderRadius,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.backgroundDark.withValues(
                            alpha: 0.8,
                          ),
                          blurRadius: 15,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: borderRadius,
                      child: Image.asset(AppImages.profileImage, fit: .cover),
                    ),
                  ),
                  //
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
