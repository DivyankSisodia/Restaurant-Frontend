// ignore_for_file: library_private_types_in_public_api

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'banner_image_container.dart';

class PromoBannerSlider extends StatefulWidget {
  const PromoBannerSlider({
    super.key,
  });

  @override
  _PromoBannerSliderState createState() => _PromoBannerSliderState();
}

class _PromoBannerSliderState extends State<PromoBannerSlider> {
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      carouselController: _controller,
      items: [
        for (int i = 1; i <= 3; i++)
          BannerContainer(
            image: AssetImage('assets/banner/banner$i.jpg'),
          ),
      ],
      options: CarouselOptions(
        viewportFraction: 1,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayCurve: Curves.fastOutSlowIn,
      ),
    );
  }
}
