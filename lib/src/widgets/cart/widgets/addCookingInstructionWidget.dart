import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class CartFoodCookingInstructionWidget extends StatelessWidget {
  const CartFoodCookingInstructionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Add Cooking Requests',
            style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontFamily: GoogleFonts.dmSans().fontFamily,
                letterSpacing: 1),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Iconsax.chart),
              color: Colors.black,
              iconSize: 20,
            ),
          )
        ],
      ),
    );
  }
}

