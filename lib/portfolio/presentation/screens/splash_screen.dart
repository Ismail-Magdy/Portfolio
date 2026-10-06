import 'package:flutter/material.dart';
import 'package:ismailmagdy/core/theme/app_colors.dart';
import 'package:ismailmagdy/core/animations/splash/fade_route.dart';
import 'package:ismailmagdy/portfolio/presentation/components/splash/splash_screen_content.dart';
import 'package:ismailmagdy/portfolio/presentation/screens/portfolio_main_screen.dart';

/// A premium, minimalist animated splash screen
///
/// Animation timeline (total ~3.5s):
///   Phase 1  (0.0 – 0.35): Horizontal accent line expands from center
///   Phase 2  (0.15 – 0.65): Each letter of "iM" staggers in with slide + fade
///   Phase 3  (0.50 – 0.75): Subtitle "ISMAIL MAGDY" fades in below
///   Phase 4  (0.70 – 0.85): Accent line contracts back to zero
///   Phase 5  (0.80 – 1.00): Everything scales down + fades out (cinematic exit)
///   Then navigates to HomeScreen via FadeRoute
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  // Accent line expand
  late final Animation<double> _lineExpand;

  // Letter animations ("i" and "M")
  late final Animation<double> _letterIOpacity;
  late final Animation<Offset> _letterISlide;
  late final Animation<double> _letterMOpacity;
  late final Animation<Offset> _letterMSlide;

  // Subtitle fade
  late final Animation<double> _subtitleOpacity;

  // Accent line contract
  late final Animation<double> _lineContract;

  // Exit scale + fade
  late final Animation<double> _exitScale;
  late final Animation<double> _exitOpacity;

  // Accent color & a subtle cyan matching the portfolio's primary
  static const Color _accent = AppColors.primary;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3500),
    );

    // Build interval animations

    // (1) line expands 0.0 → 0.35
    _lineExpand = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.35, curve: Curves.easeOutCubic),
      ),
    );

    // (2)(a): "i" appears 0.15 → 0.45
    _letterIOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.15, 0.45, curve: Curves.easeOut),
      ),
    );
    _letterISlide =
        Tween<Offset>(begin: const Offset(-0.6, 0.0), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.15, 0.45, curve: Curves.easeOutCubic),
          ),
        );

    // (2)(b): "M" appears 0.25 → 0.55
    _letterMOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.25, 0.55, curve: Curves.easeOut),
      ),
    );
    _letterMSlide =
        Tween<Offset>(begin: const Offset(0.6, 0.0), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.25, 0.55, curve: Curves.easeOutCubic),
          ),
        );

    // (3) subtitle fades in 0.50 → 0.75
    _subtitleOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.50, 0.75, curve: Curves.easeOut),
      ),
    );

    // (4) line contracts 0.70 → 0.85
    _lineContract = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.70, 0.85, curve: Curves.easeInCubic),
      ),
    );

    // (5) exit 0.80 → 1.00
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
    Navigator.of(context)
        .pushReplacement(FadeRoute(page: const PortfolioMainScreen()));
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
          final double lineProgress = _lineExpand.value * _lineContract.value;

          return FadeTransition(
            opacity: _exitOpacity,
            child: ScaleTransition(
              scale: _exitScale,
              //
              child: SplashScreenContent(
                accent: _accent,
                letterIOpacity: _letterIOpacity,
                letterISlide: _letterISlide,
                letterMOpacity: _letterMOpacity,
                letterMSlide: _letterMSlide,
                lineMaxWidth: lineMaxWidth,
                lineProgress: lineProgress,
                logoFontSize: logoFontSize,
                subtitleFontSize: subtitleFontSize,
                subtitleOpacity: _subtitleOpacity,
              ),
              //
            ),
          );
        },
      ),
    );
  }
}
// 259
