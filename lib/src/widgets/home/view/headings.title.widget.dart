import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../../../controller/animtaion.controller.dart';
import '../../common/heading_row.dart';

class HomeScreenHeadingsTitle extends ConsumerWidget {
  const HomeScreenHeadingsTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final animationShow = ref.watch(animationStateProvider);
    return SliverToBoxAdapter(
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: animationShow
            ? Column(
                children: [
                  HeadingRow(title: title),
                  const Gap(15),
                ],
              )
            : FadeInLeft(
                delay: const Duration(milliseconds: 620),
                child: Column(
                  children: [
                    HeadingRow(title: title),
                    const Gap(15),
                  ],
                ),
              ),
      ),
    );
  }
}
