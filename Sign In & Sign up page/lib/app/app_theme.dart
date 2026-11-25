import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// Material 3 theme: Poppins for headings, Inter for body/forms.
class AppTheme {
  AppTheme._();

  static ThemeData get light {
    final base = ThemeData(useMaterial3: true, brightness: Brightness.light);
    final body = GoogleFonts.interTextTheme(base.textTheme);
    final textTheme = body.copyWith(
      headlineLarge: GoogleFonts.poppins(
          fontSize: 28, fontWeight: FontWeight.w600, color: AppColors.forestGreen),
      headlineMedium: GoogleFonts.poppins(
          fontSize: 24, fontWeight: FontWeight.w600, color: AppColors.forestGreen),
      titleMedium: GoogleFonts.poppins(
          fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.darkCharcoal),
      bodyLarge: GoogleFonts.inter(fontSize: 15, color: AppColors.darkCharcoal),
      bodyMedium: GoogleFonts.inter(fontSize: 14, color: AppColors.mutedGray, height: 1.45),
      labelLarge: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w600),
    );

    OutlineInputBorder border(Color c, [double w = 1]) => OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: c, width: w),
        );

    return base.copyWith(
      scaffoldBackgroundColor: AppColors.warmIvory,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.forestGreen,
        primary: AppColors.forestGreen,
        onPrimary: AppColors.pureWhite,
        secondary: AppColors.sageGreen,
        tertiary: AppColors.softGold,
        surface: AppColors.pureWhite,
        onSurface: AppColors.darkCharcoal,
        error: AppColors.error,
      ),
      textTheme: textTheme,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.pureWhite,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        hintStyle: GoogleFonts.inter(fontSize: 14, color: AppColors.mutedGray),
        prefixIconColor: AppColors.mutedGray,
        suffixIconColor: AppColors.mutedGray,
        border: border(AppColors.borderGray),
        enabledBorder: border(AppColors.borderGray),
        focusedBorder: border(AppColors.forestGreen, 1.5),
        errorBorder: border(AppColors.error),
        focusedErrorBorder: border(AppColors.error, 1.5),
        errorStyle: GoogleFonts.inter(fontSize: 12, color: AppColors.error),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.darkCharcoal,
        contentTextStyle: GoogleFonts.inter(color: AppColors.pureWhite, fontSize: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
