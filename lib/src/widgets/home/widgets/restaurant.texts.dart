import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../common/dot.separator.widget.dart';
import '../../common/restaurant.title.widget.dart';
import 'reaturant.rating.widget.dart';

class HomeScreenRestaurantTexts extends StatelessWidget {
  const HomeScreenRestaurantTexts({
    super.key,
    required this.title,
    required this.rating,
  });

  final String title;
  final String rating;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 9,
      child: Row(
        children: [
          Expanded(
            flex: 7,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RestaurantNameTitleWidget(title: title),
                  Row(
                    children: [
                      Text(
                        '100% Pure Veg',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                          fontFamily: GoogleFonts.roboto().fontFamily,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Gap(5),
                      const DotSeparatorWidget(),
                      const Gap(5),
                      Text(
                        '200 for one',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                          fontFamily: GoogleFonts.roboto().fontFamily,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: RestaurantRatingWidget(rating: rating),
          )
        ],
      ),
    );
  }
}
