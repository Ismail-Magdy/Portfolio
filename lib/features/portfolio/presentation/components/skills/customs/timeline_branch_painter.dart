import 'package:flutter/material.dart';

import '../../../../../../core/theme/app_colors.dart';

class TimelineBranchPainter extends CustomPainter {
  final bool isLeftNode;
  final bool isMobile;

  TimelineBranchPainter({required this.isLeftNode, required this.isMobile});

  @override
  void paint(Canvas canvas, Size size) {
    final double spineX = size.width / 2;
    final double y = size.height / 2;

    final paint = Paint()
      ..color = AppColors.primaryRedesign.withValues(alpha: 0.3)
      ..strokeWidth = 1.5;

    if (isLeftNode) {
      canvas.drawLine(Offset(spineX, y), Offset(0, y), paint);
    } else {
      canvas.drawLine(Offset(spineX, y), Offset(size.width, y), paint);
    }

    final dotPaint = Paint()..color = AppColors.primaryRedesign;
    canvas.drawCircle(Offset(spineX, y), 3.5, dotPaint);

    final glowPaint = Paint()
      ..color = AppColors.primary.withValues(alpha: 0.4)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4.0);
    canvas.drawCircle(Offset(spineX, y), 4.5, glowPaint);
  }

  @override
  bool shouldRepaint(covariant TimelineBranchPainter oldDelegate) => false;
}
//