import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart' show GoogleFonts;

class SplashScreenContent extends StatelessWidget {
  const SplashScreenContent({
    super.key,
    required this.letterIOpacity,
    required this.letterISlide,
    required this.letterMOpacity,
    required this.letterMSlide,
    required this.subtitleOpacity,
    required this.logoFontSize,
    required this.lineMaxWidth,
    required this.lineProgress,
    required this.subtitleFontSize,
    required this.accent,
  });

  final Animation<double> letterIOpacity;
  final Animation<Offset> letterISlide;
  //
  final Animation<double> letterMOpacity;
  final Animation<Offset> letterMSlide;
  //
  final Animation<double> subtitleOpacity;
  //
  final double logoFontSize;
  final double lineMaxWidth;
  final double lineProgress;
  final double subtitleFontSize;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: .min,
        children: [
          // Logo: "iM"
          Row(
            mainAxisSize: .min,
            crossAxisAlignment: .baseline,
            textBaseline: .alphabetic,
            children: [
              // Letter "i" & slides in from left
              SlideTransition(
                position: letterISlide,
                child: FadeTransition(
                  opacity: letterIOpacity,
                  child: Text(
                    "i",
                    style: GoogleFonts.playfairDisplay(
                      fontSize: logoFontSize,
                      fontWeight: .w700,
                      color: Colors.white,
                      height: 1.0,
                    ),
                  ),
                ),
              ),
              //
              // Letter "M" & slides in from right
              SlideTransition(
                position: letterMSlide,
                child: FadeTransition(
                  opacity: letterMOpacity,
                  child: Text(
                    "M",
                    style: GoogleFonts.playfairDisplay(
                      fontSize: logoFontSize,
                      fontWeight: .w700,
                      color: accent,
                      height: 1.0,
                    ),
                  ),
                ),
              ),
              //
            ],
          ),
          //
          const SizedBox(height: 16),
          //
          // Accent line
          Container(
            width: lineMaxWidth * lineProgress,
            height: 2,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  accent.withValues(alpha: 0.0),
                  accent,
                  accent.withValues(alpha: 0.0),
                ],
              ),
              borderRadius: .circular(1),
            ),
          ),
          //
          const SizedBox(height: 20),
          //
          // Subtitle: "ISMAIL MAGDY"
          FadeTransition(
            opacity: subtitleOpacity,
            child: Text(
              "ISMAIL MAGDY",
              style: GoogleFonts.outfit(
                fontSize: subtitleFontSize,
                fontWeight: .w300,
                letterSpacing: 8,
                color: Colors.white.withValues(alpha: 0.6),
              ),
            ),
          ),
          //
        ],
      ),
    );
  }
}
