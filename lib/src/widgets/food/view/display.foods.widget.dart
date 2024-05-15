import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_delivery/src/widgets/food/view/food.List.dart';

import '../../../controller/food.controller.dart';

class DisplayFoodsWidget extends StatelessWidget {
  const DisplayFoodsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final foodList = ref.watch(foodListProvider);
        return foodList.when(
          data: (foodList) {
            return SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 1.5,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return FoodScreenListWidget(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    food: foodList[index], // Pass the food item to the widget
                  );
                },
                childCount: foodList.length,
              ),
            );
          },
          error: (error, stack) {
            debugPrint('Error: $error');
            return SliverToBoxAdapter(
              child: Center(
                child: Text('Error: $error'),
              ),
            );
          },
          loading: () => const SliverToBoxAdapter(
            child: SizedBox(
              height: 500,
              child: Center(
              child: CircularProgressIndicator(),
            ),
            )
          ),
        );
      },
    );
  }
}
