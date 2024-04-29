import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RestaurantRatingWidget extends StatelessWidget {
  const RestaurantRatingWidget({
    super.key,
    required this.rating,
  });

  final String rating;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 30,
        width: 55,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.green,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              rating,
              style: TextStyle(
                fontSize: 17,
                color: Colors.white,
                fontFamily: GoogleFonts.poppins().fontFamily,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Icon(
              Icons.star,
              color: Colors.white,
              size: 15,
            ),
          ],
        ),
      ),
    );
  }
}
