import 'package:flutter/material.dart';

import '../../common/category.dart';

class DisplayFoodCategoryWidget extends StatelessWidget {
  const DisplayFoodCategoryWidget({
    super.key,
    required this.height,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: SizedBox(
          height: height * 0.25,
          child: const CategoryScreen(),
        ),
      ),
    );
  }
}
