import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controller/foodQuantity.controller.dart';

import '../widgets/cart/view/cartAppBar.widget.dart';
import '../widgets/cart/view/cartItem.widget.dart';
import '../widgets/cart/view/emptyCart.widget.dart';
import '../widgets/cart/view/totalBill.widget.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);

    // Calculate the total price
    double totalPrice = 0;
    for (var item in cartItems) {
      totalPrice += (item.product.price * item.quantity);
    }

    // Example delivery charges
    double deliveryCharges = 36.0;

    double instantDiscount = 120.0;

    double platformFee = 5.00;

    double gstAndRestaurantCharges = 40.0;

    double total =
        totalPrice + platformFee + gstAndRestaurantCharges - instantDiscount;

    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            color: Colors.grey.shade200,
            child: CustomScrollView(
              slivers: [
                const SliverToBoxAdapter(
                  child: CartAppBarWidget(),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    color: Colors.grey[200], // Background color for the list
                    child:
                        const SizedBox(height: 10), // Placeholder for spacing
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final item = cartItems[index];
                      return CartItemWidget(item: item);
                    },
                    childCount: cartItems.length,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: cartItems.isNotEmpty
                        ? TotalBillWidget(
                            totalPrice: totalPrice,
                            deliveryCharges: deliveryCharges,
                            instantDiscount: instantDiscount,
                            platformFee: platformFee,
                            gstAndRestaurantCharges: gstAndRestaurantCharges,
                            total: total,
                          )
                        : const EmptyCartWidget(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

