import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../model/cart.model.dart';

class CartFoodAndRestaurantText extends StatelessWidget {
  const CartFoodAndRestaurantText({
    super.key,
    required this.item,
  });

  final CartItem item;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              item.product.title,
              style: TextStyle(
                letterSpacing: 1,
                color: Colors.grey.shade700,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: GoogleFonts.dmSans().fontFamily,
              ),
            ),
            Text(
              item.product.restaurantName,
              style: TextStyle(
                letterSpacing: 0.9,
                color: Colors.grey.shade500,
                fontSize: 15,
                fontWeight: FontWeight.w500,
                fontFamily: GoogleFonts.dmSans().fontFamily,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

