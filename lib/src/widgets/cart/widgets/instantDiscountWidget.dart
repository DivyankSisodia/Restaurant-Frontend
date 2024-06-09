import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

import '../../../utils/styles/text_style.dart';

class InstantDiscountWidget extends StatelessWidget {
  const InstantDiscountWidget({
    super.key,
    required this.instantDiscount,
  });

  final double instantDiscount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Item Discount',
              style: AppStyle.cartScreenSmallText,
            ),
            const SizedBox(height: 3),
            const SizedBox(
              height: 2,
              width: 90,
              child: DottedLine(
                dashColor: Colors.black87,
                dashGapLength: 2,
              ),
            ),
          ],
        ),
        Text(
          '- ₹${instantDiscount.toStringAsFixed(2)}',
          style: AppStyle.cartScreenMediumText.copyWith(
            color: Colors.green,
          ),
        )
      ],
    );
  }
}

