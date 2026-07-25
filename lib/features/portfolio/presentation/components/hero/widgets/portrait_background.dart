import 'dart:math';
import 'package:flutter/material.dart';
import 'package:ismailmagdy/core/theme/app_colors.dart';

class PortraitBackground extends StatefulWidget {
  final double width;
  final double height;

  const PortraitBackground({
    super.key,
    required this.width,
    required this.height,
  });

  @override
  State<PortraitBackground> createState() => _PortraitBackgroundState();
}

class _PortraitBackgroundState extends State<PortraitBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  final List<_TechElement> _elements = [];

  @override
  void initState() {
    super.initState();
    _initializeElements();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    )..repeat();
  }

  void _initializeElements() {
    final rand = Random();
    for (int i = 0; i < 20; i++) {
      _elements.add(
        _TechElement(
          startX: rand.nextDouble(),
          startY: rand.nextDouble(),
          speedY: (rand.nextDouble() * 0.1) + 0.05,
          size: rand.nextDouble() * 35 + 15,
          opacity: rand.nextDouble() * 0.25 + 0.05,
          isOutline: rand.nextBool(),
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            size: Size(widget.width, widget.height),
            painter: _TechBackgroundPainter(
              elements: _elements,
              progress: _controller.value,
            ),
          );
        },
      ),
    );
  }
}

class _TechElement {
  final double startX;
  final double startY;
  final double speedY;
  final double size;
  final double opacity;
  final bool isOutline;

  _TechElement({
    required this.startX,
    required this.startY,
    required this.speedY,
    required this.size,
    required this.opacity,
    required this.isOutline,
  });
}

class _TechBackgroundPainter extends CustomPainter {
  final List<_TechElement> elements;
  final double progress;

  _TechBackgroundPainter({required this.elements, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    // Draw a subtle tech grid
    final gridPaint = Paint()
      ..color = AppColors.primary.withValues(alpha: 0.04)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    const double step = 50.0;
    for (double i = 0; i < size.width; i += step) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), gridPaint);
    }
    for (double i = 0; i < size.height; i += step) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), gridPaint);
    }

    // Draw floating tech squares/lines
    for (var element in elements) {
      // Elements move upwards slowly
      double dy =
          size.height * element.startY -
          (progress * size.height * element.speedY * 5);
      // Loop around
      dy = dy % size.height;
      if (dy < 0) dy += size.height;

      final dx = size.width * element.startX;

      final paint = Paint()
        ..color = AppColors.primary.withValues(alpha: element.opacity)
        ..style = element.isOutline ? PaintingStyle.stroke : PaintingStyle.fill
        ..strokeWidth = 1.5;

      // Draw squares instead of circles to look more techy
      canvas.drawRect(
        Rect.fromCenter(
          center: Offset(dx, dy),
          width: element.size,
          height: element.size,
        ),
        paint,
      );

      // Sometimes add a small cross or line inside the outline square
      if (element.isOutline && element.size > 30) {
        final innerPaint = Paint()
          ..color = AppColors.primary.withValues(alpha: element.opacity * 1.5)
          ..style = PaintingStyle.fill;
        canvas.drawRect(
          Rect.fromCenter(center: Offset(dx, dy), width: 4, height: 4),
          innerPaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant _TechBackgroundPainter oldDelegate) => true;
}
