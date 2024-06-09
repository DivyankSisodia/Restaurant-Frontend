import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyle {
  static TextStyle cartScreenTitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    fontFamily: GoogleFonts.dmSans().fontFamily,
    letterSpacing: 1,
  );

  static TextStyle cartScreenSmallText = TextStyle(
    color: Colors.grey.shade700,
    fontFamily: GoogleFonts.dmSans().fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w300,
  );

  static TextStyle cartScreenSmallestText = TextStyle(
    color: Colors.grey.shade500,
    fontFamily: GoogleFonts.dmSans().fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w300,
  );

  static TextStyle cartScreenMediumText = TextStyle(
    fontFamily: GoogleFonts.dmSans().fontFamily,
    color: Colors.grey.shade800,
    fontSize: 15,
    fontWeight: FontWeight.w500,
  );

  static TextStyle smallPriceText = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    fontFamily: GoogleFonts.dmSans().fontFamily,
    letterSpacing: 1,
  );

  static TextStyle mediumPriceText = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    fontFamily: GoogleFonts.dmSans().fontFamily,
    letterSpacing: 1,
  );
}
