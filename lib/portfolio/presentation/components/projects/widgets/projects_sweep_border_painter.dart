import 'dart:math';

import 'package:flutter/material.dart';

/// Custom painter that draws a rotating sweep-gradient border
/// hugging the rounded rectangle of the image. Creates a "scanner"
/// glow effect that continuously rotates for a premium, high-tech feel.
class SweepBorderPainter extends CustomPainter {
  final double progress;
  final double borderRadius;
  final double padding;
  final Color glowColor;

  SweepBorderPainter({
    required this.progress,
    required this.borderRadius,
    required this.padding,
    required this.glowColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(borderRadius));
    final angle = progress * 2 * pi;

    // — 1) Rotating sweep gradient border (the main "scanner" effect)
    final sweepShader = SweepGradient(
      center: Alignment.center,
      startAngle: angle,
      endAngle: angle + 2 * pi,
      colors: [
        glowColor.withValues(alpha: 0.0),
        glowColor.withValues(alpha: 0.0),
        glowColor.withValues(alpha: 0.6),
        glowColor.withValues(alpha: 0.9),
        glowColor.withValues(alpha: 0.6),
        glowColor.withValues(alpha: 0.0),
        glowColor.withValues(alpha: 0.0),
      ],
      stops: const [0.0, 0.3, 0.42, 0.5, 0.58, 0.7, 1.0],
      tileMode: TileMode.clamp,
    ).createShader(rect);

    final borderPaint = Paint()
      ..shader = sweepShader
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;

    canvas.drawRRect(rrect, borderPaint);

    // — 2) Subtle outer glow behind the sweep
    final glowPaint = Paint()
      ..shader = sweepShader
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);

    final glowRRect = RRect.fromRectAndRadius(
      rect.inflate(2),
      Radius.circular(borderRadius + 2),
    );
    canvas.drawRRect(glowRRect, glowPaint);

    // — 3) Faint static base border (always visible)
    final basePaint = Paint()
      ..color = glowColor.withValues(alpha: 0.12)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    canvas.drawRRect(rrect, basePaint);

    // — 4) Corner accent dots (high-tech detail)
    final dotPaint = Paint()
      ..color = glowColor.withValues(alpha: 0.4)
      ..style = PaintingStyle.fill;

    final dotRadius = 2.5;
    final inset = borderRadius * 0.3;
    final corners = [
      Offset(inset, inset),
      Offset(size.width - inset, inset),
      Offset(inset, size.height - inset),
      Offset(size.width - inset, size.height - inset),
    ];

    for (final corner in corners) {
      canvas.drawCircle(corner, dotRadius, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant SweepBorderPainter oldDelegate) =>
      progress != oldDelegate.progress;
}
