import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controller/foodQuantity.controller.dart';
import '../../../model/cart.model.dart';

class CartFoodQuantityWidget extends ConsumerWidget {
  const CartFoodQuantityWidget({
    super.key,
    required this.item,
  });

  final CartItem item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 110,
      height: 35,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade700.withOpacity(0.3),
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(
              Icons.remove,
              size: 18,
              color: Colors.green,
            ),
            onPressed: () {
              ref
                  .read(cartProvider.notifier)
                  .removeFromCart(item.product);
            },
          ),
          Text(
            '${item.quantity}',
            style: TextStyle(
              color: Colors.green,
              fontSize: 15,
              fontWeight: FontWeight.bold,
              fontFamily: GoogleFonts.dmSans().fontFamily,
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.add,
              size: 18,
              color: Colors.green,
            ),
            onPressed: () {
              ref
                  .read(cartProvider.notifier)
                  .addToCart(item.product);
            },
          ),
        ],
      ),
    );
  }
}

