import 'package:flutter/material.dart';
import 'package:ismailmagdy/portfolio/presentation/components/nav_bar/nav_bar_desktop_view.dart';
import 'package:ismailmagdy/portfolio/presentation/components/nav_bar/nav_bar_mobile_view.dart';

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
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    // Mobile view with circular logo button
    if (isMobile) {
      return NavBarMobileView();
    }

    return SafeArea(
      // Desktop view with sliding pull-out navbar
      child: NavBarDesktopView(
        aboutKey: widget.aboutKey,
        experienceKey: widget.experienceKey,
        packagesKey: widget.packagesKey,
        projectsKey: widget.projectsKey,
        screenWidth: screenWidth,
        skillsKey: widget.skillsKey,
        scrollController: widget.scrollController,
      ),
      //
    );
  }
}
// 228
