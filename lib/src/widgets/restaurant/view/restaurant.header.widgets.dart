import 'package:flutter/material.dart';
import 'package:food_delivery/src/widgets/restaurant/view/restaurant.review.widget.dart';
import 'package:gap/gap.dart';

import '../../../model/restaurant.model.dart';
import '../../common/dot.separator.widget.dart';
import '../../common/restaurant.title.widget.dart';
import '../widget/restaurant.address.text.dart';

class RestaurantDetailsHeaderWidget extends StatelessWidget {
  const RestaurantDetailsHeaderWidget({
    super.key,
    required this.restaurant,
    required this.shortAddress,
    required this.remainingAddress,
    required this.height,
    required this.width,
  });

  final Restaurants restaurant;
  final String shortAddress;
  final String remainingAddress;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RestaurantNameTitleWidget(
                title: restaurant.title,
              ),
              const Gap(5),
              Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    color: Color.fromARGB(255, 0, 0, 0),
                    size: 20,
                  ),
                  const Gap(2),
                  RestaurantSectionAddressText(address: shortAddress),
                  const Gap(2),
                  const DotSeparatorWidget(),
                  RestaurantSectionAddressText(
                    address: remainingAddress,
                  ),
                ],
              ),
            ],
          ),
          RestaurantReviews(
            height: height,
            width: width,
            restaurant: restaurant,
          ),
        ],
      ),
    );
  }
}
