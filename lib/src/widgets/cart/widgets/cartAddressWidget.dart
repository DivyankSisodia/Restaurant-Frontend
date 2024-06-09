import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/styles/text_style.dart';

class CartAddressWidget extends StatelessWidget {
  const CartAddressWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(5.0),
              child: Icon(
                Iconsax.bag5,
                color: Colors.orange,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                '20-25 mins to Work',
                style: AppStyle.cartScreenMediumText,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              '|  House no.',
              style: AppStyle.cartScreenSmallText,
            ),
          ],
        ),
      ),
    );
  }
}