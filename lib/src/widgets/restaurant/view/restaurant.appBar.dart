import 'package:flutter/material.dart';

class RestaurantAppBar extends StatelessWidget implements PreferredSizeWidget {
  const RestaurantAppBar({
    super.key,
  });
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.grey[300],
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_rounded),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.favorite_outline_sharp,
            color: Colors.grey[700],
            size: 30,
          ),
          onPressed: () {
            // Navigate to the cart screen
          },
        ),
        Padding(
          padding: const EdgeInsets.only(right: 14.0),
          child: Image.asset(
            'assets/icons/upload.png',
            height: 30,
            width: 50,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }
}
