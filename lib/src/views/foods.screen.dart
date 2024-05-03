import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/food/view/display.foods.widget.dart';
import '../widgets/food/widget/food.appbar.dart';

class FoodScreen extends ConsumerWidget {
  const FoodScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: height * 0.04,
            floating: false,
            pinned: true,
            flexibleSpace: const FlexibleSpaceBar(
              background: FoodAppBarWidget(),
            ),
          ),
          const SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            sliver: DisplayFoodsWidget(),
          ),
        ],
      ),
    );
  }
}
