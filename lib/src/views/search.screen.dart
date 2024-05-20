import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controller/search_food.controller.dart';
import '../widgets/common/custom_loading_page.dart';

import '../widgets/food/view/food.searchBar.widget.dart';
import '../widgets/search/food_cards.dart';

class FoodSearchScreen extends ConsumerWidget {
  const FoodSearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final foodController = ref.watch(foodControllerProvider);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          FoodSearchBar(
            controller: foodController.searchController,
            onSearch: foodController.onSearch,
            onChanged: foodController.searchFood,
          ),
          if (foodController.isLoading)
            const SliverFillRemaining(
              child: LoadingWidget(),
            )
          else if (foodController.error.isNotEmpty)
            SliverFillRemaining(
              child: Center(child: Text(foodController.error)),
            )
          else if (foodController.searchController.text.isEmpty &&
              foodController.filteredFoodData.isEmpty)
            const SliverFillRemaining(
              child: Center(
                child: Text(
                  'Enter a search term to see results',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          else
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  final food = foodController.filteredFoodData[index];
                  return FoodItemWidget(
                    title: food.title,
                    description: food.description,
                    imageUrl: food.imageUrl,
                  );
                },
                childCount: foodController.filteredFoodData.length,
              ),
            ),
        ],
      ),
    );
  }
}
