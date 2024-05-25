import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_delivery/src/model/restaurant.model.dart';

import '../../controller/favoriteList.controller.dart';

class LikeAndShareIconsWidget extends ConsumerWidget {
  const LikeAndShareIconsWidget({
    super.key,
    required this.restaurant,
  });

  final Restaurants restaurant;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final likedRestaurants = ref.watch(restListProvider);
    final isLiked = likedRestaurants.contains(restaurant);
    return Positioned(
      right: 10,
      top: 2,
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              ref
                  .read(restListProvider.notifier)
                  .addRestaurant(restaurant);
            },
            icon: Icon(
              isLiked ? Icons.favorite : Icons.favorite_border,
              color: Colors.white,
              size: 30,
            ),
          ),

          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.share,
              color: Colors.white,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}
