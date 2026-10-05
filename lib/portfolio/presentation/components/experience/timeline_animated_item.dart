import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class TimelineAnimatedItem extends StatefulWidget {
  const TimelineAnimatedItem({
    super.key,
    required this.index,
    required this.slideFromLeft,
    required this.child,
  });

  final int index;
  final bool slideFromLeft;
  final Widget child;

  @override
  State<TimelineAnimatedItem> createState() => TimelineAnimatedItemState();
}

class TimelineAnimatedItemState extends State<TimelineAnimatedItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  bool _hasAnimated = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    // Slide horizontally from the card's side + slight upward motion
    final horizontalOffset = widget.slideFromLeft ? -0.15 : 0.15;
    _slideAnimation = Tween<Offset>(
      begin: Offset(horizontalOffset, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (!_hasAnimated && info.visibleFraction > 0.15) {
      _hasAnimated = true;
      // Stagger based on index
      Future.delayed(Duration(milliseconds: 200 * widget.index), () {
        if (mounted) {
          _controller.forward();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key("timeline-item-${widget.index}"),
      onVisibilityChanged: _onVisibilityChanged,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(position: _slideAnimation, child: widget.child),
      ),
    );
  }
}
