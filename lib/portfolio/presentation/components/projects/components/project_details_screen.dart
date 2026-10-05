import 'package:flutter/material.dart';
import 'package:ismailmagdy/portfolio/presentation/components/projects/components/project_details_screen_content.dart';
import 'package:ismailmagdy/portfolio/models/projects/project_model.dart';

class ProjectDetailsScreen extends StatefulWidget {
  final ProjectModel project;

  const ProjectDetailsScreen({super.key, required this.project});

  @override
  State<ProjectDetailsScreen> createState() => _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState extends State<ProjectDetailsScreen>
    with TickerProviderStateMixin {
  late AnimationController _backArrowController;
  late Animation<double> _backArrowAnimation;
  late AnimationController _fadeSlideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late AnimationController _chipStaggerController;
  late AnimationController _borderGlowController;
  late AnimationController _teamStaggerController;
  bool _teamAnimationTriggered = false;

  @override
  void initState() {
    super.initState();

    // Back arrow bounce
    _backArrowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
    //
    _backArrowAnimation = Tween<double>(begin: 0.0, end: -6.0).animate(
      CurvedAnimation(parent: _backArrowController, curve: Curves.easeInOut),
    );

    // Description fade-in + slide-up
    _fadeSlideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    //
    _fadeAnimation = CurvedAnimation(
      parent: _fadeSlideController,
      curve: Curves.easeOut,
    );
    //
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.15), end: Offset.zero).animate(
          CurvedAnimation(parent: _fadeSlideController, curve: Curves.easeOut),
        );

    // Tech chips stagger
    _chipStaggerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    // Rotating border glow
    _borderGlowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();

    // Team member stagger animation
    _teamStaggerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    // Trigger entrance animations after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fadeSlideController.forward();
      _chipStaggerController.forward();
    });
  }

  @override
  void dispose() {
    _backArrowController.dispose();
    _fadeSlideController.dispose();
    _chipStaggerController.dispose();
    _borderGlowController.dispose();
    _teamStaggerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isMobile = screenWidth < 768;

    return ProjectDetailsScreenContent(
      screenWidth: screenWidth,
      screenHeight: screenHeight,
      isMobile: isMobile,
      backArrowAnimation: _backArrowAnimation,
      project: widget.project,
      borderGlowController: _borderGlowController,
      fadeAnimation: _fadeAnimation,
      slideAnimation: _slideAnimation,
      chipStaggerController: _chipStaggerController,
      teamStaggerController: _teamStaggerController,
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.15 && !_teamAnimationTriggered) {
          _teamAnimationTriggered = true;
          _teamStaggerController.forward();
        }
      },
    );
  }
}
// 808
