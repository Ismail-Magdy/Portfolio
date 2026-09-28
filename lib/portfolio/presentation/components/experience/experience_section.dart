import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ismailmagdy/core/constants/app_strings.dart';
import 'package:ismailmagdy/core/helpers/spacing.dart';
import 'package:ismailmagdy/core/theme/app_colors.dart';
import 'package:ismailmagdy/core/theme/blueprint_provider.dart';
import 'package:ismailmagdy/portfolio/presentation/components/experience/experience_card.dart';
import 'package:ismailmagdy/portfolio/repositories/experience/experience_repository.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTabletOrDesktop = !isMobile;
    final repository = ExperienceRepository();
    final experiences = repository.getExperiences();

    return Container(
      constraints: const BoxConstraints(maxWidth: 1200),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 80,
        vertical: 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //
          // Section Header
          Builder(
            builder: (context) {
              final isBlueprint = context.watch<BlueprintProvider>().isBlueprintMode;
              return Column(
                children: [
                  Text(
                    AppStrings.professionalExperience,
                    textAlign: TextAlign.center,
                    style: isBlueprint
                        ? GoogleFonts.firaCode(
                            fontSize: isMobile ? 24 : 32,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textDark,
                            letterSpacing: 0.5,
                          )
                        : GoogleFonts.poppins(
                            fontSize: isMobile ? 28 : 36,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textDark,
                          ),
                  ),
                  verticalSpace(8),
                  Text(
                    AppStrings.myProfessionalJourneyInMobileDevelopment,
                    textAlign: TextAlign.center,
                    style: isBlueprint
                        ? GoogleFonts.firaCode(
                            fontSize: isMobile ? 13 : 15,
                            color: AppColors.primary.withValues(alpha: 0.6),
                            letterSpacing: 0.3,
                          )
                        : GoogleFonts.poppins(
                            fontSize: isMobile ? 15 : 18,
                            color: AppColors.textDark.withValues(alpha: 0.7),
                          ),
                  ),
                ],
              );
            },
          ),
          //
          verticalSpace(60),
          //
          // Timeline
          if (isTabletOrDesktop)
            _DesktopTimeline(experiences: experiences)
          else
            _MobileTimeline(experiences: experiences),
          //
        ],
      ),
    );
  }
}

class _DesktopTimeline extends StatelessWidget {
  const _DesktopTimeline({required this.experiences});
  final List experiences;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(experiences.length, (index) {
        final experience = experiences[index];
        final isLeft = index.isEven; // even = left, odd = right
        final isLast = index == experiences.length - 1;

        return _TimelineAnimatedItem(
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
                      child: _TimelineNode(),
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

class _MobileTimeline extends StatelessWidget {
  const _MobileTimeline({required this.experiences});
  final List experiences;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(experiences.length, (index) {
        final experience = experiences[index];
        final isLast = index == experiences.length - 1;

        return _TimelineAnimatedItem(
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
                        child: _TimelineNode(size: 14),
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

/// A glowing cyan dot used as the timeline node.
class _TimelineNode extends StatelessWidget {
  const _TimelineNode({this.size = 16});
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.primary,
        shape: BoxShape.circle,
        boxShadow: [
          // Outer glow
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.5),
            blurRadius: 12,
            spreadRadius: 2,
          ),
          // Inner bright ring
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 6,
            spreadRadius: 1,
          ),
        ],
      ),
      // Inner bright core
      child: Center(
        child: Container(
          width: size * 0.45,
          height: size * 0.45,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}

class _TimelineAnimatedItem extends StatefulWidget {
  const _TimelineAnimatedItem({
    required this.index,
    required this.slideFromLeft,
    required this.child,
  });

  final int index;
  final bool slideFromLeft;
  final Widget child;

  @override
  State<_TimelineAnimatedItem> createState() => _TimelineAnimatedItemState();
}

class _TimelineAnimatedItemState extends State<_TimelineAnimatedItem>
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
      key: Key('timeline-item-${widget.index}'),
      onVisibilityChanged: _onVisibilityChanged,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(position: _slideAnimation, child: widget.child),
      ),
    );
  }
}
