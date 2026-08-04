import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ismailmagdy/core/theme/app_colors.dart';
import 'package:ismailmagdy/portfolio/repositories/packages_repository.dart';
import 'package:ismailmagdy/portfolio/presentation/components/open_source/components/package_card.dart';

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

    final repository = PackagesRepository();
    final packages = repository.getPackages();

    return Container(
      constraints: const BoxConstraints(maxWidth: 1200),
      padding: .symmetric(horizontal: isMobile ? 12.0 : 24.0, vertical: 80),
      child: Column(
        crossAxisAlignment: .start,
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
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: packages.length,
            separatorBuilder: (context, index) => const SizedBox(height: 32),
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
