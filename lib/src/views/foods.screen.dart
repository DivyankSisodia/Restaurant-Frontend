import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icon_craft/icon_craft.dart';
import 'package:iconsax/iconsax.dart';
import 'package:page_transition/page_transition.dart';

import '../widgets/common/heading_text.dart';
import '../widgets/food/view/display.foods.widget.dart';
import '../widgets/food/view/food.searchBar.widget.dart';
import 'favorite.screen.dart';
import 'search.screen.dart';

class FoodScreen extends ConsumerWidget {
  const FoodScreen({super.key, required this.token});

  final String? token;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double height = MediaQuery.of(context).size.height;
    debugPrint('height: $height');
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor:
              Colors.white, // Ensure the Scaffold has a white background color
          body: Container(
            color: Colors.white, // Set your desired background color here
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: AppBar(
                    leading: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        // Navigate back to the previous screen
                      },
                    ),
                    actions: [
                      IconButton(
                        icon: IconCraft(
                          Icon(
                            Iconsax.heart5,
                            color: Colors.amber.shade400,
                            size: 30.0,
                          ),
                          const Icon(
                            Iconsax.shopping_bag5,
                            color: Colors.green,
                          ),
                          alignment: Alignment.topRight,
                          decoration: const IconDecoration(
                            border: IconBorder(
                              color: Colors.white,
                              width: 2.0,
                            ),
                          ),
                        ),
                        onPressed: () {
                          // Navigate to the cart screen
                          Navigator.push(
                            context,
                            PageTransition(
                              duration: const Duration(milliseconds: 600),
                              reverseDuration:
                                  const Duration(milliseconds: 400),
                              child: LikedRestaurantsScreen(
                                token: token,
                              ),
                              type: PageTransitionType.rightToLeftWithFade,
                            ),
                          );
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
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        duration: const Duration(milliseconds: 600),
                        reverseDuration: const Duration(milliseconds: 400),
                        child: const FoodSearchScreen(),
                        type: PageTransitionType.rightToLeftWithFade,
                      ),
                    );
                  },
                ),
                const SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  sliver: DisplayFoodsWidget(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
