import 'package:flutter/material.dart';
import 'package:icon_craft/icon_craft.dart';
import 'package:iconsax/iconsax.dart';
import 'package:page_transition/page_transition.dart';

import '../../../views/favorite.screen.dart';
import '../../common/heading_text.dart';

class FoodAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const FoodAppBarWidget({
    super.key,
    this.token,
  });
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  final String? token;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_rounded),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      actions: [
        IconButton(
          icon: IconCraft(
            Icon(
              Iconsax.heart5,
              color: Colors.amber.shade400,
              size: 30.0,
            ),
            const Icon(
              Iconsax.shopping_bag5,
              color: Colors.green,
            ),
            alignment: Alignment.topRight,
            decoration: const IconDecoration(
              border: IconBorder(
                color: Colors.white,
                width: 2.0,
              ),
            ),
          ),
          onPressed: () {
            // Navigate to the cart screen
            Navigator.push(
              context,
              PageTransition(
                duration: const Duration(milliseconds: 600),
                reverseDuration: const Duration(milliseconds: 400),
                child: LikedRestaurantsScreen(
                  token: token,
                ),
                type: PageTransitionType.rightToLeftWithFade,
              ),
            );
          },
        ),
      ],
      backgroundColor: Colors.white,
      title: const Center(
        child: HeadingText(
          title: 'Hunt for your next meal...',
        ),
      ),
    );
  }
}
