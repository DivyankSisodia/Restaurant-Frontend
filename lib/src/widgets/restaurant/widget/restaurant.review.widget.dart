import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../model/restaurant.model.dart';

class RestaurantReviews extends StatelessWidget {
  const RestaurantReviews({
    super.key,
    required this.height,
    required this.width,
    required this.restaurant,
  });

  final double height;
  final double width;
  final Restaurants restaurant;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          height: height * 0.04,
          width: width * 0.13,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.green,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.star,
                color: Colors.white,
                size: 20,
              ),
              const Gap(5),
              Text(
                restaurant.rating.toString(),
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const Gap(5),
        Text(
          '100 Reviews',
          style: TextStyle(
            fontSize: 10,
            color: Colors.black.withOpacity(0.8),
            fontFamily: GoogleFonts.poppins().fontFamily,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
