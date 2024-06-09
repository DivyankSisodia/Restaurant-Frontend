import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';

import '../../../controller/foodQuantity.controller.dart';
import '../../../model/cart.model.dart';
import '../../common/dottedLine.widget.dart';
import '../widgets/addCookingInstructionWidget.dart';
import '../widgets/addMoreItemWidget.dart';
import '../widgets/food&RestaurantTitle.dart';
import '../widgets/foodQuantityWidget.dart';
import '../widgets/pricePerFoodWidget.dart';

class CartItemWidget extends ConsumerWidget {
  final CartItem item;

  const CartItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int particularFoodPrirce = (item.product.price * item.quantity).toInt();
    return Slidable(
      closeOnScroll: true,
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            borderRadius: BorderRadius.circular(10),
            padding: const EdgeInsets.all(10),
            label: 'Remove from cart',
            spacing: 10,
            onPressed: (context) {
              ref.read(cartProvider.notifier).deleteFromCart(item.product);
            },
            icon: Iconsax.trash,
            foregroundColor: Colors.white,
            backgroundColor: Colors.red,
          ),
        ],
      ),
      endActionPane: ActionPane(
        dragDismissible: true,
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            borderRadius: BorderRadius.circular(10),
            padding: const EdgeInsets.all(10),
            label: 'Decrease quantity',
            spacing: 10,
            onPressed: (context) {
              ref.read(cartProvider.notifier).removeFromCart(item.product);
            },
            icon: Iconsax.minus_cirlce5,
            foregroundColor: Colors.white,
            backgroundColor: Colors.amber.shade800,
          ),
        ],
      ),
      child: Container(
        margin: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 12.0,
                right: 12,
                top: 10,
              ),
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  CartFoodAndRestaurantText(item: item),
                  CartFoodQuantityWidget(item: item),
                  const SizedBox(width: 15),
                  PricePerFoodWidget(
                    particularFoodPrirce: particularFoodPrirce,
                  ),
                ],
              ),
            ),
            const Gap(5),
            const DottedLineWidget(),
            const CartAddMoreItemWidget(),
            const DottedLineWidget(),
            const CartFoodCookingInstructionWidget()
          ],
        ),
      ),
    );
  }
}
