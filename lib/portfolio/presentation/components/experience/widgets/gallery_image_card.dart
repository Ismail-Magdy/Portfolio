import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ismailmagdy/core/helpers/spacing.dart';
import 'package:ismailmagdy/core/theme/app_colors.dart';
import 'package:ismailmagdy/portfolio/presentation/components/experience/widgets/lightbox_dialog.dart';

class GalleryImageCard extends StatefulWidget {
  const GalleryImageCard({
    super.key,
    required this.imagePath,
    required this.index,
    required this.allImages,
  });
  final String imagePath;
  final int index;
  final List<String> allImages;

  @override
  State<GalleryImageCard> createState() => GalleryImageCardState();
}

class GalleryImageCardState extends State<GalleryImageCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: () => _openLightbox(context, widget.index, widget.allImages),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          transform: Matrix4.identity()
            ..scale(_hovering ? 1.03 : 1.0, _hovering ? 1.03 : 1.0),
          transformAlignment: .center,
          decoration: BoxDecoration(
            color: AppColors.cardBackgroundDark,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _hovering
                  ? AppColors.primary.withValues(alpha: 0.5)
                  : Colors.white.withValues(alpha: 0.08),
              width: 1,
            ),
            boxShadow: _hovering
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.15),
                      blurRadius: 24,
                      spreadRadius: 2,
                    ),
                  ]
                : [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  widget.imagePath,
                  fit: BoxFit.cover,
                  cacheWidth: 800,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: AppColors.cardBackgroundDark,
                    child: Center(
                      child: Icon(
                        Icons.broken_image_outlined,
                        size: 40,
                        color: Colors.white.withValues(alpha: 0.2),
                      ),
                    ),
                  ),
                ),
                // Hover overlay
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: _hovering ? 1.0 : 0.0,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: .bottomCenter,
                        end: .center,
                        colors: [
                          Colors.black.withValues(alpha: 0.5),
                          Colors.transparent,
                        ],
                      ),
                    ),
                    alignment: .bottomCenter,
                    padding: const .only(bottom: 16),
                    child: Row(
                      mainAxisAlignment: .center,
                      children: [
                        Icon(
                          Icons.zoom_in_rounded,
                          size: 18,
                          color: Colors.white.withValues(alpha: 0.9),
                        ),
                        horizontalSpace(6),
                        Text(
                          "View",
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: .w500,
                            color: Colors.white.withValues(alpha: 0.9),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _openLightbox(
    BuildContext context,
    int initialIndex,
    List<String> images,
  ) {
    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (context) =>
          LightboxDialog(initialIndex: initialIndex, images: images),
    );
  }
}
