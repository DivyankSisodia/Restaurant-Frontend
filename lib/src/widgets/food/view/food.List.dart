import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_delivery/src/model/food.model.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controller/foodQuantity.controller.dart';
import '../../../utils/helper/foodsBottomSheet.dart';

class FoodScreenListWidget extends ConsumerWidget {
  const FoodScreenListWidget({
    super.key,
    required this.height,
    required this.width,
    required this.food,
  });

  final double height;
  final double width;
  final Foods food;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final foodQuantityNotifier = ref.read(foodQuantityProvider.notifier);
    final foodQuantity = ref.watch(foodQuantityProvider);
    final foodWithQuantity = foodQuantity.firstWhere(
      (f) => f.id == food.id,
      orElse: () => food,
    );
    final quantity = foodWithQuantity.quantity;

    return Container(
      height: height,
      width: width,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Flexible(
            flex: 11,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 6,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          food.title,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Gap(4),
                        Text(
                          '₹${food.price}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[700],
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.green[600],
                              size: 13,
                            ),
                            Text(
                              '${food.rating}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.green[600],
                              ),
                            ),
                            Text(
                              '(${food.ratingCount})',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.green[600],
                              ),
                            ),
                          ],
                        ),
                        const Gap(4),
                        Expanded(
                          child: Text(
                            food.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: GestureDetector(
                    onTap: () {
                      bottomSheet(context);
                    },
                    child: Container(
                      height: height * 0.19,
                      width: width * 0.38,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.5),
                        ),
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: NetworkImage(
                            food.image,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      height: height * 0.04,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.5),
                        ),
                        borderRadius: BorderRadius.circular(8),
                        color: const Color.fromARGB(255, 255, 255, 255),
                      ),
                      child: Center(
                        child: Text(
                          'ADD TO FAVORITE',
                          style: TextStyle(
                            color: Colors.orangeAccent,
                            fontSize: 15,
                            fontFamily: GoogleFonts.robotoCondensed().fontFamily,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Gap(20),
                  Expanded(
                    child: quantity == 0
                        ? GestureDetector(
                            onTap: () {
                              foodQuantityNotifier.incrementQty(food.id);
                            },
                            child: Container(
                              height: 30,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey.withOpacity(0.5),
                                ),
                                borderRadius: BorderRadius.circular(8),
                                color: const Color.fromARGB(255, 255, 255, 255),
                              ),
                              child: Center(
                                child: Text(
                                  'ADD',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 15,
                                    fontFamily: GoogleFonts.robotoCondensed().fontFamily,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Container(
                            height: 30,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey.withOpacity(0.5),
                              ),
                              borderRadius: BorderRadius.circular(8),
                              color: const Color.fromARGB(255, 255, 255, 255),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    foodQuantityNotifier.decreaseQty(food.id);
                                  },
                                  child: const Icon(Icons.remove),
                                ),
                                Text(
                                  '$quantity',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    foodQuantityNotifier.incrementQty(food.id);
                                  },
                                  child: const Icon(Icons.add),
                                ),
                              ],
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void bottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return FoodsBottomSheetWidget(food: food);
      },
    );
  }
}
