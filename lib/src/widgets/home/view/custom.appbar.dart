import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_delivery/src/controller/animtaion.controller.dart';
import 'package:gap/gap.dart';

import '../widgets/animated_searchBar.dart';
import '../widgets/home_appbar.dart';

class CustomAppBar extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final animtaionShow = ref.watch(animationStateProvider);

    return SliverAppBar(
      automaticallyImplyLeading: false,
      surfaceTintColor: Colors.transparent,
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      pinned: true,
      // floating: true,
      // stretch: true,
      expandedHeight: height * 0.195,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(10),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              child: animtaionShow
                  ? const AnimatedTextSearchBar()
                  : SlideInDown(
                      child: const AnimatedTextSearchBar(),
                    ),
            ),
            const Gap(5),
          ],
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              animtaionShow
                  ? HomeAppBar(
                      height: height,
                      width: width,
                    )
                  : FadeInRight(
                      onFinish: (direction) {
                        ref
                            .read(animationStateProvider.notifier)
                            .setAnimation();
                      },
                      delay: const Duration(milliseconds: 450),
                      child: HomeAppBar(
                        height: height,
                        width: width,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
