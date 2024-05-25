import 'package:riverpod/riverpod.dart';

import '../model/restaurant.model.dart';

List<Restaurants> restaurantsList = [];

class RestaurantListNotifier extends StateNotifier<List<Restaurants>> {
  RestaurantListNotifier() : super(restaurantsList);

  // add restaurants
  void addRestaurant(Restaurants restaurant) {
    state = [...state, restaurant];
  }

  // remove items
  void removeRestaurant(String restaurantId) {
    state = [
      for (final i in state)
        // ignore: unrelated_type_equality_checks
        if (i.id != restaurantId) i
    ];
  }
}

final restListProvider =
    StateNotifierProvider<RestaurantListNotifier, List<Restaurants>>((ref) {
  return RestaurantListNotifier();
});
