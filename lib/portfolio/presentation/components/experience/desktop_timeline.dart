import 'package:flutter/material.dart';
import 'package:ismailmagdy/core/theme/app_colors.dart';
import 'package:ismailmagdy/portfolio/presentation/components/experience/experience_card.dart';
import 'package:ismailmagdy/portfolio/presentation/components/experience/timeline_animated_item.dart';
import 'package:ismailmagdy/portfolio/presentation/components/experience/timeline_node.dart';

class DesktopTimeline extends StatelessWidget {
  const DesktopTimeline({super.key, required this.experiences});
  final List experiences;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(experiences.length, (index) {
        final experience = experiences[index];
        final isLeft = index.isEven; // even = left, odd = right
        final isLast = index == experiences.length - 1;

        return TimelineAnimatedItem(
          index: index,
          slideFromLeft: isLeft,
          child: Stack(
            children: [
              //
              // Timeline line — positioned behind, stretches full height
              if (!isLast)
                Positioned.fill(
                  child: Center(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Container(
                          width: 2,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                AppColors.primary.withValues(alpha: 0.4),
                                AppColors.primary.withValues(alpha: 0.15),
                              ],
                            ),
                          ),
                        ),
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
                  // Left card (or empty spacer)
                  Expanded(
                    child: isLeft
                        ? Padding(
                            padding: const EdgeInsets.only(
                              right: 24,
                              bottom: 32,
                            ),
                            child: ExperienceCard(experience: experience),
                          )
                        : const SizedBox.shrink(),
                  ),
                  //
                  // Center node (just the dot, no line)
                  SizedBox(
                    width: 24,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: TimelineNode(),
                    ),
                  ),
                  //
                  // Right card (or empty spacer)
                  Expanded(
                    child: !isLeft
                        ? Padding(
                            padding: const EdgeInsets.only(
                              left: 24,
                              bottom: 32,
                            ),
                            child: ExperienceCard(experience: experience),
                          )
                        : const SizedBox.shrink(),
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
