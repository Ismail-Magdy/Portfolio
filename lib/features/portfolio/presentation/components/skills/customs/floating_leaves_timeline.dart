import 'package:flutter/material.dart';
import 'package:ismailmagdy/features/portfolio/presentation/components/skills/customs/floating_leaf.dart';
import 'package:ismailmagdy/features/portfolio/presentation/components/skills/customs/time_line_spine_painter.dart';
import 'package:ismailmagdy/features/portfolio/presentation/components/skills/customs/timeline_branch_painter.dart';
import '../../../../domain/models/skill_model.dart';

class FloatingLeavesTimeline extends StatelessWidget {
  final List<SkillModel> topSkills;

  const FloatingLeavesTimeline({super.key, required this.topSkills});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;
        final centerGap = isMobile ? 60.0 : 120.0;

        return Stack(
          children: [
            // Vertical Spine Line
            Positioned.fill(
              child: CustomPaint(
                painter: TimelineSpinePainter(
                  isMobile: isMobile,
                  centerGap: centerGap,
                ),
              ),
            ),

            // Nodes mapped perfectly to Top 5 Skills
            Column(
              children: topSkills.asMap().entries.map((entry) {
                final int i = entry.key;
                final skill = entry.value;
                final bool isLeftNode = isMobile ? false : (i % 2 == 0);

                return SizedBox(
                  height: 90.0,
                  child: Row(
                    children: [
                      // Left Content
                      if (!isMobile)
                        Expanded(
                          child: isLeftNode
                              ? Align(
                                  alignment: .centerRight,
                                  child: FloatingLeaf(
                                    skill: skill,
                                    isLeft: true,
                                    index: i,
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ),

                      // Horizontal Branches
                      SizedBox(
                        width: centerGap,
                        child: CustomPaint(
                          painter: TimelineBranchPainter(
                            isLeftNode: isLeftNode,
                            isMobile: isMobile,
                          ),
                        ),
                      ),

                      // Right Content
                      Expanded(
                        child: !isLeftNode
                            ? Align(
                                alignment: .centerLeft,
                                child: FloatingLeaf(
                                  skill: skill,
                                  isLeft: false,
                                  index: i,
                                ),
                              )
                            : const SizedBox.shrink(),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }
}
//100