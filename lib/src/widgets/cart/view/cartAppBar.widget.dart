import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_delivery/src/controller/foodQuantity.controller.dart';

import '../widgets/cartAddressWidget.dart';

class CartAppBarWidget extends ConsumerWidget {
  const CartAppBarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(CupertinoIcons.back),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'My Cart',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: IconButton(
                  onPressed: () {
                    ref.read(cartProvider.notifier).clearCart();
                    final snackBar = SnackBar(
                      /// need to set following properties for best effect of awesome_snackbar_content
                      behavior: SnackBarBehavior.fixed,
                      backgroundColor: Colors.transparent,
                      content: AwesomeSnackbarContent(
                        color: Colors.green.shade700,
                        title: 'Cart Cleared!',
                        message: 'Cart has been cleared successfully!',
                        contentType: ContentType.success,
                      ),
                    );

                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(snackBar);
                  },
                  icon: const Icon(CupertinoIcons.delete),
                  color: Colors.red,
                  iconSize: 25,
                ),
              )
            ],
          ),
          const Divider(),
          const SizedBox(height: 10),
          const CartAddressWidget(),
        ],
      ),
    );
  }
}
