import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/food.model.dart';

class FoodQuantityNotifier extends StateNotifier<List<Foods>> {
  FoodQuantityNotifier() : super([]);

  void setFoods(List<Foods> foods) {
    state = foods;
  }

  void incrementQty(String foodId) {
    state = [
      for (final food in state)
        if (food.id == foodId)
          food.copyWith(quantity: food.quantity + 1)
        else
          food,
    ];
  }

  void decreaseQty(String foodId) {
    state = [
      for (final food in state)
        if (food.id == foodId)
          food.copyWith(quantity: food.quantity > 0 ? food.quantity - 1 : 0)
        else
          food,
    ];
  }
}

final foodQuantityProvider =
    StateNotifierProvider<FoodQuantityNotifier, List<Foods>>(
  (ref) => FoodQuantityNotifier(),
);
