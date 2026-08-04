import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedGradientBorderPainter extends CustomPainter {
  final double progress;
  final double borderRadius;
  final double padding;

  AnimatedGradientBorderPainter({
    required this.progress,
    required this.borderRadius,
    required this.padding,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(borderRadius));
    final angle = progress * 2 * pi;

    // Sweep gradient: cyan → purple → cyan
    final sweepShader = SweepGradient(
      center: Alignment.center,
      startAngle: angle,
      endAngle: angle + 2 * pi,
      colors: [
        Colors.transparent,
        Colors.cyanAccent.withValues(alpha: 0.0),
        Colors.cyanAccent.withValues(alpha: 0.7),
        const Color(0xFF818CF8).withValues(alpha: 0.9), // Indigo/purple
        Colors.cyanAccent.withValues(alpha: 0.7),
        Colors.cyanAccent.withValues(alpha: 0.0),
        Colors.transparent,
      ],
      stops: const [0.0, 0.25, 0.38, 0.5, 0.62, 0.75, 1.0],
      tileMode: TileMode.clamp,
    ).createShader(rect);

    // Main border stroke
    final borderPaint = Paint()
      ..shader = sweepShader
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    canvas.drawRRect(rrect, borderPaint);

    // Soft outer glow
    final glowPaint = Paint()
      ..shader = sweepShader
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0
      ..maskFilter = const MaskFilter.blur(.normal, 8);
    final glowRRect = RRect.fromRectAndRadius(
      rect.inflate(3),
      Radius.circular(borderRadius + 3),
    );
    canvas.drawRRect(glowRRect, glowPaint);
  }

  @override
  bool shouldRepaint(covariant AnimatedGradientBorderPainter oldDelegate) =>
      progress != oldDelegate.progress;
}
