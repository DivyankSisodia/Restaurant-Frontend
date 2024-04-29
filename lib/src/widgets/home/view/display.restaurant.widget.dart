import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_transition/page_transition.dart';

import '../../../controller/restaurant.controller.dart';
import '../../../views/food.screen.dart';
import '../../common/restaurant.grid.widget.dart';

class DisplayRestaurantsWidget extends StatelessWidget {
  const DisplayRestaurantsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Consumer(
      builder: (context, ref, child) {
        final restaurantList = ref.watch(restaurantProvider);

        // Calculate the child count based on the length of restaurantList
        final childCount = restaurantList.maybeWhen(
          data: (data) => data.length,
          orElse: () => 0, // Default to 0 if data is null or loading
        );

        return SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            mainAxisSpacing: 25.0,
            crossAxisSpacing: 16.0,
            mainAxisExtent: height * 0.32,
          ),
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              // Check if index exceeds childCount, if so, return null
              if (index >= childCount) {
                return null;
              }
              // If data is available, build the RestaurantGridWidget
              return restaurantList.when(
                data: (data) => GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        curve: Curves.easeInOut,
                        reverseDuration: const Duration(milliseconds: 500),
                        type: PageTransitionType.bottomToTop,
                        child: FoodScreenWidget(
                          restaurant: data[index],
                        ),
                        duration: const Duration(milliseconds: 500),
                      ),
                    );
                  },
                  child: RestaurantGridWidget(
                    image: data[index].imageUrl,
                    title: data[index].title,
                    rating: data[index].rating.toString(),
                  ),
                ),
                error: (error, stack) => const Center(
                  child: Text('Error'),
                ),
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
            childCount: childCount,
          ),
        );
      },
    );
  }
}
