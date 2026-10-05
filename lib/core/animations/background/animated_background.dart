import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ismailmagdy/core/animations/background/star.dart';
import 'package:ismailmagdy/core/animations/background/starfield_painter.dart';
import 'package:ismailmagdy/core/theme/app_colors.dart';

class AnimatedBackground extends StatefulWidget {
  const AnimatedBackground({super.key});

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Star> _stars = [];
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

  Star _createStar(Size size) {
    // Speed between 0.15 and 0.5 px per frame — very slow drift
    final speed = 0.15 + _random.nextDouble() * 0.35;
    final angle = _random.nextDouble() * 2 * pi;
    return Star(
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
              painter: StarfieldPainter(
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
// 141
