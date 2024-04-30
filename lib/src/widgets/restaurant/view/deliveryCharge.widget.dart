import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class DeliveryChargesWidget extends StatelessWidget {
  const DeliveryChargesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Image.asset(
            'assets/icons/delivery_boy.png',
            height: 25,
            width: 25,
            color: Colors.grey.shade700,
          ),
          const Gap(8),
          Container(
            height: 20,
            width: 1.5,
            color: Colors.grey.shade700,
          ),
          const Gap(8),
          Text(
            '₹46 for delivery',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade700,
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
