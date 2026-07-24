import 'package:flutter/material.dart';
import '../../../../../../core/theme/app_colors.dart';

class TimelineSpinePainter extends CustomPainter {
  final bool isMobile;
  final double centerGap;

  TimelineSpinePainter({required this.isMobile, required this.centerGap});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primaryRedesign.withValues(alpha: 0.3)
      ..strokeWidth = 1.5;

    final double x = isMobile ? (centerGap / 2) : (size.width / 2);
    canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant TimelineSpinePainter oldDelegate) => false;
}
//