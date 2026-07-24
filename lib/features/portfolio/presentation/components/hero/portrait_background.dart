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
  final List<_FloatingShape> _shapes = [];

  @override
  void initState() {
    super.initState();
    _initializeShapes();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
  }

  void _initializeShapes() {
    final rand = Random();
    for (int i = 0; i < 15; i++) {
      _shapes.add(
        _FloatingShape(
          startX: rand.nextDouble(),
          startY: rand.nextDouble(),
          speedX: (rand.nextDouble() - 0.5) * 0.1,
          speedY: (rand.nextDouble() - 0.5) * 0.1,
          size: rand.nextDouble() * 30 + 10,
          opacity: rand.nextDouble() * 0.4 + 0.1,
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
            painter: _BackgroundShapesPainter(
              shapes: _shapes,
              progress: _controller.value,
            ),
          );
        },
      ),
    );
  }
}

class _FloatingShape {
  final double startX;
  final double startY;
  final double speedX;
  final double speedY;
  final double size;
  final double opacity;

  _FloatingShape({
    required this.startX,
    required this.startY,
    required this.speedX,
    required this.speedY,
    required this.size,
    required this.opacity,
  });
}

class _BackgroundShapesPainter extends CustomPainter {
  final List<_FloatingShape> shapes;
  final double progress;

  _BackgroundShapesPainter({required this.shapes, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    for (var shape in shapes) {
      final dx =
          size.width * shape.startX +
          (sin(progress * 2 * pi + shape.speedX * 100) * 40);
      final dy =
          size.height * shape.startY +
          (cos(progress * 2 * pi + shape.speedY * 100) * 40);

      final paint = Paint()
        ..color = AppColors.primaryRedesign.withValues(alpha: shape.opacity)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(Offset(dx, dy), shape.size, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _BackgroundShapesPainter oldDelegate) => true;
}
// 131