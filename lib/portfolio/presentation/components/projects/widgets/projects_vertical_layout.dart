import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ismailmagdy/core/helpers/spacing.dart';
import 'package:ismailmagdy/core/theme/app_colors.dart';
import 'package:ismailmagdy/portfolio/models/projects/project_model.dart';
import 'package:ismailmagdy/portfolio/models/projects/team_member.dart';
import 'package:ismailmagdy/portfolio/presentation/components/open_source/widgets/hover_action_button.dart';
import 'package:ismailmagdy/portfolio/presentation/components/open_source/widgets/sweep_border_painter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';

// TODO : MAKE CODE MORE CLEAN
class ProjectsVerticalLayout extends StatelessWidget {
  const ProjectsVerticalLayout({
    super.key,
    required this.isMobile,
    required this.project,
    required this.borderGlowController,
    required this.fadeAnimation,
    required this.slideAnimation,
    required this.chipStaggerController,
    this.onVisibilityChanged,
    required this.teamStaggerController,
  });

  final bool isMobile;
  final ProjectModel project;
  final AnimationController borderGlowController;
  final Animation<double> fadeAnimation;
  final Animation<Offset> slideAnimation;
  final AnimationController chipStaggerController;
  final void Function(VisibilityInfo)? onVisibilityChanged;
  final AnimationController teamStaggerController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .center,
      children: [
        //
        Text(
          project.title,
          textAlign: .center,
          style: GoogleFonts.poppins(
            fontSize: isMobile ? 32 : 48,
            fontWeight: .bold,
            color: AppColors.textDark,
            height: 1.2,
          ),
        ),
        //
        verticalSpace(32),
        //
        _buildWideImage(isMobile),
        //
        verticalSpace(28),
        //
        Text(
          project.shortDescription,
          textAlign: .center,
          style: GoogleFonts.poppins(
            fontSize: isMobile ? 15 : 17,
            color: AppColors.textDark.withValues(alpha: 0.6),
            fontWeight: .w400,
            height: 1.5,
          ),
        ),
        //
        verticalSpace(48),
        //
        isMobile ? _buildMobileTwoSection() : _buildDesktopTwoColumn(),
        //
        verticalSpace(48),
        // Meet the Team section (if available)
        if (project.teamMembers != null && project.teamMembers!.isNotEmpty)
          _buildTeamSection(isMobile),

        // Action buttons
        _buildActionButtons(isMobile),
        //
      ],
    );
  }

  Widget _buildWideImage(bool isMobile) {
    const double borderPad = 4.0;
    const double borderRadius = 20.0;

    return RepaintBoundary(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 920),
        child: AnimatedBuilder(
          animation: borderGlowController,
          builder: (context, child) {
            return CustomPaint(
              foregroundPainter: SweepBorderPainter(
                progress: borderGlowController.value,
                borderRadius: borderRadius + borderPad,
                padding: borderPad,
                glowColor: AppColors.primary,
              ),
              child: child,
            );
          },
          child: Padding(
            padding: const .all(borderPad),
            child: Hero(
              tag: project.title,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: .circular(borderRadius),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.10),
                      blurRadius: 30,
                      spreadRadius: 2,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: .circular(borderRadius),
                  child: Image.asset(
                    project.imageIn,
                    fit: .contain,
                    width: .infinity,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 300,
                        color: AppColors.primary.withValues(alpha: 0.1),
                        child: const Icon(
                          Icons.image,
                          size: 80,
                          color: AppColors.primary,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Desktop two-column: left = description, right = tech stack
  Widget _buildDesktopTwoColumn() {
    return Row(
      crossAxisAlignment: .start,
      children: [
        // Left Description with fade-in slide-up
        Expanded(flex: 60, child: _buildAnimatedDescription()),
        const SizedBox(width: 48),
        // Right Tech stack with staggered chips
        Expanded(flex: 40, child: _buildAnimatedTechStack()),
      ],
    );
  }

  /// Mobile stacked: description then tech stack
  Widget _buildMobileTwoSection() {
    return Column(
      crossAxisAlignment: .start,
      children: [
        _buildAnimatedDescription(),
        verticalSpace(36),
        _buildAnimatedTechStack(),
      ],
    );
  }

  /// Description with fade-in + slide-up entrance animation
  Widget _buildAnimatedDescription() {
    return FadeTransition(
      opacity: fadeAnimation,
      child: SlideTransition(
        position: slideAnimation,
        child: Column(
          crossAxisAlignment: .start,
          children: [
            // Section heading
            Row(
              children: [
                //
                Container(
                  width: 4,
                  height: 24,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: .circular(2),
                  ),
                ),
                //
                const SizedBox(width: 12),
                //
                Text(
                  "About This Project",
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: .w600,
                    color: AppColors.textDark,
                  ),
                ),
                //
              ],
            ),
            verticalSpace(20),
            // Long description
            Text(
              project.longDescription,
              style: GoogleFonts.poppins(
                fontSize: 15,
                height: 1.8,
                color: AppColors.textDark.withValues(alpha: 0.75),
              ),
            ),
            //
          ],
        ),
      ),
    );
  }

  /// Tech stack section with staggered chip animations
  Widget _buildAnimatedTechStack() {
    final chips = project.techStack;
    return Column(
      crossAxisAlignment: .start,
      children: [
        // Section heading
        Row(
          children: [
            //
            Container(
              width: 4,
              height: 24,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: .circular(2),
              ),
            ),
            //
            const SizedBox(width: 12),
            //
            Text(
              "Technologies Used",
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: .w600,
                color: AppColors.textDark,
              ),
            ),
            //
          ],
        ),
        verticalSpace(20),
        // Staggered chips
        Wrap(
          spacing: 10,
          runSpacing: 12,
          children: List.generate(chips.length, (index) {
            // Stagger each chip's appearance
            final intervalStart = index / (chips.length + 1);
            final intervalEnd = (index + 1) / (chips.length + 1);
            final chipAnimation = CurvedAnimation(
              parent: chipStaggerController,
              curve: Interval(
                intervalStart,
                intervalEnd.clamp(0.0, 1.0),
                curve: Curves.easeOutBack,
              ),
            );

            return AnimatedBuilder(
              animation: chipAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: chipAnimation.value,
                  child: Opacity(
                    opacity: chipAnimation.value.clamp(0.0, 1.0),
                    child: child,
                  ),
                );
              },
              child: Container(
                padding: const .symmetric(horizontal: 18, vertical: 10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary.withValues(alpha: 0.18),
                      AppColors.primary.withValues(alpha: 0.08),
                    ],
                  ),
                  borderRadius: .circular(24),
                  border: .all(color: AppColors.primary.withValues(alpha: 0.3)),
                ),
                child: Text(
                  chips[index],
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: AppColors.primary,
                    fontWeight: .w500,
                  ),
                ),
              ),
            );
          }),
        ),
        //
      ],
    );
  }

  /// Dynamic action buttons — only renders buttons whose URL is non-null
  Widget _buildActionButtons(bool isMobile) {
    final projectVar = project;

    // Build the list of buttons conditionally
    final List<Widget> buttons = [];

    if (projectVar.github != null) {
      buttons.add(
        _buildActionButton(
          icon: FontAwesomeIcons.github,
          label: "GitHub",
          url: project.github!,
          isPrimary: false,
        ),
      );
    }

    if (projectVar.linkedIn != null) {
      buttons.add(
        _buildActionButton(
          icon: FontAwesomeIcons.linkedin,
          label: "LinkedIn",
          url: project.linkedIn!,
          isPrimary: true,
        ),
      );
    }

    if (projectVar.linkedInPartTwo != null) {
      buttons.add(
        _buildActionButton(
          icon: FontAwesomeIcons.linkedin,
          label: "LinkedIn Pt.2",
          url: project.linkedInPartTwo!,
          isPrimary: true,
        ),
      );
    }

    if (projectVar.instagram != null) {
      buttons.add(
        _buildActionButton(
          icon: FontAwesomeIcons.instagram,
          label: "Instagram",
          url: project.instagram!,
          isPrimary: true,
          gradientColors: [
            const Color(0xFFF58529),
            const Color(0xFFDD2A7B),
            const Color(0xFF8134AF),
          ],
        ),
      );
    }

    if (projectVar.tiktok != null) {
      buttons.add(
        _buildActionButton(
          icon: FontAwesomeIcons.tiktok,
          label: "TikTok",
          url: project.tiktok!,
          isPrimary: true,
          gradientColors: [const Color(0xFF00F2EA), const Color(0xFFFF0050)],
        ),
      );
    }

    if (projectVar.websiteLink != null) {
      buttons.add(
        _buildActionButton(
          icon: FontAwesomeIcons.globe,
          label: "Website",
          url: project.websiteLink!,
          isPrimary: true,
        ),
      );
    }

    if (projectVar.figmaLink != null && project.figmaLink!.isNotEmpty) {
      buttons.add(
        _buildActionButton(
          icon: FontAwesomeIcons.figma,
          label: "Figma",
          url: project.figmaLink!,
          isPrimary: true,
        ),
      );
    }

    if (buttons.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        // Divider
        Container(
          width: 60,
          height: 2,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(1),
          ),
        ),
        verticalSpace(32),
        Wrap(
          spacing: 14,
          runSpacing: 12,
          alignment: .center,
          children: buttons,
        ),
      ],
    );
  }

  /// A single stylish action button
  Widget _buildActionButton({
    required FaIconData icon,
    required String label,
    required String url,
    bool isPrimary = false,
    List<Color>? gradientColors,
  }) {
    return HoverActionButton(
      icon: icon,
      label: label,
      url: url,
      isPrimary: isPrimary,
      gradientColors: gradientColors,
      onTap: () => _launchUrl(url),
    );
  }

  /// "Meet the Team" section with staggered entrance animations
  Widget _buildTeamSection(bool isMobile) {
    final members = project.teamMembers!;
    return VisibilityDetector(
      key: const Key("team-section"),
      onVisibilityChanged: onVisibilityChanged,
      child: Column(
        crossAxisAlignment: .start,
        children: [
          // Section heading
          Row(
            mainAxisAlignment: .center,
            children: [
              Container(
                width: 4,
                height: 24,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                "Meet the Team",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark,
                ),
              ),
            ],
          ),
          verticalSpace(28),
          // Horizontal scrollable list of team cards
          SizedBox(
            height: isMobile ? 200 : 230,
            child: Center(
              child: ListView.separated(
                scrollDirection: .horizontal,
                shrinkWrap: true,
                padding: .symmetric(horizontal: isMobile ? 8 : 24),
                itemCount: members.length,
                separatorBuilder: (_, _) => const SizedBox(width: 20),
                itemBuilder: (context, index) {
                  return _buildTeamMemberCard(
                    members[index],
                    index,
                    members.length,
                    isMobile,
                  );
                },
              ),
            ),
          ),
          verticalSpace(48),
        ],
      ),
    );
  }

  /// A single premium team member card with glowing avatar
  Widget _buildTeamMemberCard(
    TeamMember member,
    int index,
    int total,
    bool isMobile,
  ) {
    // Stagger each card's appearance
    final intervalStart = index / (total + 1);
    final intervalEnd = (index + 1.5) / (total + 1);
    final cardAnimation = CurvedAnimation(
      parent: teamStaggerController,
      curve: Interval(
        intervalStart,
        intervalEnd.clamp(0.0, 1.0),
        curve: Curves.easeOutCubic,
      ),
    );

    final avatarSize = isMobile ? 72.0 : 90.0;
    final cardWidth = isMobile ? 120.0 : 150.0;

    return AnimatedBuilder(
      animation: cardAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 24 * (1 - cardAnimation.value)),
          child: Opacity(
            opacity: cardAnimation.value.clamp(0.0, 1.0),
            child: child,
          ),
        );
      },
      child: SizedBox(
        width: cardWidth,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Glowing avatar container
            _buildGlowingAvatar(member.imagePath, avatarSize),
            const SizedBox(height: 14),
            // Name
            Text(
              member.name,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                fontSize: isMobile ? 12 : 13,
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 4),
            // Role
            Text(
              member.role,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                fontSize: isMobile ? 10 : 11,
                fontWeight: FontWeight.w400,
                color: AppColors.textDark.withValues(alpha: 0.50),
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Circle avatar with animated glowing cyan/glassmorphic border
  Widget _buildGlowingAvatar(String imagePath, double size) {
    return AnimatedBuilder(
      animation: borderGlowController,
      builder: (context, child) {
        final glowOpacity =
            0.35 + 0.30 * math.sin(borderGlowController.value * 2 * math.pi);
        return Container(
          width: size + 8,
          height: size + 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: SweepGradient(
              startAngle: borderGlowController.value * 2 * math.pi,
              colors: [
                AppColors.primary.withValues(alpha: glowOpacity),
                AppColors.primary.withValues(alpha: 0.05),
                AppColors.primary.withValues(alpha: glowOpacity * 0.7),
                AppColors.primary.withValues(alpha: 0.05),
                AppColors.primary.withValues(alpha: glowOpacity),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: glowOpacity * 0.5),
                blurRadius: 16,
                spreadRadius: 1,
              ),
            ],
          ),
          child: child,
        );
      },
      child: Center(
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.backgroundDark,
            border: Border.all(color: AppColors.backgroundDark, width: 3),
          ),
          child: ClipOval(
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              width: size,
              height: size,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: AppColors.primary.withValues(alpha: 0.15),
                  child: Icon(
                    Icons.person,
                    size: size * 0.5,
                    color: AppColors.primary,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: .externalApplication);
    }
  }
}
//656
