import 'package:flutter/material.dart';
import 'package:ismailmagdy/core/theme/app_colors.dart';

/// A performant, code-generated blueprint grid overlay.
///
/// Paints a technical engineering grid on a deep dark-blue background
/// using only [CustomPainter] — zero image assets.
/// Includes major grid lines, minor subdivisions, and subtle
/// crosshair markers at intersections for an authentic drafting feel.
class BlueprintGridOverlay extends StatelessWidget {
  const BlueprintGridOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: CustomPaint(
        painter: _BlueprintGridPainter(),
        child: const SizedBox.expand(),
      ),
    );
  }
}

class _BlueprintGridPainter extends CustomPainter {
  // Deep technical blue background
  static const Color _bgColor = Color(0xFF0A1128);

  @override
  void paint(Canvas canvas, Size size) {
    // — Background fill —
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = _bgColor,
    );

    final majorSpacing = 80.0;
    final minorDivisions = 4;
    final minorSpacing = majorSpacing / minorDivisions;

    // — Minor grid lines —
    final minorPaint = Paint()
      ..color = AppColors.primary.withValues(alpha: 0.06)
      ..strokeWidth = 0.5
      ..style = PaintingStyle.stroke;

    // Vertical minor lines
    for (double x = 0; x <= size.width; x += minorSpacing) {
      // Skip major lines (drawn separately with different style)
      if ((x % majorSpacing).abs() < 0.5) continue;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), minorPaint);
    }

    // Horizontal minor lines
    for (double y = 0; y <= size.height; y += minorSpacing) {
      if ((y % majorSpacing).abs() < 0.5) continue;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), minorPaint);
    }

    // — Major grid lines —
    final majorPaint = Paint()
      ..color = AppColors.primary.withValues(alpha: 0.15)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    // Vertical major lines
    for (double x = 0; x <= size.width; x += majorSpacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), majorPaint);
    }

    // Horizontal major lines
    for (double y = 0; y <= size.height; y += majorSpacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), majorPaint);
    }

    // — Crosshair markers at major intersections —
    final crosshairPaint = Paint()
      ..color = AppColors.primary.withValues(alpha: 0.25)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    const crosshairSize = 4.0;
    for (double x = majorSpacing; x < size.width; x += majorSpacing) {
      for (double y = majorSpacing; y < size.height; y += majorSpacing) {
        // Small + marker
        canvas.drawLine(
          Offset(x - crosshairSize, y),
          Offset(x + crosshairSize, y),
          crosshairPaint,
        );
        canvas.drawLine(
          Offset(x, y - crosshairSize),
          Offset(x, y + crosshairSize),
          crosshairPaint,
        );
      }
    }

    // — Corner registration marks (drafting-style L brackets) —
    final regPaint = Paint()
      ..color = AppColors.primary.withValues(alpha: 0.3)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    const regLen = 30.0;
    const regMargin = 20.0;

    // Top-left
    canvas.drawLine(
      const Offset(regMargin, regMargin),
      const Offset(regMargin + regLen, regMargin),
      regPaint,
    );
    canvas.drawLine(
      const Offset(regMargin, regMargin),
      const Offset(regMargin, regMargin + regLen),
      regPaint,
    );

    // Top-right
    canvas.drawLine(
      Offset(size.width - regMargin, regMargin),
      Offset(size.width - regMargin - regLen, regMargin),
      regPaint,
    );
    canvas.drawLine(
      Offset(size.width - regMargin, regMargin),
      Offset(size.width - regMargin, regMargin + regLen),
      regPaint,
    );

    // Bottom-left
    canvas.drawLine(
      Offset(regMargin, size.height - regMargin),
      Offset(regMargin + regLen, size.height - regMargin),
      regPaint,
    );
    canvas.drawLine(
      Offset(regMargin, size.height - regMargin),
      Offset(regMargin, size.height - regMargin - regLen),
      regPaint,
    );

    // Bottom-right
    canvas.drawLine(
      Offset(size.width - regMargin, size.height - regMargin),
      Offset(size.width - regMargin - regLen, size.height - regMargin),
      regPaint,
    );
    canvas.drawLine(
      Offset(size.width - regMargin, size.height - regMargin),
      Offset(size.width - regMargin, size.height - regMargin - regLen),
      regPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _BlueprintGridPainter oldDelegate) => false;
}
