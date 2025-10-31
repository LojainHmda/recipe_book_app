import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe_book_app/theme/colors.dart';

class Fonts {
  static TextStyle titlesFont24 = GoogleFonts.cabin(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static TextStyle titlesFont32 = GoogleFonts.cabin(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.darkGreen1,
  );
  static TextStyle darkGreen16 = GoogleFonts.montserrat(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: AppColors.darkGreen,
  );
  static TextStyle white160 = GoogleFonts.montserrat(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.5,
    letterSpacing: -0.01,
    color: Colors.white,
  );
  static TextStyle darkGreen20 = GoogleFonts.cabin(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.darkGreen,
  );
  static TextStyle darkGreen15 = GoogleFonts.montserrat(
    fontSize: 15,
    height: 1.5,

    fontWeight: FontWeight.w500,
    color: AppColors.darkGreen3,
  );

  static TextStyle darkGreen12 = GoogleFonts.montserrat(
    fontSize: 12,
    color: AppColors.darkGreen3,
  );

  static TextStyle primaryColor14 = GoogleFonts.montserrat(
    fontSize: 14,
    letterSpacing: 0.05,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryColor,
  );

  static TextStyle h1W = GoogleFonts.cabin(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static TextStyle F13 = GoogleFonts.cabin(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static TextStyle h2 = GoogleFonts.cabin(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
  static TextStyle h6 = GoogleFonts.montserrat(
    fontSize: 13,
    color: Color(0xffC9CDC9),
  );

  static TextStyle mealNotes = GoogleFonts.montserrat(
    fontSize: 9,
    color: Color(0xffC9CDC9),
  );

  static TextStyle white16 = GoogleFonts.montserrat(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
}
