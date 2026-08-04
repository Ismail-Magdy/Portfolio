import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ismailmagdy/portfolio/models/packages/package_model.dart';
import 'package:ismailmagdy/portfolio/models/packages/padge_data_model.dart';
import 'package:ismailmagdy/portfolio/presentation/components/open_source/components/package_details_screen.dart';
import 'package:ismailmagdy/portfolio/presentation/components/open_source/widgets/animated_gradient_border_painter.dart';
import 'package:ismailmagdy/portfolio/presentation/components/open_source/widgets/neon_pill_button.dart';
import 'package:url_launcher/url_launcher.dart';

class PackageCard extends StatefulWidget {
  final PackageModel package;

  const PackageCard({super.key, required this.package});

  @override
  State<PackageCard> createState() => _PackageCardState();
}

class _PackageCardState extends State<PackageCard>
    with TickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _borderGlowController;
  late AnimationController _hoverController;
  late Animation<double> _hoverScaleAnimation;
  late Animation<double> _imageZoomAnimation;

  // Card dark background color & used for the ShaderMask fade target
  static const _cardDarkColor = Color(0xFF0B1120);
  static const _cardSurfaceColor = Color(0xFF111B2E);

  @override
  void initState() {
    super.initState();

    _borderGlowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _hoverController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _hoverScaleAnimation = Tween<double>(begin: 1.0, end: 1.035).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeOutCubic),
    );

    _imageZoomAnimation = Tween<double>(begin: 1.0, end: 1.08).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeOutCubic),
    );
  }

  @override
  void dispose() {
    _borderGlowController.dispose();
    _hoverController.dispose();
    super.dispose();
  }

  void _onHoverChanged(bool hovered) {
    setState(() => _isHovered = hovered);
    if (hovered) {
      _hoverController.forward();
      _borderGlowController.repeat();
    } else {
      _hoverController.reverse();
      _borderGlowController.stop();
      _borderGlowController.reset();
    }
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
    final isMobile = screenWidth < 700;

    return MouseRegion(
      onEnter: (_) => _onHoverChanged(true),
      onExit: (_) => _onHoverChanged(false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PackageDetailsScreen(package: widget.package),
          ),
        ),
        child: AnimatedBuilder(
          animation: _hoverController,
          builder: (context, child) {
            return Transform.scale(
              scale: _hoverScaleAnimation.value,
              child: child,
            );
          },
          child: isMobile ? _buildVerticalCard() : _buildHorizontalCard(),
        ),
      ),
    );
  }

  //  HORIZONTAL CARD (Desktop & Tablet)
  Widget _buildHorizontalCard() {
    const double cardHeight = 340;
    const double borderPad = 2.0;
    const double borderRadius = 24.0;

    return SizedBox(
      height: cardHeight,
      child: AnimatedBuilder(
        animation: _borderGlowController,
        builder: (context, child) {
          return CustomPaint(
            foregroundPainter: _isHovered
                ? AnimatedGradientBorderPainter(
                    progress: _borderGlowController.value,
                    borderRadius: borderRadius + borderPad,
                    padding: borderPad,
                  )
                : null,
            child: child,
          );
        },
        child: Container(
          margin: const .all(borderPad),
          decoration: BoxDecoration(
            borderRadius: .circular(borderRadius),
            gradient: const LinearGradient(
              begin: .topLeft,
              end: .bottomRight,
              colors: [_cardSurfaceColor, _cardDarkColor],
            ),
            border: .all(color: Colors.white.withValues(alpha: 0.06), width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.5),
                blurRadius: 30,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
              child: Row(
                children: [
                  //  Left: Text Content
                  Expanded(
                    flex: 55,
                    child: Padding(
                      padding: const .fromLTRB(32, 28, 16, 28),
                      child: Column(
                        crossAxisAlignment: .start,
                        children: [
                          _buildTitle(),
                          const SizedBox(height: 12),
                          _buildDescription(),
                          const SizedBox(height: 20),
                          _buildTechBadges(),
                          const Spacer(),
                          _buildActionButtons(),
                        ],
                      ),
                    ),
                  ),
                  //  Right: ShaderMask Image
                  Expanded(
                    flex: 45,
                    child: _buildShaderMaskImage(
                      fadeDirection: .centerLeft,
                      fadeStart: .centerRight,
                    ),
                  ),
                  //
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // VERTICAL CARD (Mobile)
  Widget _buildVerticalCard() {
    const double borderPad = 2.0;
    const double borderRadius = 24.0;

    return AnimatedBuilder(
      animation: _borderGlowController,
      builder: (context, child) {
        return CustomPaint(
          foregroundPainter: _isHovered
              ? AnimatedGradientBorderPainter(
                  progress: _borderGlowController.value,
                  borderRadius: borderRadius + borderPad,
                  padding: borderPad,
                )
              : null,
          child: child,
        );
      },
      child: Container(
        margin: const .all(borderPad),
        decoration: BoxDecoration(
          borderRadius: .circular(borderRadius),
          gradient: const LinearGradient(
            begin: .topCenter,
            end: .bottomCenter,
            colors: [_cardSurfaceColor, _cardDarkColor],
          ),
          border: .all(color: Colors.white.withValues(alpha: 0.06), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.5),
              blurRadius: 30,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              // Top: ShaderMask Image (60%)
              SizedBox(
                height: 220,
                width: .infinity,
                child: _buildShaderMaskImage(
                  fadeDirection: .bottomCenter,
                  fadeStart: .topCenter,
                ),
              ),
              //  Bottom: Text Content
              Padding(
                padding: const .fromLTRB(24, 0, 24, 24),
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    _buildTitle(),
                    const SizedBox(height: 10),
                    _buildDescription(),
                    const SizedBox(height: 16),
                    _buildTechBadges(),
                    const SizedBox(height: 20),
                    _buildActionButtons(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //  SHADER MASK IMAGE
  Widget _buildShaderMaskImage({
    required Alignment fadeDirection,
    required Alignment fadeStart,
  }) {
    return AnimatedBuilder(
      animation: _imageZoomAnimation,
      builder: (context, child) {
        return Transform.scale(scale: _imageZoomAnimation.value, child: child);
      },
      child: ShaderMask(
        shaderCallback: (Rect bounds) {
          return LinearGradient(
            begin: fadeStart,
            end: fadeDirection,
            colors: [
              Colors.white,
              Colors.white,
              Colors.white.withValues(alpha: 0.6),
              Colors.transparent,
            ],
            stops: const [0.0, 0.3, 0.7, 1.0],
          ).createShader(bounds);
        },
        blendMode: .dstIn,
        child: Image.asset(
          widget.package.imageOut,
          fit: .cover,
          width: .infinity,
          height: .infinity,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: _cardDarkColor,
              child: Center(
                child: Icon(
                  Icons.inventory_2_rounded,
                  size: 60,
                  color: Colors.cyanAccent.withValues(alpha: 0.3),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // TITLE
  Widget _buildTitle() {
    return Text(
      widget.package.title,
      style: GoogleFonts.plusJakartaSans(
        fontSize: 22,
        fontWeight: .w800,
        color: Colors.white,
        letterSpacing: -0.5,
        height: 1.2,
      ),
      maxLines: 2,
      overflow: .ellipsis,
    );
  }

  // DESCRIPTION
  Widget _buildDescription() {
    return Text(
      widget.package.shortDescription,
      style: GoogleFonts.inter(
        fontSize: 13,
        fontWeight: .w400,
        color: const Color(0xFF94A3B8),
        height: 1.6,
        letterSpacing: 0.1,
      ),
      maxLines: 3,
      overflow: .ellipsis,
    );
  }

  // TECH BADGES
  Widget _buildTechBadges() {
    final badges = [
      BadgeDataModel(icon: Icons.code_rounded, label: "Dart"),
      BadgeDataModel(icon: Icons.widgets_rounded, label: "UI Component"),
      BadgeDataModel(icon: Icons.gavel_rounded, label: "MIT"),
    ];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: badges.map((badge) => _buildGlassBadge(badge)).toList(),
    );
  }

  Widget _buildGlassBadge(BadgeDataModel badge) {
    return Container(
      padding: const .symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: .circular(100),
        color: Colors.white.withValues(alpha: 0.04),
        border: .all(
          color: Colors.cyanAccent.withValues(alpha: 0.18),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.cyanAccent.withValues(alpha: 0.06),
            blurRadius: 12,
            spreadRadius: -2,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: .min,
        children: [
          Icon(
            badge.icon,
            size: 13,
            color: Colors.cyanAccent.withValues(alpha: 0.85),
          ),
          const SizedBox(width: 6),
          Text(
            badge.label,
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: .w500,
              color: const Color(0xFFCBD5E1),
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }

  /// ACTION BUTTONS
  Widget _buildActionButtons() {
    return Row(
      children: [
        NeonPillButton(
          icon: Icons.open_in_new_rounded,
          label: "pub.dev",
          isPrimary: true,
          onTap: () => _launchUrl(widget.package.pubDevUrl),
        ),
        const SizedBox(width: 10),
        NeonPillButton(
          icon: FontAwesomeIcons.github,
          label: "GitHub",
          isPrimary: false,
          onTap: () => _launchUrl(widget.package.githubUrl),
        ),
      ],
    );
  }
}
// 589