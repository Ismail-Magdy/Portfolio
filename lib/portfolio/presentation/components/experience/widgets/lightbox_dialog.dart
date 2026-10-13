import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ismailmagdy/core/theme/app_colors.dart';

class LightboxDialog extends StatefulWidget {
  const LightboxDialog({
    super.key,
    required this.initialIndex,
    required this.images,
  });
  final int initialIndex;
  final List<String> images;

  @override
  State<LightboxDialog> createState() => _LightboxDialogState();
}

class _LightboxDialogState extends State<LightboxDialog>
    with SingleTickerProviderStateMixin {
  late int _currentIndex;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  final TransformationController _transformController =
      TransformationController();

  bool _leftHover = false;
  bool _rightHover = false;
  bool _closeHover = false;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _transformController.dispose();
    super.dispose();
  }

  void _navigate(int delta) {
    setState(() {
      _currentIndex = (_currentIndex + delta).clamp(
        0,
        widget.images.length - 1,
      );
      _transformController.value = Matrix4.identity();
    });
  }

  @override
  Widget build(BuildContext context) {
    final hasPrev = _currentIndex > 0;
    final hasNext = _currentIndex < widget.images.length - 1;

    return FadeTransition(
      opacity: _fadeAnimation,
      child: KeyboardListener(
        focusNode: FocusNode()..requestFocus(),
        onKeyEvent: (event) {
          if (event is! KeyUpEvent) {
            if (event.logicalKey == LogicalKeyboardKey.arrowLeft && hasPrev) {
              _navigate(-1);
            } else if (event.logicalKey == LogicalKeyboardKey.arrowRight &&
                hasNext) {
              _navigate(1);
            } else if (event.logicalKey == LogicalKeyboardKey.escape) {
              Navigator.pop(context);
            }
          }
        },
        child: Stack(
          children: [
            // Blurred backdrop
            Positioned.fill(
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                  child: Container(color: Colors.black.withValues(alpha: 0.85)),
                ),
              ),
            ),

            // Main image
            Center(
              child: Padding(
                padding: const EdgeInsets.all(60),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: InteractiveViewer(
                    transformationController: _transformController,
                    minScale: 0.5,
                    maxScale: 4.0,
                    child: Image.asset(
                      widget.images[_currentIndex],
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: 400,
                        height: 300,
                        color: AppColors.cardBackgroundDark,
                        child: Center(
                          child: Icon(
                            Icons.broken_image_outlined,
                            size: 60,
                            color: Colors.white.withValues(alpha: 0.3),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Close button
            Positioned(
              top: 24,
              right: 24,
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                onEnter: (_) => setState(() => _closeHover = true),
                onExit: (_) => setState(() => _closeHover = false),
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: _closeHover
                          ? Colors.white.withValues(alpha: 0.2)
                          : Colors.white.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.15),
                      ),
                    ),
                    child: Icon(
                      Icons.close_rounded,
                      color: Colors.white.withValues(alpha: 0.9),
                      size: 22,
                    ),
                  ),
                ),
              ),
            ),

            // Counter badge
            Positioned(
              top: 24,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.6),
                    borderRadius: .circular(20),
                    border: .all(color: Colors.white.withValues(alpha: 0.1)),
                  ),
                  child: Text(
                    '${_currentIndex + 1} / ${widget.images.length}',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: .w500,
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                  ),
                ),
              ),
            ),

            // Left arrow
            if (hasPrev)
              Positioned(
                left: 16,
                top: 0,
                bottom: 0,
                child: Center(
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    onEnter: (_) => setState(() => _leftHover = true),
                    onExit: (_) => setState(() => _leftHover = false),
                    child: GestureDetector(
                      onTap: () => _navigate(-1),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: _leftHover
                              ? AppColors.primary.withValues(alpha: 0.3)
                              : Colors.white.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: _leftHover
                                ? AppColors.primary.withValues(alpha: 0.6)
                                : Colors.white.withValues(alpha: 0.15),
                          ),
                        ),
                        child: Icon(
                          Icons.chevron_left_rounded,
                          color: Colors.white.withValues(alpha: 0.9),
                          size: 28,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

            // Right arrow
            if (hasNext)
              Positioned(
                right: 16,
                top: 0,
                bottom: 0,
                child: Center(
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    onEnter: (_) => setState(() => _rightHover = true),
                    onExit: (_) => setState(() => _rightHover = false),
                    child: GestureDetector(
                      onTap: () => _navigate(1),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: _rightHover
                              ? AppColors.primary.withValues(alpha: 0.3)
                              : Colors.white.withValues(alpha: 0.1),
                          shape: .circle,
                          border: .all(
                            color: _rightHover
                                ? AppColors.primary.withValues(alpha: 0.6)
                                : Colors.white.withValues(alpha: 0.15),
                          ),
                        ),
                        child: Icon(
                          Icons.chevron_right_rounded,
                          color: Colors.white.withValues(alpha: 0.9),
                          size: 28,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
