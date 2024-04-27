import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_delivery/src/services/food_services.dart';

final foodProvider = Provider<FoodServices>((ref) => FoodServices());

final categoriesProvider = FutureProvider.autoDispose((ref) async {
  final foodServices = ref.read(foodProvider);
  return foodServices.getCategories();
});