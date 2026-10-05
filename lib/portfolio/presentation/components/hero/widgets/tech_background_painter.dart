import 'package:flutter/material.dart';
import 'package:ismailmagdy/core/theme/app_colors.dart';
import 'package:ismailmagdy/portfolio/presentation/components/hero/widgets/tech_element.dart';

class TechBackgroundPainter extends CustomPainter {
  final List<TechElement> elements;
  final double progress;

  const TechBackgroundPainter({required this.elements, required this.progress});

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
  bool shouldRepaint(covariant TechBackgroundPainter oldDelegate) => true;
}
