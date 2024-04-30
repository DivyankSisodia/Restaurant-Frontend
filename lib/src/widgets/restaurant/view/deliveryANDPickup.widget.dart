import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../model/restaurant.model.dart';
import '../../common/dot.separator.widget.dart';
import '../widget/deliveryText.widget.dart';
import '../widget/isAvailable.container.widget.dart';

class DeliveryAndPickupWidget extends StatelessWidget {
  const DeliveryAndPickupWidget({
    super.key,
    required this.restaurant,
  });

  final Restaurants restaurant;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        children: [
          const RestaurantSectionDeliveryText(title: 'Delivery'),
          const Gap(5),
          IsAvailableContainer(
            isOpen: restaurant.delivery,
          ),
          const Gap(5),
          const DotSeparatorWidget(),
          const Gap(5),
          const RestaurantSectionDeliveryText(title: 'Pickup Orders'),
          const Gap(5),
          IsAvailableContainer(
            isOpen: restaurant.pickUp,
          ),
        ],
      ),
    );
  }
}
