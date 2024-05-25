import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_delivery/src/controller/animtaion.controller.dart';

import '../widgets/promo_banner_slider.dart';

class BannerImages extends ConsumerWidget {
  const BannerImages({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final animationShow = ref.watch(animationStateProvider);
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: animationShow
            ? const PromoBannerSlider()
            : ElasticIn(
                delay: const Duration(milliseconds: 500),
                child: const PromoBannerSlider(),
              ),
      ),
    );
  }
}
