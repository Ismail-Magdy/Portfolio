import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ismailmagdy/core/theme/app_colors.dart';
import 'package:ismailmagdy/core/constants/app_strings.dart';
import 'logo_widget.dart';

class Navbar extends StatefulWidget implements PreferredSizeWidget {
  final GlobalKey aboutKey;
  final GlobalKey projectsKey;
  final GlobalKey skillsKey;
  final GlobalKey packagesKey;
  final GlobalKey experienceKey;

  final ScrollController scrollController;

  const Navbar({
    super.key,
    required this.aboutKey,
    required this.projectsKey,
    required this.skillsKey,
    required this.packagesKey,
    required this.experienceKey,
    required this.scrollController,
  });

  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  bool _isDrawerOpen = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _scrollToSection(GlobalKey key, BuildContext context) {
    final keyContext = key.currentContext;
    if (keyContext != null) {
      Scrollable.ensureVisible(
        keyContext,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
    if (_isDrawerOpen) {
      Navigator.of(context).pop();
      setState(() => _isDrawerOpen = false);
    }
  }

  void _scrollToTop(BuildContext context) {
    widget.scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    if (_isDrawerOpen) {
      Navigator.of(context).pop();
      setState(() => _isDrawerOpen = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    // Mobile view with circular logo button
    if (isMobile) {
      return SafeArea(
        child: Align(
          alignment: .centerLeft,
          child: Container(
            margin: const .only(top: 20, left: 24),
            height: 64,
            width: 64,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              shape: .circle,
              border: .all(
                color: Colors.white.withValues(alpha: 0.1),
                width: 1,
              ),
            ),
            child: ClipOval(
              child: BackdropFilter(
                filter: .blur(sigmaX: 10, sigmaY: 10),
                child: Center(child: const LogoWidget()),
              ),
            ),
          ),
        ),
      );
    }

    return SafeArea(
      // Desktop view with sliding pull-out navbar
      child: Align(
        alignment: .centerLeft,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          margin: const .only(top: 20, left: 24, right: 24),
          height: 64,
          width: screenWidth - 48,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: .circular(32),
            border: .all(color: Colors.white.withValues(alpha: 0.1), width: 1),
          ),
          // Liquid glass effect
          child: ClipRRect(
            borderRadius: .circular(32),
            child: BackdropFilter(
              filter: .blur(sigmaX: 5, sigmaY: 5),
              child: SingleChildScrollView(
                scrollDirection: .horizontal,
                physics: const NeverScrollableScrollPhysics(),
                child: SizedBox(
                  width: screenWidth - 48,
                  height: 64,
                  child: Stack(
                    alignment: .centerLeft,
                    children: [
                      // Logo
                      Positioned(
                        left: 0,
                        child: GestureDetector(
                          onTap: () {
                            _scrollToTop(context);
                          },
                          child: Container(
                            width: 64,
                            height: 64,
                            alignment: .center,
                            child: const LogoWidget(),
                          ),
                        ),
                      ),
                      //
                      // Navigation
                      Positioned(
                        right: 20,
                        child: Row(
                          mainAxisSize: .min,
                          children: [
                            //
                            _buildNavItem(
                              AppStrings.about,
                              null,
                              onTap: () => _scrollToTop(context),
                            ),
                            //
                            const SizedBox(width: 20),
                            //
                            _buildNavItem(AppStrings.skills, widget.skillsKey),
                            //
                            const SizedBox(width: 20),
                            //
                            _buildNavItem(
                              AppStrings.projects,
                              widget.projectsKey,
                            ),
                            //
                            const SizedBox(width: 20),
                            //
                            _buildNavItem(
                              AppStrings.experience,
                              widget.experienceKey,
                            ),
                            //
                            const SizedBox(width: 20),
                            //
                            _buildNavItem(
                              AppStrings.packages,
                              widget.packagesKey,
                            ),
                          ],
                        ),
                      ),
                      //
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(String label, GlobalKey? key, {VoidCallback? onTap}) {
    return Builder(
      builder: (context) => TextButton(
        onPressed: onTap ?? () => _scrollToSection(key!, context),
        style: TextButton.styleFrom(
          padding: const .symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: .circular(20)),
          foregroundColor: Colors.white.withValues(alpha: 0.1),
        ),
        child: Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: .w500,
            color: AppColors.backgroundLight,
          ),
        ),
      ),
    );
  }
}
