import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ismailmagdy/core/helpers/spacing.dart';
import 'package:ismailmagdy/core/theme/app_colors.dart';
import 'package:ismailmagdy/portfolio/models/package_model.dart';
import 'package:url_launcher/url_launcher.dart';
import '../background/animated_background.dart';

class PackageDetailsScreen extends StatefulWidget {
  final PackageModel package;

  const PackageDetailsScreen({super.key, required this.package});

  @override
  State<PackageDetailsScreen> createState() => _PackageDetailsScreenState();
}

class _PackageDetailsScreenState extends State<PackageDetailsScreen>
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

    _backArrowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
    _backArrowAnimation = Tween<double>(begin: 0.0, end: -6.0).animate(
      CurvedAnimation(parent: _backArrowController, curve: Curves.easeInOut),
    );

    _fadeSlideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeSlideController,
      curve: Curves.easeOut,
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.15), end: Offset.zero).animate(
          CurvedAnimation(parent: _fadeSlideController, curve: Curves.easeOut),
        );

    _chipStaggerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _borderGlowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();

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
      await launchUrl(uri, mode: LaunchMode.externalApplication);
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
                      //
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
                      //
                      const SizedBox(height: 24),
                      //
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: isMobile ? 20 : 40,
                        ),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 1100),
                            child: _buildVerticalLayout(isMobile),
                          ),
                        ),
                      ),
                      //
                      verticalSpace(60),
                      //
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

  Widget _buildVerticalLayout(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //
        verticalSpace(24),
        //
        Text(
          widget.package.title,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: isMobile ? 32 : 48,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
            height: 1.2,
          ),
        ),
        //
        verticalSpace(40),
        //
        _buildWideGif(isMobile),
        //
        verticalSpace(48),
        //
        _buildActionButtons(isMobile),
        //
        verticalSpace(48),
        //
        isMobile ? _buildMobileTwoSection() : _buildDesktopTwoColumn(),
        verticalSpace(48),
        //
      ],
    );
  }

  Widget _buildWideGif(bool isMobile) {
    const double borderPad = 4.0;
    const double borderRadius = 20.0;

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 600),
      child: AnimatedBuilder(
        animation: _borderGlowController,
        builder: (context, child) {
          return CustomPaint(
            foregroundPainter: _SweepBorderPainter(
              progress: _borderGlowController.value,
              borderRadius: borderRadius + borderPad,
              padding: borderPad,
              glowColor: AppColors.primary,
            ),
            child: child,
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(borderPad),
          child: Hero(
            tag: widget.package.title,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
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
                borderRadius: BorderRadius.circular(borderRadius),
                child: Image.asset(
                  widget.package.imageIn,
                  fit: BoxFit.contain,
                  width: double.infinity,
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
    );
  }

  Widget _buildDesktopTwoColumn() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 50, child: _buildAnimatedFeatures()),
        const SizedBox(width: 48),
        Expanded(flex: 50, child: _buildAnimatedCodeSnippets()),
      ],
    );
  }

  Widget _buildMobileTwoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildAnimatedFeatures(),
        verticalSpace(48),
        _buildAnimatedCodeSnippets(),
      ],
    );
  }

  Widget _buildAnimatedFeatures() {
    final features = widget.package.features;
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 4,
                  height: 24,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  "Features",
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDark,
                  ),
                ),
              ],
            ),
            verticalSpace(24),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(features.length, (index) {
                final intervalStart = index / (features.length + 1);
                final intervalEnd = (index + 1) / (features.length + 1);
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
                    return Transform.translate(
                      offset: Offset(50 * (1 - chipAnimation.value), 0),
                      child: Opacity(
                        opacity: chipAnimation.value.clamp(0.0, 1.0),
                        child: child,
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.check_circle_outline,
                          color: Colors.cyan,
                          size: 24,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            features[index],
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: AppColors.textDark.withValues(alpha: 0.8),
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedCodeSnippets() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 4,
                  height: 24,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  "Installation & Usage",
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDark,
                  ),
                ),
              ],
            ),
            verticalSpace(24),
            _buildCodeSnippet(
              title: "Installation",
              code: widget.package.installation,
            ),
            verticalSpace(24),
            _buildCodeSnippet(title: "Usage", code: widget.package.usage),
          ],
        ),
      ),
    );
  }

  Widget _buildCodeSnippet({required String title, required String code}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.textDark.withValues(alpha: 0.9),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E1E),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.copy, color: Colors.white54, size: 20),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: code));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Copied to clipboard!',
                        style: GoogleFonts.poppins(),
                      ),
                      backgroundColor: AppColors.primary,
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
                tooltip: 'Copy to clipboard',
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    code,
                    style: GoogleFonts.firaCode(
                      fontSize: 14,
                      color: const Color(0xFFD4D4D4),
                      height: 1.5,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(bool isMobile) {
    final List<Widget> buttons = [];

    buttons.add(
      _buildActionButton(
        icon: Icons.open_in_new,
        label: "View on Pub.dev",
        url: widget.package.pubDevUrl,
        isPrimary: true,
      ),
    );

    buttons.add(
      _buildActionButton(
        icon: FontAwesomeIcons.github,
        label: "GitHub",
        url: widget.package.githubUrl,
        isPrimary: false,
      ),
    );

    return Wrap(
      spacing: 14,
      runSpacing: 12,
      alignment: WrapAlignment.center,
      children: buttons,
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required String url,
    bool isPrimary = false,
  }) {
    return _HoverActionButton(
      icon: icon,
      label: label,
      url: url,
      isPrimary: isPrimary,
      onTap: () => _launchUrl(url),
    );
  }
}

class _HoverActionButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final String url;
  final bool isPrimary;
  final VoidCallback onTap;

  const _HoverActionButton({
    required this.icon,
    required this.label,
    required this.url,
    required this.isPrimary,
    required this.onTap,
  });

  @override
  State<_HoverActionButton> createState() => _HoverActionButtonState();
}

class _HoverActionButtonState extends State<_HoverActionButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final baseColor = AppColors.primary;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          transform: Matrix4.identity()
            ..scale(_isHovered ? 1.05 : 1.0, _isHovered ? 1.05 : 1.0),
          transformAlignment: Alignment.center,
          decoration: BoxDecoration(
            color: _isHovered
                ? (widget.isPrimary
                      ? baseColor.withValues(alpha: 0.15)
                      : AppColors.textDark.withValues(alpha: 0.1))
                : Colors.transparent,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: _isHovered
                  ? (widget.isPrimary
                        ? baseColor.withValues(alpha: 0.6)
                        : AppColors.textDark.withValues(alpha: 0.5))
                  : (widget.isPrimary
                        ? AppColors.primary.withValues(alpha: 0.35)
                        : AppColors.textDark.withValues(alpha: 0.3)),
              width: 1.5,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: baseColor.withValues(alpha: 0.2),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                size: 16,
                color: widget.isPrimary
                    ? AppColors.primary
                    : AppColors.textDark,
              ),
              const SizedBox(width: 10),
              Text(
                widget.label,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: widget.isPrimary
                      ? AppColors.primary
                      : AppColors.textDark,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SweepBorderPainter extends CustomPainter {
  final double progress;
  final double borderRadius;
  final double padding;
  final Color glowColor;

  _SweepBorderPainter({
    required this.progress,
    required this.borderRadius,
    required this.padding,
    required this.glowColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(borderRadius));
    final angle = progress * 2 * pi;

    final sweepShader = SweepGradient(
      center: Alignment.center,
      startAngle: angle,
      endAngle: angle + 2 * pi,
      colors: [
        glowColor.withValues(alpha: 0.0),
        glowColor.withValues(alpha: 0.0),
        glowColor.withValues(alpha: 0.6),
        glowColor.withValues(alpha: 0.9),
        glowColor.withValues(alpha: 0.6),
        glowColor.withValues(alpha: 0.0),
        glowColor.withValues(alpha: 0.0),
      ],
      stops: const [0.0, 0.3, 0.42, 0.5, 0.58, 0.7, 1.0],
      tileMode: TileMode.clamp,
    ).createShader(rect);

    final borderPaint = Paint()
      ..shader = sweepShader
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;

    canvas.drawRRect(rrect, borderPaint);

    final glowPaint = Paint()
      ..shader = sweepShader
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);

    final glowRRect = RRect.fromRectAndRadius(
      rect.inflate(2),
      Radius.circular(borderRadius + 2),
    );
    canvas.drawRRect(glowRRect, glowPaint);

    final basePaint = Paint()
      ..color = glowColor.withValues(alpha: 0.12)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    canvas.drawRRect(rrect, basePaint);

    final dotPaint = Paint()
      ..color = glowColor.withValues(alpha: 0.4)
      ..style = PaintingStyle.fill;

    final dotRadius = 2.5;
    final inset = borderRadius * 0.3;
    final corners = [
      Offset(inset, inset),
      Offset(size.width - inset, inset),
      Offset(inset, size.height - inset),
      Offset(size.width - inset, size.height - inset),
    ];

    for (final corner in corners) {
      canvas.drawCircle(corner, dotRadius, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _SweepBorderPainter oldDelegate) =>
      progress != oldDelegate.progress;
}
