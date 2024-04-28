import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../controller/restaurant.controller.dart';
import '../../common/restaurant.grid.widget.dart';

class DisplayRestaurantsWidget extends StatelessWidget {
  const DisplayRestaurantsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final restaurantList = ref.watch(restaurantProvider);

        // Calculate the child count based on the length of restaurantList
        final childCount = restaurantList.maybeWhen(
          data: (data) => data.length,
          orElse: () => 0, // Default to 0 if data is null or loading
        );

        return SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            mainAxisSpacing: 25.0,
            crossAxisSpacing: 16.0,
            mainAxisExtent: 300,
          ),
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              // Check if index exceeds childCount, if so, return null
              if (index >= childCount) {
                return null;
              }
              // If data is available, build the RestaurantGridWidget
              return restaurantList.when(
                data: (data) => RestaurantGridWidget(
                  image: data[index].imageUrl,
                  title: data[index].title,
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