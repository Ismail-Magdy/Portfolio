import 'package:flutter/material.dart';

class LiquidGlassPainter extends CustomPainter {
  final double progress;
  final Color color;

  LiquidGlassPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = size.width / 2;

    // Draw 3 staggered rings
    for (int i = 0; i < 3; i++) {
      final ringProgress = (progress + i * 0.33) % 1.0;

      // Ease the progress for smoother feel
      final easedProgress = Curves.easeOut.transform(ringProgress);

      final radius = maxRadius * 0.4 + (maxRadius * 0.6 * easedProgress);

      // Fade out as the ring expands
      final opacity = (1.0 - easedProgress) * 0.35;

      if (opacity > 0.01) {
        // Glass-like gradient stroke
        final paint = Paint()
          ..color = color.withValues(alpha: opacity)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5 * (1.0 - easedProgress * 0.5);

        canvas.drawCircle(center, radius, paint);

        // Inner glow fill (very subtle)
        final glowPaint = Paint()
          ..color = color.withValues(alpha: opacity * 0.15)
          ..style = PaintingStyle.fill;

        canvas.drawCircle(center, radius, glowPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant LiquidGlassPainter oldDelegate) =>
      progress != oldDelegate.progress;
}
