import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_transition/page_transition.dart';

import '../widgets/food/view/display.foods.widget.dart';
import '../widgets/food/view/food.searchBar.widget.dart';
import '../widgets/food/widget/food.appbar.dart';
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
                const SliverToBoxAdapter(child: FoodAppBarWidget()),
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
