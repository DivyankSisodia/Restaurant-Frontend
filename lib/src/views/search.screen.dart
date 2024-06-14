// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../controller/search_food.controller.dart';
import '../model/searched_food_history.dart';
import '../widgets/common/custom_loading_page.dart';
import '../widgets/common/heading_text.dart';
import '../widgets/food/view/food.searchBar.widget.dart';
import '../widgets/search/food_cards.dart';
import 'package:collection/collection.dart';

import '../widgets/search/restuarantItemWidget.dart';

class FoodSearchScreen extends ConsumerStatefulWidget {
  const FoodSearchScreen({super.key});

  @override
  _FoodSearchScreenState createState() => _FoodSearchScreenState();
}

class _FoodSearchScreenState extends ConsumerState<FoodSearchScreen> {
  late final Box<SearchedFoodHistory> _searchedFoodBox;

  @override
  void initState() {
    super.initState();
    _searchedFoodBox = Hive.box<SearchedFoodHistory>('searchedFoodBox');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(foodControllerProvider).fetchFoodData();
    });
  }

  void _saveSearchTerm(String searchTerm) {
    final existingSearch = _searchedFoodBox.values.firstWhereOrNull(
      (history) => history.title == searchTerm,
    );

    if (existingSearch == null) {
      final newSearch = SearchedFoodHistory()..title = searchTerm;
      _searchedFoodBox.add(newSearch);
    }
  }

  @override
  Widget build(BuildContext context) {
    final foodController = ref.watch(foodControllerProvider);

    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: AppBar(
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.shopping_cart),
                      onPressed: () {
                        // Navigate to the cart screen
                      },
                    ),
                  ],
                  backgroundColor: Colors.white,
                  title: const Center(
                    child: HeadingText(
                      title: 'Hunt for your next meal...',
                    ),
                  ),
                ),
              ),
              FoodSearchBar(
                controller: foodController.searchController,
                onSearch: () {
                  final searchText =
                      foodController.searchController.text.trim();
                  if (searchText.isNotEmpty) {
                    _saveSearchTerm(searchText);
                    foodController.onSearch();
                  }
                },
                onChanged: (value) {
                  foodController.searchFood(value);
                },
              ),
              SliverToBoxAdapter(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {
                      _searchedFoodBox.clear();
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 16.0),
                      padding: const EdgeInsets.all(8.0),
                      width: 100,
                      decoration: BoxDecoration(
                        color:
                            const Color.fromARGB(255, 3, 2, 2).withOpacity(0.8),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Delete All',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: GoogleFonts.dmSans().fontFamily,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: ValueListenableBuilder(
                    valueListenable: _searchedFoodBox.listenable(),
                    builder: (BuildContext context,
                        Box<SearchedFoodHistory> box, Widget? _) {
                      final List<SearchedFoodHistory> searchHistory =
                          box.values.toList();
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Wrap(
                          spacing: 8.0,
                          runSpacing: 8.0,
                          children: searchHistory.map((history) {
                            return TextFieldWithIcon(
                              height: 40.0,
                              backgroundColor: Colors.white,
                              icon: Icons.history,
                              label: history.title,
                            );
                          }).toList(),
                        ),
                      );
                    },
                  ),
                ),
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
                SliverFillRemaining(
                  child: DecoratedBox(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Text(
                        'Search your favorite food...',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: GoogleFonts.dmSans().fontFamily,
                        ),
                      ),
                    ),
                  ),
                )
              else if (foodController.filteredFoodData.isEmpty)
                SliverFillRemaining(
                  child: DecoratedBox(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Text(
                        'No results found for "${foodController.searchController.text}"',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: GoogleFonts.dmSans().fontFamily,
                          color: Colors.redAccent.shade200,
                        ),
                      ),
                    ),
                  ),
                )
              else if (foodController.isRestaurantSearch)
                SliverToBoxAdapter(
                  child: RestaurantItemWidget(
                    restaurantName: foodController.matchedRestaurant,
                  ),
                )
              else
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      final food = foodController.filteredFoodData[index];
                      return Container(
                        color: Colors.white,
                        child: FoodItemWidget(
                          title: food.title,
                          description: food.description,
                          imageUrl: food.imageUrl,
                        ),
                      );
                    },
                    childCount: foodController.filteredFoodData.length,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class TextFieldWithIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final double height;
  final Color backgroundColor;

  const TextFieldWithIcon({
    super.key,
    required this.icon,
    required this.label,
    this.backgroundColor = Colors.grey,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40.0),
        border: Border.all(
          color: Colors.black54,
        ),
        color: backgroundColor,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 20,
          ),
          const SizedBox(width: 8.0),
          Text(
            label,
            style: TextStyle(
                fontSize: 14.0,
                fontFamily: GoogleFonts.poppins().fontFamily,
                fontWeight: FontWeight.w500,
                letterSpacing: 1.4),
          ),
        ],
      ),
    );
  }
}
