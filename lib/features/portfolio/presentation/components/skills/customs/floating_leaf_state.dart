import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ismailmagdy/features/portfolio/presentation/components/skills/customs/floating_leaf.dart';
import '../../../../../../core/theme/app_colors.dart';

class FloatingLeafState extends State<FloatingLeaf>
    with SingleTickerProviderStateMixin {
  late AnimationController _floatCtrl;
  bool _hovered = false;

  @override
  void initState() {
    super.initState();

    // Build an organic, asynchronous floating effect
    final int delayMs = widget.index * 400;
    final int durationMs = 2000 + (widget.index * 200);

    _floatCtrl = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: durationMs),
    );

    // Unmistakably independent phase starts
    Future.delayed(Duration(milliseconds: delayMs), () {
      if (mounted) {
        _floatCtrl.repeat(reverse: true);
      }
    });
  }

  @override
  void dispose() {
    _floatCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _floatCtrl,
      builder: (context, child) {
        // Continuous, prominent float (amplified to 8.0 for visibility)
        final dy = math.sin(_floatCtrl.value * math.pi) * 8.0;

        return Transform.translate(
          offset: Offset(0, dy),
          child: MouseRegion(
            onEnter: (_) => setState(() => _hovered = true),
            onExit: (_) => setState(() => _hovered = false),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              transform: Matrix4.diagonal3Values(
                _hovered ? 1.05 : 1.0,
                _hovered ? 1.05 : 1.0,
                1.0,
              ),
              padding: const .symmetric(horizontal: 26, vertical: 14),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: widget.isLeft
                    ? const .only(
                        topLeft: .circular(24),
                        bottomLeft: .circular(24),
                        topRight: .circular(4),
                        bottomRight: .circular(24),
                      )
                    : const .only(
                        topRight: .circular(24),
                        bottomRight: .circular(24),
                        topLeft: .circular(4),
                        bottomLeft: .circular(24),
                      ),
                border: .all(
                  color: _hovered
                      ? AppColors.textLight
                      : AppColors.primaryRedesign.withValues(alpha: 0.35),
                ),
                boxShadow: _hovered
                    ? [
                        BoxShadow(
                          color: AppColors.primaryRedesign.withValues(
                            alpha: 0.15,
                          ),
                          blurRadius: 16,
                          spreadRadius: 1,
                        ),
                      ]
                    : [],
              ),
              child: Text(
                widget.skill.name,
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: .w600,
                  color: _hovered
                      ? AppColors.primaryRedesign
                      : (AppColors.textDark),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
// 120