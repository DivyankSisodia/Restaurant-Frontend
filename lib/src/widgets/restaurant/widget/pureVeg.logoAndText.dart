import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class PureVegIconAndText extends StatelessWidget {
  const PureVegIconAndText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Image.asset(
            'assets/icons/vegetarian.png',
            height: 20,
            color: Colors.green[700],
          ),
          const Gap(2),
          Text(
            'Pure Veg',
            style: TextStyle(
              fontSize: 14,
              color: Colors.green[700],
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
