import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PricePerFoodWidget extends StatelessWidget {
  const PricePerFoodWidget({
    super.key,
    required this.particularFoodPrirce,
  });

  final int particularFoodPrirce;

  @override
  Widget build(BuildContext context) {
    return Text(
      '₹$particularFoodPrirce',
      style: TextStyle(
        fontFamily: GoogleFonts.dmSans().fontFamily,
        fontSize: 16,
        color: Colors.grey.shade800,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

