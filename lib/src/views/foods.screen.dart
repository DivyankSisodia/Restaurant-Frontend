import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/food/view/display.foods.widget.dart';
import '../widgets/food/view/food.searchBar.widget.dart';

class FoodScreen extends ConsumerWidget {
  const FoodScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController searchFoodController = TextEditingController();
    double height = MediaQuery.of(context).size.height;
    print(height);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          FoodSearchBar(searchFoodController: searchFoodController),
          const SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            sliver: DisplayFoodsWidget(),
          ),
        ],
      ),
    );
  }
}
