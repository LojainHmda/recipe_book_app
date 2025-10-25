import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe_book_app/theme/colors.dart';

class Fonts {
  static TextStyle h1 = GoogleFonts.cabin(
    fontSize: 24,
    fontWeight: FontWeight.bold,
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
  static TextStyle greenLables =  GoogleFonts.montserrat(
    fontSize: 14,
    color: AppColors.primaryColor,
  );
    static TextStyle mealNotes =  GoogleFonts.montserrat(
    fontSize: 9,
    color: Color(0xffC9CDC9),
  );
}
