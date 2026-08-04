import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ismailmagdy/core/helpers/spacing.dart';
import 'package:ismailmagdy/core/theme/app_colors.dart';
import 'package:ismailmagdy/portfolio/models/projects/project_model.dart';
import 'package:ismailmagdy/portfolio/presentation/components/projects/widgets/projects_hover_action_button.dart';
import 'package:ismailmagdy/portfolio/presentation/components/projects/widgets/projects_sweep_border_painter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../core/animations/background/animated_background.dart';

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
    super.dispose();
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: .externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isMobile = screenWidth < 768;

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
                          child: _buildAnimatedBackButton(),
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
                            child: _buildVerticalLayout(isMobile),
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

  /// Animated back button with sliding double-left arrows.
  Widget _buildAnimatedBackButton() {
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
          animation: _backArrowAnimation,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(_backArrowAnimation.value, 0),
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

  /// The new vertical layout:
  /// Title → Image → One-liner → Two-column (desc + tech) → Action buttons
  Widget _buildVerticalLayout(bool isMobile) {
    return Column(
      crossAxisAlignment: .center,
      children: [
        // 1. Project Title — centered
        Text(
          widget.project.title,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: isMobile ? 32 : 48,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
            height: 1.2,
          ),
        ),
        verticalSpace(32),

        // 2. Wide imageIn
        _buildWideImage(isMobile),
        verticalSpace(28),

        // 3. One-liner short description
        Text(
          widget.project.shortDescription,
          textAlign: .center,
          style: GoogleFonts.poppins(
            fontSize: isMobile ? 15 : 17,
            color: AppColors.textDark.withValues(alpha: 0.6),
            fontWeight: .w400,
            height: 1.5,
          ),
        ),
        verticalSpace(48),

        // 4. Two-column layout (desktop) or stacked (mobile)
        isMobile ? _buildMobileTwoSection() : _buildDesktopTwoColumn(),
        verticalSpace(48),

        // 5. Action buttons
        _buildActionButtons(isMobile),
      ],
    );
  }

  /// The wide project image with animated glowing border
  Widget _buildWideImage(bool isMobile) {
    const double borderPad = 4.0;
    const double borderRadius = 20.0;

    return RepaintBoundary(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 920),
        child: AnimatedBuilder(
          animation: _borderGlowController,
          builder: (context, child) {
            return CustomPaint(
              foregroundPainter: SweepBorderPainter(
                progress: _borderGlowController.value,
                borderRadius: borderRadius + borderPad,
                padding: borderPad,
                glowColor: AppColors.primary,
              ),
              child: child,
            );
          },
          child: Padding(
            padding: const .all(borderPad),
            child: Hero(
              tag: widget.project.title,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: .circular(borderRadius),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.10),
                      blurRadius: 30,
                      spreadRadius: 2,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: .circular(borderRadius),
                  child: Image.asset(
                    widget.project.imageIn,
                    fit: .contain,
                    width: .infinity,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 300,
                        color: AppColors.primary.withValues(alpha: 0.1),
                        child: const Icon(
                          Icons.image,
                          size: 80,
                          color: AppColors.primary,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Desktop two-column: left = description, right = tech stack
  Widget _buildDesktopTwoColumn() {
    return Row(
      crossAxisAlignment: .start,
      children: [
        // Left — Description with fade-in slide-up
        Expanded(flex: 60, child: _buildAnimatedDescription()),
        const SizedBox(width: 48),
        // Right — Tech stack with staggered chips
        Expanded(flex: 40, child: _buildAnimatedTechStack()),
      ],
    );
  }

  /// Mobile stacked: description then tech stack
  Widget _buildMobileTwoSection() {
    return Column(
      crossAxisAlignment: .start,
      children: [
        _buildAnimatedDescription(),
        verticalSpace(36),
        _buildAnimatedTechStack(),
      ],
    );
  }

  /// Description with fade-in + slide-up entrance animation
  Widget _buildAnimatedDescription() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Column(
          crossAxisAlignment: .start,
          children: [
            // Section heading
            Row(
              children: [
                Container(
                  width: 4,
                  height: 24,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: .circular(2),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  "About This Project",
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: .w600,
                    color: AppColors.textDark,
                  ),
                ),
              ],
            ),
            verticalSpace(20),
            // Long description
            Text(
              widget.project.longDescription,
              style: GoogleFonts.poppins(
                fontSize: 15,
                height: 1.8,
                color: AppColors.textDark.withValues(alpha: 0.75),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Tech stack section with staggered chip animations
  Widget _buildAnimatedTechStack() {
    final chips = widget.project.techStack;
    return Column(
      crossAxisAlignment: .start,
      children: [
        // Section heading
        Row(
          children: [
            Container(
              width: 4,
              height: 24,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: .circular(2),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              "Technologies Used",
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
              ),
            ),
          ],
        ),
        verticalSpace(20),
        // Staggered chips
        Wrap(
          spacing: 10,
          runSpacing: 12,
          children: List.generate(chips.length, (index) {
            // Stagger each chip's appearance
            final intervalStart = index / (chips.length + 1);
            final intervalEnd = (index + 1) / (chips.length + 1);
            final chipAnimation = CurvedAnimation(
              parent: _chipStaggerController,
              curve: Interval(
                intervalStart,
                intervalEnd.clamp(0.0, 1.0),
                curve: Curves.easeOutBack,
              ),
            );

            return AnimatedBuilder(
              animation: chipAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: chipAnimation.value,
                  child: Opacity(
                    opacity: chipAnimation.value.clamp(0.0, 1.0),
                    child: child,
                  ),
                );
              },
              child: Container(
                padding: const .symmetric(horizontal: 18, vertical: 10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary.withValues(alpha: 0.18),
                      AppColors.primary.withValues(alpha: 0.08),
                    ],
                  ),
                  borderRadius: .circular(24),
                  border: .all(color: AppColors.primary.withValues(alpha: 0.3)),
                ),
                child: Text(
                  chips[index],
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: AppColors.primary,
                    fontWeight: .w500,
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  /// Dynamic action buttons — only renders buttons whose URL is non-null
  Widget _buildActionButtons(bool isMobile) {
    final project = widget.project;

    // Build the list of buttons conditionally
    final List<Widget> buttons = [];

    if (project.github != null) {
      buttons.add(
        _buildActionButton(
          icon: FontAwesomeIcons.github,
          label: "GitHub",
          url: project.github!,
          isPrimary: false,
        ),
      );
    }

    if (project.linkedIn != null) {
      buttons.add(
        _buildActionButton(
          icon: FontAwesomeIcons.linkedin,
          label: "LinkedIn",
          url: project.linkedIn!,
          isPrimary: true,
        ),
      );
    }

    if (project.linkedInPartTwo != null) {
      buttons.add(
        _buildActionButton(
          icon: FontAwesomeIcons.linkedin,
          label: "LinkedIn Pt.2",
          url: project.linkedInPartTwo!,
          isPrimary: true,
        ),
      );
    }

    if (project.instagram != null) {
      buttons.add(
        _buildActionButton(
          icon: FontAwesomeIcons.instagram,
          label: "Instagram",
          url: project.instagram!,
          isPrimary: true,
          gradientColors: [
            const Color(0xFFF58529),
            const Color(0xFFDD2A7B),
            const Color(0xFF8134AF),
          ],
        ),
      );
    }

    if (project.tiktok != null) {
      buttons.add(
        _buildActionButton(
          icon: FontAwesomeIcons.tiktok,
          label: "TikTok",
          url: project.tiktok!,
          isPrimary: true,
          gradientColors: [const Color(0xFF00F2EA), const Color(0xFFFF0050)],
        ),
      );
    }

    if (project.websiteLink != null) {
      buttons.add(
        _buildActionButton(
          icon: FontAwesomeIcons.globe,
          label: "Website",
          url: project.websiteLink!,
          isPrimary: true,
        ),
      );
    }

    if (project.figmaLink != null && project.figmaLink!.isNotEmpty) {
      buttons.add(
        _buildActionButton(
          icon: FontAwesomeIcons.figma,
          label: "Figma",
          url: project.figmaLink!,
          isPrimary: true,
        ),
      );
    }

    if (buttons.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        // Divider
        Container(
          width: 60,
          height: 2,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(1),
          ),
        ),
        verticalSpace(32),
        Wrap(
          spacing: 14,
          runSpacing: 12,
          alignment: .center,
          children: buttons,
        ),
      ],
    );
  }

  /// A single stylish action button
  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required String url,
    bool isPrimary = false,
    List<Color>? gradientColors,
  }) {
    return HoverActionButton(
      icon: icon,
      label: label,
      url: url,
      isPrimary: isPrimary,
      gradientColors: gradientColors,
      onTap: () => _launchUrl(url),
    );
  }
}

// 783
