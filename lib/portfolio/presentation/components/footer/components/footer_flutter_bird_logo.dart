import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ismailmagdy/core/theme/app_colors.dart';

class FooterFlutterBirdLogo extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return //
    Row(
      mainAxisSize: .min,
      children: [
        Text(
          "Built with",
          style: GoogleFonts.poppins(
            fontSize: 13,
            fontWeight: .w600,
            color: AppColors.textDark.withValues(alpha: 0.7),
          ),
        ),
        //
        Image.asset(
          "assets/images/icons/flutter_bird.png",
          height: 80,
          width: 80,
          fit: .contain,
        ),
        //
        Text(
          "Flutter",
          style: GoogleFonts.poppins(
            fontSize: 13,
            fontWeight: .w600,
            color: AppColors.textDark.withValues(alpha: 0.7),
          ),
        ),
        //
      ],
    );
    //
  }
}
