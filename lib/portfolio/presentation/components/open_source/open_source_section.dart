import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ismailmagdy/core/theme/app_colors.dart';
import 'package:ismailmagdy/portfolio/repositories/packages_repository.dart';
import 'package:ismailmagdy/portfolio/presentation/components/open_source/package_card.dart';

class OpenSourceSection extends StatefulWidget {
  const OpenSourceSection({super.key});

  @override
  State<OpenSourceSection> createState() => _OpenSourceSectionState();
}

class _OpenSourceSectionState extends State<OpenSourceSection> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 600;
    final bool isTablet = screenWidth >= 600 && screenWidth < 1024;

    final repository = PackagesRepository();
    final packages = repository.getPackages();

    return Container(
      constraints: const BoxConstraints(maxWidth: 1200),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 12.0 : 24.0,
        vertical: 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          Text(
            "Open Source & Packages",
            style: GoogleFonts.poppins(
              fontSize: 36,
              fontWeight: .bold,
              color: AppColors.textDark,
            ),
          ),
          //
          // Grid View of Packages
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile
                  ? 1
                  : isTablet
                      ? 2
                      : 3,
              crossAxisSpacing: 24,
              mainAxisSpacing: 24,
              childAspectRatio: isMobile
                  ? 0.8
                  : isTablet
                      ? 0.75
                      : 0.85,
            ),
            itemCount: packages.length,
            itemBuilder: (context, index) {
              return PackageCard(package: packages[index]);
            },
          ),
          //
        ],
      ),
    );
  }
}
