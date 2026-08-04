import 'dart:math';
import 'package:flutter/material.dart';
import 'package:ismailmagdy/core/theme/app_colors.dart';

/// A single star particle with position, velocity, size, and opacity.
class _Star {
  double x;
  double y;
  double vx;
  double vy;
  double radius;
  double opacity;

  _Star({
    required this.x,
    required this.y,
    required this.vx,
    required this.vy,
    required this.radius,
    required this.opacity,
  });
}

class AnimatedBackground extends StatefulWidget {
  const AnimatedBackground({super.key});

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<_Star> _stars = [];
  final Random _random = Random();
  Size _lastSize = Size.zero;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
    _controller.addListener(_updateStars);
  }

  void _initStars(Size size) {
    if (size == _lastSize && _stars.isNotEmpty) return;
    _lastSize = size;
    _stars.clear();
    const int starCount = 70;
    for (int i = 0; i < starCount; i++) {
      _stars.add(_createStar(size));
    }
  }

  _Star _createStar(Size size) {
    // Speed between 0.15 and 0.5 px per frame — very slow drift
    final speed = 0.15 + _random.nextDouble() * 0.35;
    final angle = _random.nextDouble() * 2 * pi;
    return _Star(
      x: _random.nextDouble() * size.width,
      y: _random.nextDouble() * size.height,
      vx: cos(angle) * speed,
      vy: sin(angle) * speed,
      radius: 0.8 + _random.nextDouble() * 1.7, // 0.8 – 2.5 px
      opacity: 0.15 + _random.nextDouble() * 0.55, // 0.15 – 0.7
    );
  }

  void _updateStars() {
    if (_lastSize == Size.zero) return;
    for (final star in _stars) {
      star.x += star.vx;
      star.y += star.vy;

      // Wrap around edges
      if (star.x < -5) star.x = _lastSize.width + 5;
      if (star.x > _lastSize.width + 5) star.x = -5;
      if (star.y < -5) star.y = _lastSize.height + 5;
      if (star.y > _lastSize.height + 5) star.y = -5;
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_updateStars);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(constraints.maxWidth, constraints.maxHeight);
        _initStars(size);
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return CustomPaint(
              size: size,
              painter: _StarfieldPainter(
                stars: _stars,
                backgroundColor: AppColors.backgroundDark,
              ),
            );
          },
        );
      },
    );
  }
}

class _StarfieldPainter extends CustomPainter {
  final List<_Star> stars;
  final Color backgroundColor;

  _StarfieldPainter({required this.stars, required this.backgroundColor});

  @override
  void paint(Canvas canvas, Size size) {
    // Draw background
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = backgroundColor,
    );

    // Draw stars
    final paint = Paint()..style = PaintingStyle.fill;
    for (final star in stars) {
      paint.color = Colors.white.withValues(alpha: star.opacity);
      canvas.drawCircle(Offset(star.x, star.y), star.radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _StarfieldPainter oldDelegate) => true;
}
