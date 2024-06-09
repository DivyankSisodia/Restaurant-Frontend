import 'package:flutter/material.dart';

import '../../../utils/styles/text_style.dart';

class DeliveryPolicyText extends StatelessWidget {
  const DeliveryPolicyText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 100,
      child: Text(
        'This fee fairly goes to our delivery partners for delivering your food',
        style: AppStyle.cartScreenSmallestText,
      ),
    );
  }
}

