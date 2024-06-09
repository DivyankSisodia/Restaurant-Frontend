import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/styles/text_style.dart';
import '../../common/dottedLine.widget.dart';
import '../widgets/deliveryFeeWidget.dart';
import '../widgets/deliveryPolicyText.dart';
import '../widgets/gstChargesWidget.dart';
import '../widgets/instantDiscountWidget.dart';
import '../widgets/itemTotalWidget.dart';
import '../widgets/platFormFeeWidget.dart';

class TotalBillWidget extends StatelessWidget {
  const TotalBillWidget({
    super.key,
    required this.totalPrice,
    required this.deliveryCharges,
    required this.instantDiscount,
    required this.platformFee,
    required this.gstAndRestaurantCharges,
    required this.total,
  });

  final double totalPrice;
  final double deliveryCharges;
  final double instantDiscount;
  final double platformFee;
  final double gstAndRestaurantCharges;
  final double total;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200], // Background color for the list
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'Bill Details',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: GoogleFonts.dmSans().fontFamily,
                letterSpacing: 1,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 6,
                  spreadRadius: 8,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ItemTotalWidget(totalPrice: totalPrice),
                  const Gap(10),
                  DeliveryFeeWidget(deliveryCharges: deliveryCharges),
                  const Gap(6),
                  DeliveryPolicyText(),
                  const Gap(8),
                  const DottedLineWidget(),
                  InstantDiscountWidget(instantDiscount: instantDiscount),
                  const Gap(8),
                  const DottedLineWidget(),
                  PlatformFeeWidget(platformFee: platformFee),
                  const Gap(3),
                  GSTChargesWidget(
                      gstAndRestaurantCharges: gstAndRestaurantCharges),
                  const Gap(8),
                  const DottedLineWidget(),
                  FinalAmountWidget(total: total),
                ],
              ),
            ),
          )
        ],
      ), // Placeholder for spacing
    );
  }
}

class FinalAmountWidget extends StatelessWidget {
  const FinalAmountWidget({
    super.key,
    required this.total,
  });

  final double total;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'To Pay',
              style: AppStyle.cartScreenTitle.copyWith(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ],
        ),
        Text(
          '₹${total.toStringAsFixed(2)}',
          style: AppStyle.mediumPriceText.copyWith(fontSize: 16),
        ),
      ],
    );
  }
}
