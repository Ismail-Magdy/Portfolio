import 'package:flutter/material.dart';
import 'package:ismailmagdy/core/animations/background/star.dart';

class StarfieldPainter extends CustomPainter {
  final List<Star> stars;
  final Color backgroundColor;

  StarfieldPainter({required this.stars, required this.backgroundColor});

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
  bool shouldRepaint(covariant StarfieldPainter oldDelegate) => true;
}
