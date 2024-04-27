import 'package:food_delivery/src/services/restaurant.service.dart';
import 'package:riverpod/riverpod.dart';

final restaurantDetailsProvider = Provider<RestaurantServices>((ref) => RestaurantServices());

final restaurantProvider = FutureProvider.autoDispose((ref) async {
  final details = ref.read(restaurantDetailsProvider);
  return details.getRestaurantDetails();
});