import 'package:flutter/material.dart';
import 'package:ismailmagdy/core/animations/background/animated_background.dart';
import 'package:ismailmagdy/core/helpers/spacing.dart';
import 'package:ismailmagdy/core/theme/app_colors.dart';
import 'package:ismailmagdy/portfolio/models/projects/project_model.dart';
import 'package:ismailmagdy/portfolio/presentation/components/projects/widgets/projects_animated_back_button.dart';
import 'package:ismailmagdy/portfolio/presentation/components/projects/widgets/projects_vertical_layout.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ProjectDetailsScreenContent extends StatelessWidget {
  const ProjectDetailsScreenContent({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    required this.isMobile,
    required this.backArrowAnimation,
    required this.project,
    required this.borderGlowController,
    required this.fadeAnimation,
    required this.slideAnimation,
    required this.chipStaggerController,
    this.onVisibilityChanged,
    required this.teamStaggerController,
  });

  final double screenWidth;
  final double screenHeight;
  final bool isMobile;
  //
  final Animation<double> backArrowAnimation;
  final ProjectModel project;
  final AnimationController borderGlowController;
  final Animation<double> fadeAnimation;
  final Animation<Offset> slideAnimation;
  final AnimationController chipStaggerController;
  final void Function(VisibilityInfo)? onVisibilityChanged;
  final AnimationController teamStaggerController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: Stack(
        children: [
          const Positioned.fill(child: AnimatedBackground()),
          SizedBox(
            width: screenWidth,
            height: screenHeight,
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: screenHeight),
                child: SafeArea(
                  child: Column(
                    children: [
                      // Back button
                      Padding(
                        padding: .only(
                          left: isMobile ? 16 : 32,
                          top: 16,
                          right: 16,
                        ),
                        child: Align(
                          alignment: .topLeft,
                          child: ProjectsAnimatedBackButton(
                            backArrowAnimation: backArrowAnimation,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Main centered content
                      Padding(
                        padding: .symmetric(horizontal: isMobile ? 20 : 40),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 1100),
                            child: ProjectsVerticalLayout(
                              isMobile: isMobile,
                              borderGlowController: borderGlowController,
                              chipStaggerController: chipStaggerController,
                              fadeAnimation: fadeAnimation,
                              project: project,
                              slideAnimation: slideAnimation,
                              teamStaggerController: teamStaggerController,
                              onVisibilityChanged: onVisibilityChanged,
                            ),
                          ),
                        ),
                      ),
                      verticalSpace(60),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
