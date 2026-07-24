import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

/// A wrapper widget that fades in and slides up when it becomes visible on screen.
///
/// WHY: Used for the Professional Experience section timeline, to provide a structured
/// "staggered entrance" effect precisely as the user scrolls it into view.
class StaggeredFadeIn extends StatefulWidget {
  final Widget child;
  final int index;
  final Duration baseDelay;

  const StaggeredFadeIn({
    super.key,
    required this.child,
    required this.index,
    this.baseDelay = const Duration(milliseconds: 150),
  });

  @override
  State<StaggeredFadeIn> createState() => _StaggeredFadeInState();
}

class _StaggeredFadeInState extends State<StaggeredFadeIn>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    // Fade in linearly
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    // Slide in from 20% down below the origin
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: .zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    // Only trigger animation once when 15% is visible
    if (!_isVisible && info.visibleFraction > 0.15) {
      _isVisible = true;
      // Stagger start time based on index, e.g., index 0 = 0ms, index 1 = 150ms...
      Future.delayed(widget.baseDelay * widget.index, () {
        if (mounted) {
          _controller.forward();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key("staggered-fade-in-${widget.index}"),
      onVisibilityChanged: _onVisibilityChanged,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(position: _slideAnimation, child: widget.child),
      ),
    );
  }
}
