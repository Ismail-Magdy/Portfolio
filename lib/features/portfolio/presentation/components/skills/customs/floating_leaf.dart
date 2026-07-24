import 'package:flutter/material.dart';
import 'package:ismailmagdy/features/portfolio/presentation/components/skills/customs/floating_leaf_state.dart';

import '../../../../domain/models/skill_model.dart';

class FloatingLeaf extends StatefulWidget {
  final SkillModel skill;
  final bool isLeft;
  final int index;

  const FloatingLeaf({
    super.key,
    required this.skill,
    required this.isLeft,
    required this.index,
  });

  @override
  State<FloatingLeaf> createState() => FloatingLeafState();
}
