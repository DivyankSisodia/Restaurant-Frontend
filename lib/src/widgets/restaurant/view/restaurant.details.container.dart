import 'package:flutter/material.dart';

import '../../../model/restaurant.model.dart';
import '../widget/restaurant.appBar.dart';
import '../widget/restaurantInfo.container.dart';

class RestaurantDetailsHeaderContainer extends StatelessWidget {
  const RestaurantDetailsHeaderContainer({
    super.key,
    required this.height,
    required this.restaurant,
    required this.shortAddress,
    required this.remainingAddress,
    required this.width,
  });

  final double height;
  final Restaurants restaurant;
  final String shortAddress;
  final String remainingAddress;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      expandedHeight: height * 0.4,
      flexibleSpace: FlexibleSpaceBar(
        background: Column(
          children: [
            const RestaurantAppBar(),
            Container(
              padding: const EdgeInsets.all(8),
              height: height * 0.33,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(45),
                  bottomRight: Radius.circular(45),
                ),
                color: Colors.grey[300], // Container color
              ),
              child: RestaurantInfoContainer(
                restaurant: restaurant,
                shortAddress: shortAddress,
                remainingAddress: remainingAddress,
                height: height,
                width: width,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
