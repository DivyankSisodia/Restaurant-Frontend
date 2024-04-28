import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../widgets/animated_searchBar.dart';
import '../widgets/home_appbar.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.height,
    required this.width,
    required this.address,
  });

  final double height;
  final double width;
  final String address;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.white,
      floating: true,
      stretch: true,
      expandedHeight: height * 0.139,
      flexibleSpace: FlexibleSpaceBar(
        background: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              FadeInRight(
                delay: const Duration(milliseconds: 250),
                child: HomeAppBar(
                  height: height,
                  width: width,
                  address: address,
                ),
              ),
              const SizedBox(height: 10),
              // Wrap AnimatedTextSearchBar with FadeInRight widget from animate_do package
              FadeInRight(
                delay: const Duration(milliseconds: 300),
                child: const AnimatedTextSearchBar(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
