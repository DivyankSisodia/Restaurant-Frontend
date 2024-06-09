import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

import '../../../utils/styles/text_style.dart';

class PlatformFeeWidget extends StatelessWidget {
  const PlatformFeeWidget({
    super.key,
    required this.platformFee,
  });

  final double platformFee;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Platform Fee',
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
          '₹${platformFee.toStringAsFixed(2)}',
          style: AppStyle.cartScreenMediumText,
        ),
      ],
    );
  }
}

