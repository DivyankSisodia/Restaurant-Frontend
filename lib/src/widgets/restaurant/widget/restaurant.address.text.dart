import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RestaurantSectionAddressText extends StatelessWidget {
  const RestaurantSectionAddressText({
    super.key,
    required this.address,
  });

  final String address;

  @override
  Widget build(BuildContext context) {
    return Text(
      address,
      style: TextStyle(
        fontSize: 16,
        color: Colors.black.withOpacity(0.9),
        fontFamily: GoogleFonts.poppins().fontFamily,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
