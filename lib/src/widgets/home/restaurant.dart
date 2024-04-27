import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_delivery/src/controller/restaurant.controller.dart';

import '../common/restaurant.grid.widget.dart';

class RestaurantScreen extends ConsumerWidget {
  const RestaurantScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Consumer(
      builder: ((context, ref, child) {
        final restaurantList = ref.watch(restaurantProvider);
        return restaurantList.when(
          data: (data) => GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
            ),
            itemCount: data.length,
            itemBuilder: (context, index) {
              return RestaurantGridWidget(
                image: data[index].imageUrl,
                title: data[index].title,
              );
            },
          ),
          error: (error, stack) => const Center(
            child: Text('Error'),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      }),
    );
  }
}

