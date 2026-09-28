import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ismailmagdy/core/theme/app_colors.dart';
import 'package:ismailmagdy/portfolio/models/packages/package_model.dart';
import 'package:ismailmagdy/portfolio/models/packages/padge_data_model.dart';
import 'package:ismailmagdy/portfolio/presentation/components/open_source/components/package_details_screen.dart';
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
  late AnimationController _hoverController;
  late Animation<double> _imageZoomAnimation;

  @override
  void initState() {
    super.initState();

    _hoverController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _imageZoomAnimation = Tween<double>(begin: 1.0, end: 1.08).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeOutCubic),
    );
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  void _onHoverChanged(bool hovered) {
    setState(() => _isHovered = hovered);
    if (hovered) {
      _hoverController.forward();
    } else {
      _hoverController.reverse();
    }
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
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          transform: Matrix4.identity()
            ..scale(_isHovered ? 1.02 : 1.0, _isHovered ? 1.02 : 1.0),
          transformAlignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.backgroundDark,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _isHovered
                  ? AppColors.primary.withValues(alpha: 0.4)
                  : Colors.white.withValues(alpha: 0.06),
              width: 1.5,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.15),
                      blurRadius: 24,
                      spreadRadius: 2,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: isMobile ? _buildVerticalCard() : _buildHorizontalCard(),
          ),
        ),
      ),
    );
  }

  //  HORIZONTAL CARD (Desktop & Tablet)
  Widget _buildHorizontalCard() {
    return SizedBox(
      height: 340,
      child: Row(
        children: [
          //  Left: Text Content
          Expanded(
            flex: 55,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(32, 28, 16, 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
              fadeDirection: Alignment.centerLeft,
              fadeStart: Alignment.centerRight,
            ),
          ),
        ],
      ),
    );
  }

  // VERTICAL CARD (Mobile)
  Widget _buildVerticalCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top: ShaderMask Image
        SizedBox(
          height: 220,
          width: double.infinity,
          child: _buildShaderMaskImage(
            fadeDirection: Alignment.bottomCenter,
            fadeStart: Alignment.topCenter,
          ),
        ),
        //  Bottom: Text Content
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
        blendMode: BlendMode.dstIn,
        child: Image.asset(
          widget.package.imageOut,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: AppColors.backgroundDark,
              child: Center(
                child: Icon(
                  Icons.inventory_2_rounded,
                  size: 60,
                  color: AppColors.primary.withValues(alpha: 0.3),
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
        fontWeight: FontWeight.w800,
        color: Colors.white,
        letterSpacing: -0.5,
        height: 1.2,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  // DESCRIPTION
  Widget _buildDescription() {
    return Text(
      widget.package.shortDescription,
      style: GoogleFonts.inter(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        color: const Color(0xFF94A3B8),
        height: 1.6,
        letterSpacing: 0.1,
      ),
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
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
      children: badges.map((badge) => _buildMinimalBadge(badge)).toList(),
    );
  }

  Widget _buildMinimalBadge(BadgeDataModel badge) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: AppColors.primary.withValues(alpha: 0.06),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.15),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            badge.icon,
            size: 13,
            color: AppColors.primary.withValues(alpha: 0.7),
          ),
          const SizedBox(width: 6),
          Text(
            badge.label,
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w500,
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
        _MinimalActionButton(
          icon: FontAwesomeIcons.arrowUpRightFromSquare,
          label: "pub.dev",
          isPrimary: true,
          onTap: () => _launchUrl(widget.package.pubDevUrl),
        ),
        const SizedBox(width: 10),
        _MinimalActionButton(
          icon: FontAwesomeIcons.github,
          label: "GitHub",
          isPrimary: false,
          onTap: () => _launchUrl(widget.package.githubUrl),
        ),
      ],
    );
  }
}

class _MinimalActionButton extends StatefulWidget {
  final FaIconData icon;
  final String label;
  final bool isPrimary;
  final VoidCallback onTap;

  const _MinimalActionButton({
    required this.icon,
    required this.label,
    required this.isPrimary,
    required this.onTap,
  });

  @override
  State<_MinimalActionButton> createState() => _MinimalActionButtonState();
}

class _MinimalActionButtonState extends State<_MinimalActionButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final Color accentColor = widget.isPrimary
        ? AppColors.primary
        : Colors.white.withValues(alpha: 0.7);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: _isHovered
                ? accentColor.withValues(alpha: 0.08)
                : Colors.transparent,
            border: Border.all(
              color: _isHovered
                  ? accentColor.withValues(alpha: 0.5)
                  : Colors.white.withValues(alpha: 0.12),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(
                widget.icon,
                size: 14,
                color: _isHovered
                    ? accentColor
                    : accentColor.withValues(alpha: 0.6),
              ),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: GoogleFonts.inter(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: _isHovered
                      ? accentColor
                      : accentColor.withValues(alpha: 0.6),
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
