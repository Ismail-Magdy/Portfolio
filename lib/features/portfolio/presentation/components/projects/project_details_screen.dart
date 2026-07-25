import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ismailmagdy/core/constants/app_images.dart';
import 'package:ismailmagdy/core/constants/app_strings.dart';
import 'package:ismailmagdy/core/helpers/spacing.dart';
import 'package:ismailmagdy/core/theme/app_colors.dart';
import 'package:ismailmagdy/features/portfolio/domain/models/project_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ismailmagdy/features/portfolio/presentation/components/projects/github_button.dart';
import '../background/animated_background.dart';

class ProjectDetailsScreen extends StatefulWidget {
  final ProjectModel project;

  const ProjectDetailsScreen({super.key, required this.project});

  @override
  State<ProjectDetailsScreen> createState() => _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState extends State<ProjectDetailsScreen>
    with TickerProviderStateMixin {
  late AnimationController _ringController;
  late AnimationController _backArrowController;
  late Animation<double> _backArrowAnimation;

  @override
  void initState() {
    super.initState();
    _ringController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat();

    _backArrowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);

    _backArrowAnimation = Tween<double>(begin: 0.0, end: -6.0).animate(
      CurvedAnimation(parent: _backArrowController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _ringController.dispose();
    _backArrowController.dispose();
    super.dispose();
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  String _getProjectImagePath(String projectTitle) {
    switch (projectTitle.toLowerCase()) {
      case AppStrings.mealMonkey:
        return AppImages.mealMonkeyImage;
      case AppStrings.bookShop:
        return AppImages.bookShopImage;
      case AppStrings.portfolioWebsite:
        return AppImages.portfolioImage;
      case AppStrings.joby:
        return AppImages.jobyImage;
      default:
        return AppImages.bookShopImage;
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
          // Full-screen background — covers everything
          const Positioned.fill(child: AnimatedBackground()),
          // Scrollable content
          SizedBox(
            width: screenWidth,
            height: screenHeight,
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: screenHeight),
                child: SafeArea(
                  child: Column(
                    children: [
                      // Custom back button row
                      Padding(
                        padding: EdgeInsets.only(
                          left: isMobile ? 16 : 32,
                          top: 16,
                          right: 16,
                        ),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: _buildAnimatedBackButton(),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Main content
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: isMobile ? 20 : 40,
                        ),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 1200),
                            child: isMobile
                                ? _buildMobileLayout()
                                : _buildDesktopLayout(),
                          ),
                        ),
                      ),
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

  /// Animated circular back button with sliding double-left arrows.
  Widget _buildAnimatedBackButton() {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Container(
        width: 52,
        height: 52,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withValues(alpha: 0.08),
          border: Border.all(
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

  /// Desktop/Tablet: image left (35%), details right (65%)
  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left — Image with rotating ring
        Expanded(flex: 35, child: _buildImageWithRing()),
        const SizedBox(width: 60),
        // Right — Details
        Expanded(flex: 65, child: _buildDetailsContent()),
      ],
    );
  }

  /// Mobile: image on top, details below
  Widget _buildMobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(child: _buildImageWithRing(maxSize: 300)),
        const SizedBox(height: 40),
        _buildDetailsContent(),
      ],
    );
  }

  /// The project image with rounded corners, a glowing shadow, and
  /// a continuously rotating dashed ring decoration.
  Widget _buildImageWithRing({double? maxSize}) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final imageSize = maxSize ?? constraints.maxWidth;
        return SizedBox(
          width: imageSize,
          height: imageSize,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Rotating dashed ring
              AnimatedBuilder(
                animation: _ringController,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _ringController.value * 2 * pi,
                    child: CustomPaint(
                      size: Size(imageSize, imageSize),
                      painter: _DashedRingPainter(
                        color: AppColors.primary.withValues(alpha: 0.35),
                        strokeWidth: 2.0,
                        dashCount: 20,
                        gapRatio: 0.5,
                      ),
                    ),
                  );
                },
              ),
              // Glowing shadow + image
              Container(
                width: imageSize * 0.85,
                height: imageSize * 0.85,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.15),
                      blurRadius: 30,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Hero(
                  tag: widget.project.title,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      _getProjectImagePath(widget.project.title),
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
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
            ],
          ),
        );
      },
    );
  }

  /// All project details: title, tech stack, description, action buttons.
  Widget _buildDetailsContent() {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Text(
          widget.project.title,
          style: GoogleFonts.poppins(
            fontSize: isMobile ? 28 : 40,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        verticalSpace(20),
        // Tech Stack
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: widget.project.techStack
              .map(
                (tech) => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Text(
                    tech,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
        verticalSpace(32),
        // Description
        Text(
          widget.project.description,
          style: GoogleFonts.poppins(
            fontSize: 15,
            height: 1.8,
            color: AppColors.textDark.withValues(alpha: 0.8),
          ),
        ),
        verticalSpace(48),
        // Action Buttons
        Wrap(
          spacing: 16,
          runSpacing: 12,
          children: [
            SizedBox(
              width: 180,
              child: GithubButton(
                onPressed: () => _launchUrl(widget.project.githubUrl),
              ),
            ),
            if (widget.project.liveDemoUrl != null)
              SizedBox(
                width: 180,
                child: ElevatedButton.icon(
                  onPressed: () => _launchUrl(widget.project.liveDemoUrl!),
                  icon: const FaIcon(FontAwesomeIcons.globe, size: 16),
                  label: const Text(AppStrings.liveDemo),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
          ],
        ),
        verticalSpace(40),
      ],
    );
  }
}

/// Custom painter that draws a dashed ring (circle outline with gaps).
class _DashedRingPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final int dashCount;
  final double gapRatio;

  _DashedRingPainter({
    required this.color,
    required this.strokeWidth,
    required this.dashCount,
    required this.gapRatio,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) - strokeWidth;

    final totalAngle = 2 * pi;
    final dashAngle = totalAngle / dashCount;
    final arcAngle = dashAngle * (1 - gapRatio);

    for (int i = 0; i < dashCount; i++) {
      final startAngle = i * dashAngle;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        arcAngle,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _DashedRingPainter oldDelegate) =>
      color != oldDelegate.color ||
      strokeWidth != oldDelegate.strokeWidth ||
      dashCount != oldDelegate.dashCount ||
      gapRatio != oldDelegate.gapRatio;
}
