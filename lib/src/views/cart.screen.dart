import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:food_delivery/src/utils/styles/text_style.dart';
import 'package:food_delivery/src/views/profile.screen.dart';
import 'package:food_delivery/src/widgets/common/dottedLine.widget.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:page_transition/page_transition.dart';
import '../controller/foodQuantity.controller.dart';
import '../model/cart.model.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);

    // Calculate the total price
    double totalPrice = 0;
    for (var item in cartItems) {
      totalPrice += (item.product.price * item.quantity);
    }

    // Example delivery charges
    double deliveryCharges = 36.0;

    double instantDiscount = 120.0;

    double platformFee = 5.00;

    double gstAndRestaurantCharges = 40.0;

    double total =
        totalPrice + platformFee + gstAndRestaurantCharges - instantDiscount;

    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            color: Colors.grey.shade200,
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: DecoratedBox(
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
                        const Divider(),
                        const SizedBox(height: 10),
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Icon(
                                    Iconsax.bag5,
                                    color: Colors.orange,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    '20-25 mins to Work',
                                    style: AppStyle.cartScreenMediumText,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  '|  House no.',
                                  style: AppStyle.cartScreenSmallText,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    color: Colors.grey[200], // Background color for the list
                    child:
                        const SizedBox(height: 10), // Placeholder for spacing
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final item = cartItems[index];
                      return CartItemWidget(item: item);
                    },
                    childCount: cartItems.length,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Container(
                      color: Colors.grey[200], // Background color for the list
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text(
                              'Bill Details',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: GoogleFonts.dmSans().fontFamily,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade300,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Item Total',
                                        style: AppStyle.cartScreenSmallText,
                                      ),
                                      Text(
                                        '₹${totalPrice.toStringAsFixed(2)}',
                                        style: AppStyle.cartScreenMediumText,
                                      )
                                    ],
                                  ),
                                  const Gap(10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Delivery Fee ... | 4 KM',
                                            style: AppStyle.cartScreenSmallText,
                                          ),
                                          const SizedBox(height: 3),
                                          const SizedBox(
                                            height: 2,
                                            width: 140,
                                            child: DottedLine(
                                              dashColor: Colors.black87,
                                              dashGapLength: 2,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        '₹${deliveryCharges.toStringAsFixed(2)}',
                                        style: AppStyle.cartScreenMediumText,
                                      )
                                    ],
                                  ),
                                  const Gap(6),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width - 100,
                                    child: Text(
                                      'This fee fairly goes to our delivery partners for delivering your food',
                                      style: AppStyle.cartScreenSmallestText,
                                    ),
                                  ),
                                  const Gap(8),
                                  const DottedLineWidget(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Item Discount',
                                            style: AppStyle.cartScreenSmallText,
                                          ),
                                          const SizedBox(height: 3),
                                          const SizedBox(
                                            height: 2,
                                            width: 90,
                                            child: DottedLine(
                                              dashColor: Colors.black87,
                                              dashGapLength: 2,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        '- ₹${instantDiscount.toStringAsFixed(2)}',
                                        style: AppStyle.cartScreenMediumText
                                            .copyWith(
                                          color: Colors.green,
                                        ),
                                      )
                                    ],
                                  ),
                                  const Gap(8),
                                  const DottedLineWidget(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Platform Fee',
                                            style: AppStyle.cartScreenSmallText,
                                          ),
                                          const SizedBox(height: 3),
                                          const SizedBox(
                                            height: 2,
                                            width: 90,
                                            child: DottedLine(
                                              dashColor: Colors.black87,
                                              dashGapLength: 2,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        '₹${platformFee.toStringAsFixed(2)}',
                                        style: AppStyle.cartScreenMediumText,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'GST and Restaurant Charges',
                                            style: AppStyle.cartScreenSmallText,
                                          ),
                                          const SizedBox(height: 3),
                                          const SizedBox(
                                            height: 2,
                                            width: 90,
                                            child: DottedLine(
                                              dashColor: Colors.black87,
                                              dashGapLength: 2,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        '₹${gstAndRestaurantCharges.toStringAsFixed(2)}',
                                        style: AppStyle.cartScreenMediumText,
                                      ),
                                    ],
                                  ),
                                  const Gap(8),
                                  const DottedLineWidget(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'To Pay',
                                            style: AppStyle.cartScreenTitle
                                                .copyWith(
                                              color: Colors.black,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        '₹${total.toStringAsFixed(2)}',
                                        style: AppStyle.mediumPriceText
                                            .copyWith(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ), // Placeholder for spacing
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CartItemWidget extends ConsumerWidget {
  final CartItem item;

  const CartItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int particularFoodPrirce = (item.product.price * item.quantity).toInt();
    return Slidable(
      closeOnScroll: true,
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              ref.read(cartProvider.notifier).deleteFromCart(item.product);
            },
            icon: Iconsax.trash,
            foregroundColor: Colors.red,
            backgroundColor: Colors.white,
          ),
        ],
      ),
      endActionPane: ActionPane(
        dragDismissible: true,
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            borderRadius: BorderRadius.circular(10),
            padding: const EdgeInsets.all(10),
            label: 'Decrease quantity',
            spacing: 10,
            onPressed: (context) {
              ref.read(cartProvider.notifier).removeFromCart(item.product);
            },
            icon: Iconsax.minus_cirlce5,
            foregroundColor: Colors.white,
            backgroundColor: Colors.amber.shade800,
          ),
        ],
      ),
      child: Container(
        margin: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 12.0,
                right: 12,
                top: 10,
              ),
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            item.product.title,
                            style: TextStyle(
                              letterSpacing: 1,
                              color: Colors.grey.shade700,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              fontFamily: GoogleFonts.dmSans().fontFamily,
                            ),
                          ),
                          Text(
                            item.product.restaurantName,
                            style: TextStyle(
                              letterSpacing: 0.9,
                              color: Colors.grey.shade500,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              fontFamily: GoogleFonts.dmSans().fontFamily,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 110,
                    height: 35,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.shade700.withOpacity(0.3),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.remove,
                            size: 18,
                            color: Colors.green,
                          ),
                          onPressed: () {
                            ref
                                .read(cartProvider.notifier)
                                .removeFromCart(item.product);
                          },
                        ),
                        Text(
                          '${item.quantity}',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontFamily: GoogleFonts.dmSans().fontFamily,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.add,
                            size: 18,
                            color: Colors.green,
                          ),
                          onPressed: () {
                            ref
                                .read(cartProvider.notifier)
                                .addToCart(item.product);
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 15),
                  Text(
                    '₹$particularFoodPrirce',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const Gap(5),
            const DottedLineWidget(),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Add more items',
                    style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontFamily: GoogleFonts.dmSans().fontFamily,
                        letterSpacing: 1),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Iconsax.shop),
                      color: Colors.black,
                      iconSize: 20,
                    ),
                  )
                ],
              ),
            ),
            const DottedLineWidget(),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Add Cooking Requests',
                    style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontFamily: GoogleFonts.dmSans().fontFamily,
                        letterSpacing: 1),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Iconsax.chart),
                      color: Colors.black,
                      iconSize: 20,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AnimationSwipe extends StatefulWidget {
  const AnimationSwipe({Key? key}) : super(key: key);

  @override
  State<AnimationSwipe> createState() => _AnimationSwipeState();
}

class _AnimationSwipeState extends State<AnimationSwipe> {
  bool isFinished = false;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SwipeableButtonView(
        buttonText: 'SLIDE TO PAYMENT',
        buttonWidget: const Icon(
          Icons.arrow_forward_ios_rounded,
          color: Colors.grey,
        ),
        activeColor: Colors.greenAccent,
        isFinished: isFinished,
        onWaitingProcess: () {
          Future.delayed(const Duration(seconds: 2), () {
            setState(() {
              isFinished = true;
            });
          });
        },
        onFinish: () async {
          await Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.fade,
              child: const ProfileScreen(),
            ),
          );
          setState(() {
            isFinished = false;
          });
        },
      ),
    );
  }
}
