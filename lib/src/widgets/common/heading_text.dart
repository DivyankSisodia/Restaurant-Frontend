import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeadingText extends StatelessWidget {
  const HeadingText({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 14.0,
        fontFamily: GoogleFonts.dmSans().fontFamily,
        color: Colors.grey[700],
        fontWeight: FontWeight.w600,
        letterSpacing: 2.0,
      ),
    );
  }
}
