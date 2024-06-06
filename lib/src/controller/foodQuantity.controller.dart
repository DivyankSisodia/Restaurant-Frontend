import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/cart.model.dart';
import '../model/food.model.dart';

class CartState extends StateNotifier<List<CartItem>> {
  CartState() : super([]);

  void addToCart(Foods product) {
    state = [
      for (final item in state)
        if (item.product.id == product.id)
          CartItem(product: item.product, quantity: item.quantity + 1)
        else
          item,
      if (state.every((item) => item.product.id != product.id))
        CartItem(product: product, quantity: 1),
    ];
  }

  void removeFromCart(Foods product) {
    state = [
      for (final item in state)
        if (item.product.id == product.id && item.quantity > 1)
          CartItem(product: item.product, quantity: item.quantity - 1)
        else if (item.product.id != product.id)
          item,
    ];
  }

  void deleteFromCart(Foods product) {
    state = state.where((item) => item.product.id != product.id).toList();
  }

  void clearCart() {
    state = [];
  }
}

final cartProvider = StateNotifierProvider<CartState, List<CartItem>>((ref) {
  return CartState();
});
