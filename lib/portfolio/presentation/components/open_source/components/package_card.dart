import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ismailmagdy/core/theme/app_colors.dart';
import 'package:ismailmagdy/portfolio/models/packages/package_model.dart';
import 'package:ismailmagdy/portfolio/presentation/components/open_source/widgets/package_action_button_widget.dart';

class PackageCard extends StatefulWidget {
  final PackageModel package;

  const PackageCard({super.key, required this.package});

  @override
  State<PackageCard> createState() => _PackageCardState();
}

class _PackageCardState extends State<PackageCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        decoration: BoxDecoration(
          color: AppColors.cardBackgroundDark,
          borderRadius: .circular(12),
          border: .all(
            color: _isHovered
                ? Colors.white.withValues(alpha: 0.12)
                : Colors.white.withValues(alpha: 0.06),
            width: 1,
          ),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isMobile = constraints.maxWidth < 600;
            final imageSize = isMobile ? 60.0 : 90.0;

            final contentWidget = Column(
              crossAxisAlignment: .start,
              children: [
                // Title
                Text(
                  widget.package.title,
                  style: GoogleFonts.poppins(
                    fontSize: isMobile ? 18 : 20,
                    fontWeight: .w700,
                    color: Colors.white,
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 8),
                // Description
                Text(
                  widget.package.shortDescription,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: const Color(0xFF94A3B8),
                    height: 1.6,
                  ),
                ),
                //
                const SizedBox(height: 16),
                // Action Buttons
                PackageActionButtonWidget(
                  isBlueprint: false,
                  package: widget.package,
                ),
                //
              ],
            );
            final imageWidget = _buildCircularImage(
              false,
              imageSize,
              widget.package.imagePath,
            );

            if (isMobile && constraints.maxWidth < 400) {
              // Stack on very small screens
              return Padding(
                padding: const .all(24),
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Align(alignment: .center, child: imageWidget),
                    const SizedBox(height: 20),
                    contentWidget,
                  ],
                ),
              );
            }

            return Padding(
              padding: const .all(24),
              child: Row(
                crossAxisAlignment: .start,
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

  /// Circular Image
  Widget _buildCircularImage(bool isBlueprint, double size, String imagePath) {
    final image = Image.asset(
      imagePath,
      fit: .cover,
      errorBuilder: (context, error, stackTrace) => Container(
        color: AppColors.primary.withValues(alpha: 0.1),
        child: const Icon(Icons.image, color: AppColors.primary),
      ),
    );

    final themedImage = image;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: .circle,
        color: Colors.white.withValues(alpha: 0.05),
      ),
      child: ClipOval(child: themedImage),
    );
  }
}
// 295
