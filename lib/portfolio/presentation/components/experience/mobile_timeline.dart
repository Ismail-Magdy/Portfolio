import 'package:flutter/material.dart';
import 'package:ismailmagdy/core/helpers/spacing.dart';
import 'package:ismailmagdy/core/theme/app_colors.dart';
import 'package:ismailmagdy/portfolio/presentation/components/experience/experience_card.dart';
import 'package:ismailmagdy/portfolio/presentation/components/experience/timeline_animated_item.dart';
import 'package:ismailmagdy/portfolio/presentation/components/experience/timeline_node.dart';

class MobileTimeline extends StatelessWidget {
  const MobileTimeline({super.key, required this.experiences});
  final List experiences;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(experiences.length, (index) {
        final experience = experiences[index];
        final isLast = index == experiences.length - 1;

        return TimelineAnimatedItem(
          index: index,
          slideFromLeft: false, // Always slide from right on mobile
          child: Stack(
            children: [
              //
              // Timeline line — left-aligned, behind content
              if (!isLast)
                Positioned(
                  top: 11, // vertically centered with the 14px node
                  bottom: 0,
                  left: 9, // centered within the 20px left column (20/2 - 2/2)
                  child: Container(
                    width: 2,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColors.primary.withValues(alpha: 0.4),
                          AppColors.primary.withValues(alpha: 0.1),
                        ],
                      ),
                    ),
                  ),
                ),
              //
              // Content Row — drives the Stack's height
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //
                  // Left node area
                  SizedBox(
                    width: 20,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: TimelineNode(size: 14),
                      ),
                    ),
                  ),
                  //
                  horizontalSpace(16),
                  //
                  // Card
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 32),
                      child: ExperienceCard(experience: experience),
                    ),
                  ),
                  //
                ],
              ),
              //
            ],
          ),
        );
      }),
    );
  }
}
