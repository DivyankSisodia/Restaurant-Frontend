import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RestaurantSectionDeliveryText extends StatelessWidget {
  const RestaurantSectionDeliveryText({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 12,
        color: Colors.black.withOpacity(0.5),
        fontFamily: GoogleFonts.poppins().fontFamily,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
