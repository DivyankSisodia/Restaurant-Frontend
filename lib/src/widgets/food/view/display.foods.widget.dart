import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_delivery/src/widgets/food/view/food.List.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../../controller/food.controller.dart';
import '../../../controller/foodQuantity.controller.dart';

class DisplayFoodsWidget extends ConsumerStatefulWidget {
  const DisplayFoodsWidget({
    super.key,
  });

  @override
  ConsumerState<DisplayFoodsWidget> createState() => _DisplayFoodsWidgetState();
}

class _DisplayFoodsWidgetState extends ConsumerState<DisplayFoodsWidget> {
  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      _initializeFoodList();
      _isInitialized = true;
    }
  }

  void _initializeFoodList() async {
    final foodList = await ref.read(foodListProvider.future);
    ref.read(foodQuantityProvider.notifier).setFoods(foodList);
  }

  @override
  Widget build(BuildContext context) {
    final foodList = ref.watch(foodListProvider);
    ref.watch(foodQuantityProvider);

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
                food: foodList[index],
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
        child: Center(
          child: SizedBox(
            height: 100,
            width: 100,
            child: LoadingIndicator(
              indicatorType: Indicator.ballTrianglePathColoredFilled,
              colors: [
                Colors.orangeAccent,
                Colors.greenAccent,
                Colors.blueAccent
              ],
              strokeWidth: 2,
              backgroundColor: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
