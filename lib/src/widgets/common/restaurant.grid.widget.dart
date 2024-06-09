import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_delivery/src/model/restaurant.model.dart';
import 'package:food_delivery/src/widgets/common/dottedLine.widget.dart';
import 'package:food_delivery/src/widgets/common/likeANDshare.widget.dart';
import 'package:food_delivery/src/widgets/common/linearGradient.container.dart';

import '../home/widgets/restaurant.discountText.widget.dart';
import '../home/widgets/restaurant.image.widget.dart';
import '../home/widgets/restaurant.texts.dart';

class RestaurantGridWidget extends ConsumerWidget {
  const RestaurantGridWidget({
    super.key,
    required this.image,
    required this.title,
    required this.rating,
    required this.restaurant,
  });

  final String image;
  final String title;
  final String rating;
  final Restaurants restaurant;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double height = MediaQuery.of(context).size.height;
    return SlideInRight(
      delay: const Duration(milliseconds: 200),
      duration: const Duration(milliseconds: 400),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(1, 1),
            ),
          ],
        ),
        child: Column(
          children: [
            Stack(
              children: [
                RestaurantImageWidget(height: height, image: image),
                const LinearGradientContainerWidget(),
                LikeAndShareIconsWidget(
                  restaurant: restaurant,
                ),
              ],
            ),
            HomeScreenRestaurantTexts(title: title, rating: rating),
            const DottedLineWidget(),
            const RestaurantDiscountTextWidget(),
          ],
        ),
      ),
    );
  }
}
