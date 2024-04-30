import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../model/restaurant.model.dart';
import '../../common/dot.separator.widget.dart';

class RestaurantOpeningTimeWidget extends StatelessWidget {
  const RestaurantOpeningTimeWidget({
    super.key,
    required this.restaurant,
  });

  final Restaurants restaurant;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Text(
            'Opening Time',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black.withOpacity(0.8),
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Gap(5),
          const DotSeparatorWidget(),
          const Gap(5),
          Text(
            restaurant.time,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black.withOpacity(0.8),
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Gap(8),
          Container(
            height: 20,
            width: 1.5,
            color: Colors.grey.shade700,
          ),
          const Gap(5),
          Text(
            'Open',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black.withOpacity(0.8),
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Gap(8),
          Container(
            height: 15,
            width: 15,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: restaurant.pickUp ? Colors.green : Colors.red,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 1,
                  spreadRadius: 1,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: Center(
              child: Icon(
                restaurant.pickUp ? Icons.check : Icons.close,
                color: Colors.white,
                size: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
