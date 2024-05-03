import 'package:flutter/material.dart';

class FoodAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const FoodAppBarWidget({
    super.key,
  });
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.grey[100],
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
            color: Colors.grey[500],
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
            color: Colors.grey[500],
          ),
        ),
      ],
    );
  }
}
