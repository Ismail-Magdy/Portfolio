import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ismailmagdy/portfolio/presentation/components/nav_bar/logo_widget.dart';

class NavBarMobileView extends StatelessWidget {
  const NavBarMobileView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const .only(top: 20, left: 24, right: 24),
        child: Row(
          children: [
            Container(
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
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: const Center(child: LogoWidget()),
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
