import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:food_delivery/src/model/Hive/favorite_restaurant.dart';

// Provider to manage the list of favorite restaurants
final restListProvider = StateNotifierProvider<RestListNotifier, List<FavRestaurantModel>>((ref) {
  return RestListNotifier();
});

class RestListNotifier extends StateNotifier<List<FavRestaurantModel>> {
  RestListNotifier() : super([]) {
    _loadFavorites();
  }

  // Load favorite restaurants from Hive
  Future<void> _loadFavorites() async {
    final box = await Hive.openBox<FavRestaurantModel>('favoriteRestaurantBox');
    state = box.values.toList();
  }

  // Add a restaurant to the favorites list
  void addRestaurant(FavRestaurantModel restaurant) async {
    final box = await Hive.openBox<FavRestaurantModel>('favoriteRestaurantBox');
    await box.put(restaurant.id, restaurant);
    state = box.values.toList();
  }

  // Remove a restaurant from the favorites list
  void removeRestaurant(String id) async {
    final box = await Hive.openBox<FavRestaurantModel>('favoriteRestaurantBox');
    await box.delete(id);
    state = box.values.toList();
  }
}
