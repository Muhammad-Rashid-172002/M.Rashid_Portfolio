// lib/theme/app_text_styles.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  static TextStyle heading(double size) => GoogleFonts.poppins(
    fontSize: size,
    fontWeight: FontWeight.w700,
    color: AppColors.text,
  );

  static TextStyle subtitle = GoogleFonts.poppins(
    fontSize: 15,
    color: AppColors.muted,
    height: 1.6,
    fontWeight: FontWeight.w400,
  );

  static TextStyle button = GoogleFonts.poppins(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static TextStyle small = GoogleFonts.poppins(
    fontSize: 13,
    color: AppColors.text,
  );

  static TextStyle caption = GoogleFonts.poppins(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.muted,
  );

  static TextTheme get textTheme => GoogleFonts.poppinsTextTheme();
}
