// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controller/foodQuantity.controller.dart';
import '../controller/order.controller.dart';
import '../controller/token.controller.dart';
import '../widgets/cart/view/cartAppBar.widget.dart';
import '../widgets/cart/view/cartItem.widget.dart';
import '../widgets/cart/view/emptyCart.widget.dart';
import '../widgets/cart/view/totalBill.widget.dart';
import 'profile.screen.dart'; // Import ProfileScreen
import 'dart:convert'; // Import jsonDecode for JSON decoding
import 'package:http/http.dart' as http; // Import http for API calls

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

    double total = totalPrice +
        deliveryCharges +
        platformFee +
        gstAndRestaurantCharges -
        instantDiscount;

    // Retrieve userId from Hive
    var userId = Hive.box('user_info').get('userId');
    debugPrint(
        'User ID from Hive: $userId'); // Print the userId to confirm retrieval

    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              Container(
                color: Colors.grey.shade200,
                child: CustomScrollView(
                  slivers: [
                    const SliverToBoxAdapter(
                      child: CartAppBarWidget(),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        color:
                            Colors.grey[200], // Background color for the list
                        child: const SizedBox(
                            height: 10), // Placeholder for spacing
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
                                gstAndRestaurantCharges:
                                    gstAndRestaurantCharges,
                                total: total,
                              )
                            : const EmptyCartWidget(),
                      ),
                    ),
                  ],
                ),
              ),
              if (cartItems.isNotEmpty)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        print('order kia h');
                        // Call the placeOrder function with userId
                        final success = await placeOrder(context, ref, userId);

                        if (success) {
                          // Navigate to the OrderHistoryScreen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ProfileScreen()),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        textStyle: const TextStyle(fontSize: 16),
                      ),
                      child: const Text('Place Order'),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> placeOrder(
      BuildContext context, WidgetRef ref, String userId) async {
    // Get the cart items from the provider
    final cartItems = ref.read(cartProvider);

    // Retrieve the token using the tokenProvider
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');

    if (token == null) {
      // Handle the case where token is null
      debugPrint('Token is null');
      return false;
    }

    // Prepare the order data
    final orderData = {
      'userId': userId, // Use the userId retrieved from Hive
      'foods': cartItems.map((item) {
        return {
          'food': item.product.id,
          'quantity': item.quantity,
        };
      }).toList(),
    };

    // Make the API call with the token included in the headers
    try {
      final response = await http.post(
        Uri.parse(
            'https://restaurants-backend-gnl2.onrender.com/api/v1/order/create'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Include the token in the headers
        },
        body: jsonEncode(orderData),
      );

      if (response.statusCode == 201) {
        // Clear the cart after successful order placement
        ref.read(cartProvider.notifier).clearCart();

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Order placed successfully')),
        );

        // Refresh order data
        // ignore: unused_result
        ref.refresh(orderProvider);

        return true;
      } else {
        // Decode the response body to understand the error
        final responseBody = jsonDecode(response.body);
        debugPrint('Error Response: $responseBody');

        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text('Failed to place order: ${responseBody['message']}')),
        );

        return false;
      }
    } catch (error) {
      debugPrint('Error placing order: $error');

      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to place order due to an error')),
      );

      return false;
    }
  }
}
