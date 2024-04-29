import 'package:flutter/material.dart';

class LinearGradientContainerWidget extends StatelessWidget {
  const LinearGradientContainerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          backgroundBlendMode: BlendMode.darken,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              Colors.black.withOpacity(0.1),
              Colors.black.withOpacity(0.1),
              Colors.black.withOpacity(0.2),
              Colors.black.withOpacity(0.3),
            ],
          ),
        ),
      ),
    );
  }
}
