import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_delivery/src/controller/animtaion.controller.dart';
import 'package:gap/gap.dart';

import '../../common/heading_row.dart';
import '../../common/promo_discount_coupon_img.dart';

class DiscountCoupons extends ConsumerWidget {
  const DiscountCoupons({
    super.key,
    required this.height,
  });

  final double height;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final discountAnimation = ref.watch(animationStateProvider);
    return SliverToBoxAdapter(
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: discountAnimation
            ? Column(
                children: [
                  const HeadingRow(title: 'BEST OFFERS FOR YOU'),
                  const Gap(8),
                  PromoDiscountCoupons(height: height),
                ],
              )
            : FadeInRight(
                delay: const Duration(milliseconds: 600),
                child: Column(
                  children: [
                    const HeadingRow(title: 'BEST OFFERS FOR YOU'),
                    const Gap(8),
                    PromoDiscountCoupons(height: height),
                  ],
                ),
              ),
      ),
    );
  }
}
