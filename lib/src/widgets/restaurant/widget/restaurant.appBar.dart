import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_delivery/src/model/Hive/favorite_restaurant.dart';
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
            Icons.favorite_outline_sharp,
            color: Colors.grey[700],
            size: 30,
          ),
          onPressed: () {
            if (restaurant != null) {
              ref.read(restListProvider.notifier).addRestaurant(restaurant!);
            } else {
              print('Restaurant is null');
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
