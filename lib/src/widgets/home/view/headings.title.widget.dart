import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../common/heading_row.dart';

class HomeScreenHeadingsTitle extends StatelessWidget {
  const HomeScreenHeadingsTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: FadeInLeft(
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
