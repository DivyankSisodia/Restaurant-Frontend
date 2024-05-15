import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SocialMediaIcons extends StatelessWidget {
  const SocialMediaIcons(
      {super.key,
      required this.bgColor,
      required this.iconColor,
      required this.icon});

  final Color bgColor;
  final Color iconColor;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 70,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Center(
        child: FaIcon(
          icon,
          size: 30,
          color: iconColor,
        ),
      ),
    );
  }
}
