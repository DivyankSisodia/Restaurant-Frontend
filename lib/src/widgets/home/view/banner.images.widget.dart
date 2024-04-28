import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../widgets/promo_banner_slider.dart';

class BannerImages extends StatelessWidget {
  const BannerImages({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ElasticIn(
          delay: const Duration(milliseconds: 500),
          child: const PromoBannerSlider(),
        ),
      ),
    );
  }
}
