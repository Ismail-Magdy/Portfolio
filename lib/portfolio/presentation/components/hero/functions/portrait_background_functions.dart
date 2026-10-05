import 'dart:math';

import 'package:ismailmagdy/portfolio/presentation/components/hero/widgets/tech_element.dart';

final List<TechElement> _elements = [];

void initializeElements() {
  final rand = Random();
  for (int i = 0; i < 20; i++) {
    _elements.add(
      TechElement(
        startX: rand.nextDouble(),
        startY: rand.nextDouble(),
        speedY: (rand.nextDouble() * 0.1) + 0.05,
        size: rand.nextDouble() * 35 + 15,
        opacity: rand.nextDouble() * 0.25 + 0.05,
        isOutline: rand.nextBool(),
      ),
    );
  }
}
