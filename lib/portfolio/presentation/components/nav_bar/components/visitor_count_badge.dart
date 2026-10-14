import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ismailmagdy/core/theme/app_colors.dart';
import 'package:ismailmagdy/portfolio/presentation/components/nav_bar/functions/nav_bar_functions.dart';
import 'package:ismailmagdy/portfolio/repositories/visitor/visitor_service.dart';

class VisitorCountBadge extends StatefulWidget {
  const VisitorCountBadge({super.key});

  @override
  State<VisitorCountBadge> createState() => _VisitorCountBadgeState();
}

class _VisitorCountBadgeState extends State<VisitorCountBadge> {
  @override
  void initState() {
    super.initState();
    VisitorService.instance.fetchAndIncrement();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int?>(
      valueListenable: VisitorService.instance.count,
      builder: (context, count, _) {
        return Container(
          padding: const .symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: .circular(20),
            border: .all(color: Colors.white.withValues(alpha: 0.08), width: 1),
          ),
          child: Row(
            mainAxisSize: .min,
            children: [
              //
              const Icon(
                Icons.visibility_outlined,
                color: AppColors.primary,
                size: 14,
              ),
              //
              const SizedBox(width: 6),
              //
              if (count == null)
                const SizedBox(
                  width: 10,
                  height: 10,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.primary,
                  ),
                )
              //
              else
                //
                Text(
                  formatCount(count),
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: .w400,
                    color: Colors.white.withValues(alpha: 0.7),
                  ),
                ),
              //
            ],
          ),
        );
      },
    );
  }
}
// 77
