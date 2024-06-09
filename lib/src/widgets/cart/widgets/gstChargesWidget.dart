import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

import '../../../utils/styles/text_style.dart';

class GSTChargesWidget extends StatelessWidget {
  const GSTChargesWidget({
    super.key,
    required this.gstAndRestaurantCharges,
  });

  final double gstAndRestaurantCharges;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'GST and Restaurant Charges',
              style: AppStyle.cartScreenSmallText,
            ),
            const SizedBox(height: 3),
            const SizedBox(
              height: 2,
              width: 170,
              child: DottedLine(
                dashColor: Colors.black87,
                dashGapLength: 2,
              ),
            ),
          ],
        ),
        Text(
          '₹${gstAndRestaurantCharges.toStringAsFixed(2)}',
          style: AppStyle.cartScreenMediumText,
        ),
      ],
    );
  }
}
