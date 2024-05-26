import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_delivery/src/model/Hive/favorite_restaurant.dart';
import 'package:food_delivery/src/model/restaurant.model.dart';
import 'package:iconsax/iconsax.dart';
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
    final isLiked = likedRestaurants.any((fav) => fav.id == restaurant.id);

    return Positioned(
      right: 10,
      top: 2,
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              if (isLiked) {
                ref
                    .read(restListProvider.notifier)
                    .removeRestaurant(restaurant.id);
              } else {
                final favRestaurant = FavRestaurantModel(
                  id: restaurant.id,
                  title: restaurant.title,
                  imageUrl: restaurant.imageUrl,
                  rating: restaurant.rating,
                  time: restaurant.time,
                  address: restaurant.address,
                );
                ref
                    .read(restListProvider.notifier)
                    .addRestaurant(favRestaurant);
              }
            },
            icon: Icon(
              isLiked ? Iconsax.heart5 : Icons.favorite_border,
              color: isLiked ? Colors.redAccent.shade400 : Colors.white,
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
