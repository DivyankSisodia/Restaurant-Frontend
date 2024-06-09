import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

import '../../../utils/styles/text_style.dart';

class DeliveryFeeWidget extends StatelessWidget {
  const DeliveryFeeWidget({
    super.key,
    required this.deliveryCharges,
  });

  final double deliveryCharges;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Delivery Fee ... | 4 KM',
              style: AppStyle.cartScreenSmallText,
            ),
            const SizedBox(height: 3),
            const SizedBox(
              height: 2,
              width: 140,
              child: DottedLine(
                dashColor: Colors.black87,
                dashGapLength: 2,
              ),
            ),
          ],
        ),
        Text(
          '₹${deliveryCharges.toStringAsFixed(2)}',
          style: AppStyle.cartScreenMediumText,
        )
      ],
    );
  }
}

