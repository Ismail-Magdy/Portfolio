import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ismailmagdy/core/theme/app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme => ThemeData(
    brightness: .light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.backgroundLight,
    colorScheme: .light(
      primary: AppColors.primary,
      surface: AppColors.cardBackgroundLight,
    ),
    textTheme: GoogleFonts.poppinsTextTheme(
      ThemeData.light().textTheme.copyWith(
        bodyLarge: TextStyle(color: AppColors.textLight),
        bodyMedium: TextStyle(color: AppColors.textLight),
        bodySmall: TextStyle(color: AppColors.textLight),
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.backgroundLight,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.textLight),
      titleTextStyle: GoogleFonts.poppins(
        color: AppColors.textLight,
        fontSize: 18,
        fontWeight: .w600,
      ),
    ),
    cardTheme: CardThemeData(
      color: AppColors.cardBackgroundLight,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: .circular(12)),
    ),
  );

  static ThemeData get darkTheme => ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.backgroundDark,
    colorScheme: .dark(
      primary: AppColors.primary,
      surface: AppColors.cardBackgroundDark,
    ),
    textTheme: GoogleFonts.poppinsTextTheme(
      ThemeData.dark().textTheme.copyWith(
        bodyLarge: TextStyle(color: AppColors.textDark),
        bodyMedium: TextStyle(color: AppColors.textDark),
        bodySmall: TextStyle(color: AppColors.textDark),
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.backgroundDark,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.textDark),
      titleTextStyle: GoogleFonts.poppins(
        color: AppColors.textDark,
        fontSize: 18,
        fontWeight: .w600,
      ),
    ),
    cardTheme: CardThemeData(
      color: AppColors.cardBackgroundDark,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: .circular(12)),
    ),
  );
}
