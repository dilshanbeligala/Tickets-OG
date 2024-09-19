import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils_barrel.dart';

class ThemeState {
  final ThemeData themeData;
  final bool isDark;

  ThemeState(this.themeData, this.isDark);

  static ThemeState get darkTheme => ThemeState(
    ThemeData.dark().copyWith(
      primaryColor: AppColors.primaryColor[50],
      secondaryHeaderColor: AppColors.primaryColor[900],
      inputDecorationTheme: const InputDecorationTheme(
        fillColor: Color(0XFF1F67CD),
        focusColor: Colors.lightBlue,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0XFF1E293B)),
        ),
      ),
      textTheme: TextTheme(
        headlineLarge: GoogleFonts.figtree(
            color: AppColors.neutralColor[100], fontSize: 40),
        headlineMedium: GoogleFonts.figtree(
            color: AppColors.neutralColor[100], fontSize: 32),
        headlineSmall: GoogleFonts.figtree(
            color: AppColors.neutralColor[100], fontSize: 28),
        titleLarge: GoogleFonts.figtree(
            color: AppColors.neutralColor[100], fontSize: 24),
        titleMedium: GoogleFonts.figtree(
            color: AppColors.neutralColor[100], fontSize: 22),
        titleSmall: GoogleFonts.figtree(
            color: AppColors.neutralColor[100], fontSize: 20),
        labelLarge: GoogleFonts.figtree(
            color: AppColors.neutralColor[100], fontSize: 18),
        labelMedium: GoogleFonts.figtree(
            color: AppColors.neutralColor[100], fontSize: 16),
        labelSmall: GoogleFonts.figtree(
            color: AppColors.neutralColor[100], fontSize: 14),
        bodyLarge: GoogleFonts.figtree(
            color: AppColors.neutralColor[100], fontSize: 13),
        bodyMedium: GoogleFonts.figtree(
            color: AppColors.neutralColor[100], fontSize: 12),
        bodySmall: GoogleFonts.figtree(
            color: AppColors.neutralColor[100], fontSize: 10),
      ),
    ),
    true,
  );

  static ThemeState get lightTheme => ThemeState(
    ThemeData.light().copyWith(
      primaryColor: AppColors.primaryColor[500],
      secondaryHeaderColor: AppColors.primaryColor[50],
      inputDecorationTheme: const InputDecorationTheme(
        fillColor: Color(0XFF1F67CD),
        focusColor: Colors.blue,
        suffixIconColor: Color(0XFF1E293B),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
      textTheme: TextTheme(
        headlineLarge: GoogleFonts.figtree(
            color: AppColors.neutralColor[900], fontSize: 40),
        headlineMedium: GoogleFonts.figtree(
            color: AppColors.neutralColor[900], fontSize: 32),
        headlineSmall: GoogleFonts.figtree(
            color: AppColors.neutralColor[900], fontSize: 28),
        titleLarge: GoogleFonts.figtree(
            color: AppColors.neutralColor[900], fontSize: 24),
        titleMedium: GoogleFonts.figtree(
            color: AppColors.neutralColor[900], fontSize: 22),
        titleSmall: GoogleFonts.figtree(
            color: AppColors.neutralColor[900], fontSize: 20),
        labelLarge: GoogleFonts.figtree(
            color: AppColors.neutralColor[900], fontSize: 18),
        labelMedium: GoogleFonts.figtree(
            color: AppColors.neutralColor[900], fontSize: 16),
        labelSmall: GoogleFonts.figtree(
            color: AppColors.neutralColor[900], fontSize: 14),
        bodyLarge: GoogleFonts.figtree(
            color: AppColors.neutralColor[900], fontSize: 13),
        bodyMedium: GoogleFonts.figtree(
            color: AppColors.neutralColor[900], fontSize: 12),
        bodySmall: GoogleFonts.figtree(
            color: AppColors.neutralColor[900], fontSize: 10),
      ),
    ),
    false,
  );
}
