import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/foods.service.dart';

final foodsProvider = Provider<FoodServices>((ref) => FoodServices());

final foodListProvider = FutureProvider.autoDispose((ref) async {
  final foodServices = ref.read(foodsProvider);
  return foodServices.getAllFoods();
});
