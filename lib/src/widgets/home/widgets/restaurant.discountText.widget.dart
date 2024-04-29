import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class RestaurantDiscountTextWidget extends StatelessWidget {
  const RestaurantDiscountTextWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.02,
              bottom: MediaQuery.of(context).size.width * 0.01,
            ),
            child: Image.asset(
              'assets/icons/discount-logo.png',
              color: Colors.blue,
              height: 30,
            ),
          ),
          const Gap(5),
          Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.02,
              bottom: MediaQuery.of(context).size.width * 0.011,
            ),
            child: Text(
              '30% OFF on all orders',
              style: TextStyle(
                fontSize: 13,
                color: const Color.fromARGB(255, 7, 82, 143),
                fontFamily: GoogleFonts.poppins().fontFamily,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
