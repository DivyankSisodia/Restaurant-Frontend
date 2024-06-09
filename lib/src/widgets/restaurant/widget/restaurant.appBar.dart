import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_delivery/src/model/favorite_restaurant.dart';
import 'package:iconsax/iconsax.dart';
import '../../../controller/favoriteList.controller.dart';

class RestaurantAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const RestaurantAppBar({
    super.key,
    this.restaurant,
  });

  final FavRestaurantModel? restaurant;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final likedRestaurants = ref.watch(restListProvider);
    final isLiked = likedRestaurants.any((fav) => fav.id == restaurant?.id);
    return AppBar(
      backgroundColor: Colors.grey[300],
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_rounded),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      actions: [
        IconButton(
          icon: Icon(
            isLiked ? Iconsax.heart5 : Icons.favorite_border,
            color: isLiked ? Colors.redAccent.shade400 : Colors.white,
            size: 30,
          ),
          onPressed: () {
            if (isLiked) {
              ref
                  .read(restListProvider.notifier)
                  .removeRestaurant(restaurant!.id);
            } else {
              final favRestaurant = FavRestaurantModel(
                id: restaurant!.id,
                title: restaurant!.title,
                imageUrl: restaurant!.imageUrl,
                rating: restaurant!.rating,
                time: restaurant!.time,
                address: restaurant!.address,
              );
              ref.read(restListProvider.notifier).addRestaurant(favRestaurant);
            }
          },
        ),
        Padding(
          padding: const EdgeInsets.only(right: 14.0),
          child: Image.asset(
            'assets/icons/upload.png',
            height: 30,
            width: 50,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }
}
