import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ismailmagdy/core/theme/app_colors.dart';
import 'package:ismailmagdy/core/animations/splash/fade_route.dart';
import 'package:ismailmagdy/portfolio/presentation/screens/portfolio_main_screen.dart';

/// A premium, minimalist animated splash screen.
///
/// Animation timeline (total ~3.5s):
///   Phase 1  (0.0 – 0.35): Horizontal accent line expands from center
///   Phase 2  (0.15 – 0.65): Each letter of "iM" staggers in with slide + fade
///   Phase 3  (0.50 – 0.75): Subtitle "ISMAIL MAGDY" fades in below
///   Phase 4  (0.70 – 0.85): Accent line contracts back to zero
///   Phase 5  (0.80 – 1.00): Everything scales down + fades out (cinematic exit)
///   Then navigates to HomeScreen via FadeRoute.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  // ── Phase 1: Accent line expand ──
  late final Animation<double> _lineExpand;

  // ── Phase 2: Letter animations ("i" and "M") ──
  late final Animation<double> _letterIOpacity;
  late final Animation<Offset> _letterISlide;
  late final Animation<double> _letterMOpacity;
  late final Animation<Offset> _letterMSlide;

  // ── Phase 3: Subtitle fade ──
  late final Animation<double> _subtitleOpacity;

  // ── Phase 4: Accent line contract ──
  late final Animation<double> _lineContract;

  // ── Phase 5: Exit scale + fade ──
  late final Animation<double> _exitScale;
  late final Animation<double> _exitOpacity;

  // Accent color — a subtle cyan matching the portfolio's primary
  static const Color _accent = AppColors.primary; // 0xFF00ADB5

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3500),
    );

    // ── Build interval animations ──

    // Phase 1: line expands 0.0→0.35
    _lineExpand = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.35, curve: Curves.easeOutCubic),
      ),
    );

    // Phase 2a: "i" appears 0.15→0.45
    _letterIOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.15, 0.45, curve: Curves.easeOut),
      ),
    );
    _letterISlide = Tween<Offset>(
      begin: const Offset(-0.6, 0.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.15, 0.45, curve: Curves.easeOutCubic),
      ),
    );

    // Phase 2b: "M" appears 0.25→0.55
    _letterMOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.25, 0.55, curve: Curves.easeOut),
      ),
    );
    _letterMSlide = Tween<Offset>(
      begin: const Offset(0.6, 0.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.25, 0.55, curve: Curves.easeOutCubic),
      ),
    );

    // Phase 3: subtitle fades in 0.50→0.75
    _subtitleOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.50, 0.75, curve: Curves.easeOut),
      ),
    );

    // Phase 4: line contracts 0.70→0.85
    _lineContract = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.70, 0.85, curve: Curves.easeInCubic),
      ),
    );

    // Phase 5: exit 0.80→1.00
    _exitScale = Tween<double>(begin: 1.0, end: 0.85).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.80, 1.0, curve: Curves.easeInCubic),
      ),
    );
    _exitOpacity = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.85, 1.0, curve: Curves.easeIn),
      ),
    );

    // Start the animation and navigate on completion
    _controller.forward();
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _navigateToHome();
      }
    });
  }

  void _navigateToHome() {
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      FadeRoute(page: const PortfolioMainScreen()),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // Responsive logo size
    final double logoFontSize = screenWidth < 600 ? 72 : 110;
    final double subtitleFontSize = screenWidth < 600 ? 12 : 15;
    final double lineMaxWidth = screenWidth < 600 ? 100 : 160;

    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          // Combine line expand and contract phases:
          // During expand phase (0.0–0.35), lineExpand goes 0→1, lineContract stays 1.
          // During contract phase (0.70–0.85), lineContract goes 1→0.
          // Effective width = lineExpand * lineContract
          final double lineProgress = _lineExpand.value * _lineContract.value;

          return FadeTransition(
            opacity: _exitOpacity,
            child: ScaleTransition(
              scale: _exitScale,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // ── Logo: "iM" ──
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        // Letter "i" — slides in from left
                        SlideTransition(
                          position: _letterISlide,
                          child: FadeTransition(
                            opacity: _letterIOpacity,
                            child: Text(
                              'i',
                              style: GoogleFonts.playfairDisplay(
                                fontSize: logoFontSize,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                height: 1.0,
                              ),
                            ),
                          ),
                        ),
                        // Letter "M" — slides in from right
                        SlideTransition(
                          position: _letterMSlide,
                          child: FadeTransition(
                            opacity: _letterMOpacity,
                            child: Text(
                              'M',
                              style: GoogleFonts.playfairDisplay(
                                fontSize: logoFontSize,
                                fontWeight: FontWeight.w700,
                                color: _accent,
                                height: 1.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // ── Accent line ──
                    Container(
                      width: lineMaxWidth * lineProgress,
                      height: 2,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            _accent.withValues(alpha: 0.0),
                            _accent,
                            _accent.withValues(alpha: 0.0),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(1),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // ── Subtitle: "ISMAIL MAGDY" ──
                    FadeTransition(
                      opacity: _subtitleOpacity,
                      child: Text(
                        'ISMAIL MAGDY',
                        style: GoogleFonts.outfit(
                          fontSize: subtitleFontSize,
                          fontWeight: FontWeight.w300,
                          letterSpacing: 8,
                          color: Colors.white.withValues(alpha: 0.6),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
