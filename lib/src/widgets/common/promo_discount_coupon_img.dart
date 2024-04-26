import 'package:flutter/widgets.dart';

class PromoDiscountCoupons extends StatelessWidget {
  const PromoDiscountCoupons({
    super.key,
    required this.height,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.1,
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage('assets/promo/promo.jpeg'),
      )),
    );
  }
}
