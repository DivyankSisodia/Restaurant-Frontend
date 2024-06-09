import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class RestaurantImageWidget extends StatelessWidget {
  const RestaurantImageWidget({
    super.key,
    required this.height,
    required this.image,
  });

  final double height;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.21,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        image: DecorationImage(
          image: CachedNetworkImageProvider(
            image,
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
