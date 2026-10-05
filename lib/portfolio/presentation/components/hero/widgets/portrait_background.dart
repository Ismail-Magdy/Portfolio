import 'package:flutter/material.dart';
import 'package:ismailmagdy/portfolio/presentation/components/hero/functions/portrait_background_functions.dart';
import 'package:ismailmagdy/portfolio/presentation/components/hero/widgets/tech_background_painter.dart';
import 'package:ismailmagdy/portfolio/presentation/components/hero/widgets/tech_element.dart';

class PortraitBackground extends StatefulWidget {
  final double width;
  final double height;

  const PortraitBackground({
    super.key,
    required this.width,
    required this.height,
  });

  @override
  State<PortraitBackground> createState() => _PortraitBackgroundState();
}

class _PortraitBackgroundState extends State<PortraitBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  final List<TechElement> _elements = [];

  @override
  void initState() {
    super.initState();
    initializeElements();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            size: Size(widget.width, widget.height),
            painter: TechBackgroundPainter(
              elements: _elements,
              progress: _controller.value,
            ),
          );
        },
      ),
    );
  }
}
// 160
