import 'package:flutter/material.dart';

import '../../../utils/styles/text_style.dart';

class ItemTotalWidget extends StatelessWidget {
  const ItemTotalWidget({
    super.key,
    required this.totalPrice,
  });

  final double totalPrice;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Item Total',
          style: AppStyle.cartScreenSmallText,
        ),
        Text(
          '₹${totalPrice.toStringAsFixed(2)}',
          style: AppStyle.cartScreenMediumText,
        )
      ],
    );
  }
}
