import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ismailmagdy/core/theme/app_colors.dart';
import 'package:ismailmagdy/portfolio/repositories/visitor/visitor_service.dart';

/// A minimalist badge that displays the live visitor count.
///
/// Shows a tiny spinner while the count is loading, then the number
/// next to a subtle icon. Designed to sit beside the navbar logo.
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
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.08),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.visibility_outlined,
                color: AppColors.primary,
                size: 14,
              ),
              const SizedBox(width: 6),
              if (count == null)
                const SizedBox(
                  width: 10,
                  height: 10,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.primary,
                  ),
                )
              else
                Text(
                  _formatCount(count),
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.white.withValues(alpha: 0.7),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  /// Formats large numbers with K/M suffixes for compactness.
  String _formatCount(int n) {
    if (n >= 1000000) return '${(n / 1000000).toStringAsFixed(1)}M';
    if (n >= 1000) return '${(n / 1000).toStringAsFixed(1)}K';
    return n.toString();
  }
}
