import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../widget/restaurant.foodCard.widget.dart';

class RestaurantFoodList extends StatelessWidget {
  const RestaurantFoodList({
    super.key,
    required this.listOfFoods,
  });

  final List<Map<String, dynamic>> listOfFoods;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SliverList.separated(
      itemBuilder: (context, index) {
        final food = listOfFoods[index];
        return RestaurantsFoodCardWidget(
          height: height,
          width: width,
          food: food,
        );
      },
      separatorBuilder: (context, index) => const Gap(2),
      itemCount: listOfFoods.length,
    );
  }
}
