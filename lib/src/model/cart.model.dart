import 'package:food_delivery/src/model/food.model.dart';

class CartItem {
  final Foods product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}
