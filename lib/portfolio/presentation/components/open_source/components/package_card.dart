import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ismailmagdy/core/theme/app_colors.dart';
import 'package:ismailmagdy/core/theme/blueprint_provider.dart';
import 'package:ismailmagdy/portfolio/models/packages/package_model.dart';
import 'package:url_launcher/url_launcher.dart';

class PackageCard extends StatefulWidget {
  final PackageModel package;

  const PackageCard({super.key, required this.package});

  @override
  State<PackageCard> createState() => _PackageCardState();
}

class _PackageCardState extends State<PackageCard> {
  bool _isHovered = false;

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isBlueprint = context.watch<BlueprintProvider>().isBlueprintMode;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        decoration: BoxDecoration(
          color: isBlueprint
              ? Colors.transparent
              : AppColors.cardBackgroundDark,
          borderRadius: BorderRadius.circular(isBlueprint ? 0 : 12),
          border: Border.all(
            color: isBlueprint
                ? (_isHovered
                    ? AppColors.primary.withValues(alpha: 0.6)
                    : AppColors.primary.withValues(alpha: 0.3))
                : (_isHovered
                    ? Colors.white.withValues(alpha: 0.12)
                    : Colors.white.withValues(alpha: 0.06)),
            width: 1,
          ),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isMobile = constraints.maxWidth < 600;
            final imageSize = isMobile ? 60.0 : 90.0;
            
            final contentWidget = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  widget.package.title,
                  style: isBlueprint
                      ? GoogleFonts.firaCode(
                          fontSize: isMobile ? 15 : 17,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                          letterSpacing: 0.3,
                        )
                      : GoogleFonts.poppins(
                          fontSize: isMobile ? 18 : 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: -0.3,
                        ),
                ),
                const SizedBox(height: 8),
                // Description
                Text(
                  widget.package.shortDescription,
                  style: isBlueprint
                      ? GoogleFonts.firaCode(
                          fontSize: 11,
                          color: AppColors.textDark.withValues(alpha: 0.55),
                          height: 1.6,
                        )
                      : GoogleFonts.poppins(
                          fontSize: 13,
                          color: const Color(0xFF94A3B8),
                          height: 1.6,
                        ),
                ),
                const SizedBox(height: 16),
                // Tags
                _buildTechBadges(isBlueprint),
                const SizedBox(height: 24),
                // Action Buttons
                _buildActionButtons(isBlueprint),
              ],
            );
            
            final imageWidget = _buildCircularImage(isBlueprint, imageSize, widget.package.imagePath);
            
            if (isMobile && constraints.maxWidth < 400) {
              // Stack on very small screens
              return Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: imageWidget,
                    ),
                    const SizedBox(height: 20),
                    contentWidget,
                  ],
                ),
              );
            }
            
            return Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: contentWidget),
                  const SizedBox(width: 20),
                  imageWidget,
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // ─── Tech Badges ───
  Widget _buildTechBadges(bool isBlueprint) {
    final badges = [
      (Icons.code_rounded, 'Dart'),
      (Icons.widgets_rounded, 'UI Component'),
      (Icons.gavel_rounded, 'MIT'),
    ];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: badges.map((badge) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: isBlueprint
                ? Colors.transparent
                : Colors.white.withValues(alpha: 0.03),
            borderRadius: BorderRadius.circular(isBlueprint ? 0 : 6),
            border: Border.all(
              color: isBlueprint
                  ? AppColors.primary.withValues(alpha: 0.2)
                  : Colors.white.withValues(alpha: 0.06),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                badge.$1,
                size: 12,
                color: isBlueprint
                    ? AppColors.primary.withValues(alpha: 0.6)
                    : Colors.white.withValues(alpha: 0.4),
              ),
              const SizedBox(width: 6),
              Text(
                badge.$2,
                style: isBlueprint
                    ? GoogleFonts.firaCode(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primary.withValues(alpha: 0.6),
                        letterSpacing: 0.5,
                      )
                    : GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: Colors.white.withValues(alpha: 0.4),
                      ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  // ─── Action Buttons ───
  Widget _buildActionButtons(bool isBlueprint) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        _PackageActionButton(
          icon: FontAwesomeIcons.arrowUpRightFromSquare,
          label: 'pub.dev',
          onTap: () => _launchUrl(widget.package.pubDevUrl),
          isPrimary: true,
          isBlueprint: isBlueprint,
        ),
        _PackageActionButton(
          icon: FontAwesomeIcons.github,
          label: 'GitHub',
          onTap: () => _launchUrl(widget.package.githubUrl),
          isPrimary: false,
          isBlueprint: isBlueprint,
        ),
      ],
    );
  }

  // ─── Circular Image ───
  Widget _buildCircularImage(bool isBlueprint, double size, String imagePath) {
    final image = Image.asset(
      imagePath,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => Container(
        color: AppColors.primary.withValues(alpha: 0.1),
        child: const Icon(Icons.image, color: AppColors.primary),
      ),
    );

    final themedImage = isBlueprint
        ? ColorFiltered(
            colorFilter: const ColorFilter.mode(
              AppColors.primary,
              BlendMode.modulate,
            ),
            child: image,
          )
        : image;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isBlueprint ? Colors.transparent : Colors.white.withValues(alpha: 0.05),
        border: isBlueprint
            ? Border.all(color: AppColors.primary, width: 1)
            : null,
      ),
      child: ClipOval(
        child: themedImage,
      ),
    );
  }
}

/// Minimal, hover-aware action button for package cards.
class _PackageActionButton extends StatefulWidget {
  final FaIconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isPrimary;
  final bool isBlueprint;

  const _PackageActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.isPrimary,
    required this.isBlueprint,
  });

  @override
  State<_PackageActionButton> createState() => _PackageActionButtonState();
}

class _PackageActionButtonState extends State<_PackageActionButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: widget.isBlueprint
                ? Colors.transparent
                : (_isHovered && widget.isPrimary
                      ? AppColors.primary.withValues(alpha: 0.08)
                      : Colors.transparent),
            borderRadius: BorderRadius.circular(widget.isBlueprint ? 0 : 8),
            border: Border.all(
              color: widget.isBlueprint
                  ? (_isHovered
                        ? AppColors.primary.withValues(alpha: 0.6)
                        : AppColors.primary.withValues(alpha: 0.3))
                  : (_isHovered
                        ? (widget.isPrimary
                              ? AppColors.primary.withValues(alpha: 0.4)
                              : Colors.white.withValues(alpha: 0.2))
                        : (widget.isPrimary
                              ? AppColors.primary.withValues(alpha: 0.2)
                              : Colors.white.withValues(alpha: 0.08))),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(
                widget.icon,
                size: 13,
                color: widget.isBlueprint
                    ? AppColors.primary
                    : (widget.isPrimary
                          ? AppColors.primary
                          : Colors.white.withValues(alpha: 0.5)),
              ),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: widget.isBlueprint
                    ? GoogleFonts.firaCode(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primary,
                        letterSpacing: 0.3,
                      )
                    : GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: widget.isPrimary
                            ? AppColors.primary
                            : Colors.white.withValues(alpha: 0.5),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
