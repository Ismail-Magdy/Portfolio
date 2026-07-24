import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ismailmagdy/core/constants/app_dimensions.dart';
import 'package:ismailmagdy/core/theme/app_colors.dart';

class OpenSourceSection extends StatefulWidget {
  const OpenSourceSection({super.key});

  @override
  State<OpenSourceSection> createState() => _OpenSourceSectionState();
}

class _OpenSourceSectionState extends State<OpenSourceSection>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _floatController;
  late AnimationController _typingController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _floatAnimation;

  @override
  void initState() {
    super.initState();

    // Glow pulse
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 0.15, end: 0.4).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Floating bob
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
    _floatAnimation = Tween<double>(begin: -8, end: 8).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );

    // Typing cursor blink
    _typingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _floatController.dispose();
    _typingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : AppDimensions.sectionPadding,
        vertical: 80,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: AppDimensions.maxContentWidth,
          ),
          child: Column(
            children: [
              // Section Title
              Text(
                "Open Source & Packages",
                style: GoogleFonts.poppins(
                  fontSize: isMobile ? 26 : 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 60),

              // Coming Soon Card
              _buildComingSoonCard(isMobile),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildComingSoonCard(bool isMobile) {
    return AnimatedBuilder(
      animation: Listenable.merge([_pulseAnimation, _floatAnimation]),
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _floatAnimation.value),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                width: double.infinity,
                constraints: BoxConstraints(
                  maxWidth: isMobile ? double.infinity : 650,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 24 : 48,
                  vertical: isMobile ? 40 : 56,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.04),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(
                        alpha: _pulseAnimation.value,
                      ),
                      blurRadius: 40,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Animated Terminal Icon
                    _buildAnimatedIcon(),
                    const SizedBox(height: 32),

                    // "Coming Soon" badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primary.withValues(alpha: 0.3),
                            AppColors.primary.withValues(alpha: 0.15),
                          ],
                        ),
                        border: Border.all(
                          color: AppColors.primary.withValues(alpha: 0.4),
                        ),
                      ),
                      child: Text(
                        "COMING SOON",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                          letterSpacing: 2.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),

                    // Teaser text
                    Text(
                      "Cooking something special...",
                      style: GoogleFonts.poppins(
                        fontSize: isMobile ? 18 : 22,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textDark,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "The Glass Bottom Navigation Bar package is dropping on pub.dev soon! Stay tuned.",
                      style: GoogleFonts.poppins(
                        fontSize: isMobile ? 14 : 16,
                        height: 1.7,
                        color: AppColors.textDark.withValues(alpha: 0.7),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),

                    // Terminal-style text with blinking cursor
                    _buildTerminalText(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  /// The animated icon — a stylized package box with a rotating glow ring.
  Widget _buildAnimatedIcon() {
    return AnimatedBuilder(
      animation: _pulseController,
      builder: (context, child) {
        return Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.primary.withValues(
                alpha: 0.3 + _pulseAnimation.value * 0.3,
              ),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(
                  alpha: _pulseAnimation.value * 0.5,
                ),
                blurRadius: 25,
                spreadRadius: 3,
              ),
            ],
          ),
          child: const Icon(
            Icons.inventory_2_outlined,
            size: 36,
            color: AppColors.primary,
          ),
        );
      },
    );
  }

  /// A terminal-style line with a blinking cursor.
  Widget _buildTerminalText() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF0D1117),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "\$ ",
            style: GoogleFonts.firaCode(
              fontSize: 14,
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            "flutter pub add glass_bottom_nav",
            style: GoogleFonts.firaCode(
              fontSize: 14,
              color: AppColors.textDark.withValues(alpha: 0.6),
            ),
          ),
          const SizedBox(width: 2),
          // Blinking cursor
          AnimatedBuilder(
            animation: _typingController,
            builder: (context, child) {
              return Opacity(
                opacity: _typingController.value,
                child: Container(
                  width: 8,
                  height: 18,
                  color: AppColors.primary,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
