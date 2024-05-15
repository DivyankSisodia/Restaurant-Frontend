import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/src/widgets/common/dottedLine.widget.dart';
import 'package:food_delivery/src/widgets/common/likeANDshare.widget.dart';
import 'package:food_delivery/src/widgets/common/linearGradient.container.dart';

import '../home/widgets/restaurant.discountText.widget.dart';
import '../home/widgets/restaurant.image.widget.dart';
import '../home/widgets/restaurant.texts.dart';

class RestaurantGridWidget extends StatelessWidget {
  const RestaurantGridWidget({
    super.key,
    required this.image,
    required this.title,
    required this.rating,
  });

  final String image;
  final String title;
  final String rating;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return FadeInDown(
      delay: const Duration(milliseconds: 300),
      duration: const Duration(milliseconds: 500),
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
                const LikeAndShareIconsWidget(),
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
