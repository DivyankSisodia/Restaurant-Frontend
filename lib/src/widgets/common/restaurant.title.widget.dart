import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RestaurantNameTitleWidget extends StatelessWidget {
  const RestaurantNameTitleWidget({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 21,
        color: Colors.black,
        fontFamily: GoogleFonts.poppins().fontFamily,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
