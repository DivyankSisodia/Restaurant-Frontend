import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controller/favoriteList.controller.dart';

class LikedRestaurantsScreen extends ConsumerWidget {
  const LikedRestaurantsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final likedRestaurants = ref.watch(restListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Liked Restaurants'),
      ),
      body: likedRestaurants.isEmpty
          ? const Center(child: Text('No liked restaurants yet.'))
          : ListView.builder(
              itemCount: likedRestaurants.length,
              itemBuilder: (context, index) {
                final restaurant = likedRestaurants[index];
                return ListTile(
                  title: Text(restaurant.title),
                  subtitle: Text(restaurant.address),
                  trailing: IconButton(
                      onPressed: () {
                        ref
                            .read(restListProvider.notifier)
                            .removeRestaurant(restaurant.id);
                      },
                      icon: const Icon(Icons.delete)),
                );
              },
            ),
    );
  }
}
