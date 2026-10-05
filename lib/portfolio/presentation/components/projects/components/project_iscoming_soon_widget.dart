import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProjectIscomingSoonWidget extends StatelessWidget {
  const ProjectIscomingSoonWidget({super.key, required this.rippleController});

  final AnimationController rippleController;

  @override
  Widget build(BuildContext context) {
    return //
    Positioned(
      top: 16,
      right: 16,
      child: AnimatedBuilder(
        animation: rippleController,
        builder: (context, child) {
          // Pulsing opacity between 0.6 and 1.0
          final pulse =
              0.6 +
              (0.4 *
                  (0.5 +
                      0.5 *
                          Curves.easeInOut.transform(
                            (rippleController.value <= 0.5
                                ? rippleController.value * 2
                                : (1 - rippleController.value) * 2),
                          )));

          return Opacity(opacity: pulse, child: child);
        },
        child: ClipRRect(
          borderRadius: .circular(4),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: Container(
              padding: const .symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.4),
                borderRadius: .circular(10),
                border: .all(
                  color: Colors.white.withValues(alpha: 0.1),
                  width: 0.5,
                ),
              ),
              child: Text(
                "COMING SOON",
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  fontWeight: .w600,
                  letterSpacing: 2.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
    //
  }
}
