import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../model/restaurant.model.dart';
import '../../common/divider.widget.dart';
import 'pureVeg.logoAndText.dart';
import 'deliveryANDPickup.widget.dart';
import 'deliveryCharge.widget.dart';
import 'restaurant.header.widgets.dart';
import 'restaurant.opening.widget.dart';

class RestaurantInfoContainer extends StatelessWidget {
  const RestaurantInfoContainer({
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
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 20.0,
        left: 10.0,
        right: 10.0,
      ),
      child: Container(
        height: height * 0.33,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          border: Border.all(
            color: Colors.black54.withOpacity(0.2),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.7),
              blurRadius: 3,
              spreadRadius: 2,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Column(
          children: [
            const PureVegIconAndText(),
            RestaurantDetailsHeaderWidget(
              restaurant: restaurant,
              shortAddress: shortAddress,
              remainingAddress: remainingAddress,
              height: height,
              width: width,
            ),
            DeliveryAndPickupWidget(
              restaurant: restaurant,
            ),
            const DividerWidget(),
            const DeliveryChargesWidget(),
            const DividerWidget(),
            const Gap(5),
            RestaurantOpeningTimeWidget(
              restaurant: restaurant,
            )
          ],
        ),
      ),
    );
  }
}
