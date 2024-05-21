import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../controller/search_food.controller.dart';
import '../model/Hive/searched_food_history.dart';
import '../widgets/common/custom_loading_page.dart';
import '../widgets/food/view/food.searchBar.widget.dart';
import '../widgets/search/food_cards.dart';

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
    final newSearch = SearchedFoodHistory()..title = searchTerm;
    _searchedFoodBox.add(newSearch);
  }

  @override
  Widget build(BuildContext context) {
    final foodController = ref.watch(foodControllerProvider);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          FoodSearchBar(
            controller: foodController.searchController,
            onSearch: () {
              final searchText = foodController.searchController.text.trim();
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
            child: DecoratedBox(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: ValueListenableBuilder(
                valueListenable: _searchedFoodBox.listenable(),
                builder: (BuildContext context, Box<SearchedFoodHistory> box,
                    Widget? _) {
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
          else if (foodController.filteredFoodData.isEmpty)
            SliverFillRemaining(
              child: Center(
                child: Text(
                  'No results found for "${foodController.searchController.text}"',
                  style: const TextStyle(
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
            ),
          ),
        ],
      ),
    );
  }
}
