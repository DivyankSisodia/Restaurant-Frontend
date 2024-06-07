// food_provider.dart (or any other file where you define providers)
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/food.model.dart';
import '../services/foods.service.dart';

final foodsProvider = Provider<FoodServices>((ref) => FoodServices());

class FoodListNotifier extends StateNotifier<AsyncValue<List<Foods>>> {
  FoodListNotifier(this.foodServices) : super(const AsyncValue.loading()) {
    fetchFoods();
  }

  final FoodServices foodServices;

  Future<void> fetchFoods() async {
    try {
      final foods = await foodServices.getAllFoods();
      state = AsyncValue.data(foods);
    } catch (e) {
      state = AsyncValue.error(e.toString(), StackTrace.current);
    }
  }
}

final foodListProvider = StateNotifierProvider<FoodListNotifier, AsyncValue<List<Foods>>>((ref) {
  final foodServices = ref.read(foodsProvider);
  return FoodListNotifier(foodServices);
});
