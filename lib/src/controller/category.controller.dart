import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_delivery/src/services/categories.service.dart';

final foodProvider = Provider<FoodServices>((ref) => FoodServices());

final categoriesProvider = FutureProvider.autoDispose((ref) async {
  final foodServices = ref.read(foodProvider);
  return foodServices.getCategories();
});
