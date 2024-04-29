import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import '../model/restaurant.model.dart';
import '../widgets/common/dot.separator.widget.dart';
import '../widgets/food/view/food.cards.dart';
import '../widgets/restaurant/widget/deliveryText.widget.dart';
import '../widgets/restaurant/widget/isAvailable.container.widget.dart';
import '../widgets/restaurant/widget/pureVeg.logoAndText.dart';
import '../widgets/restaurant/widget/restaurant.address.text.dart'; // Import your Restaurants model here

class FoodScreenWidget extends StatelessWidget {
  final Restaurants restaurant;

  const FoodScreenWidget({
    super.key,
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    String shortAddress = '';
    String remainingAddress = '';

    void splitAddress() {
      String address = restaurant.address;
      List<String> addressParts = address.split(',');
      if (addressParts.length >= 2) {
        // Check if there are at least two parts
        shortAddress = addressParts[0].trim();
        remainingAddress = addressParts[1];
        if (remainingAddress.isEmpty) {
          remainingAddress = '20-30mins';
        }
      } else {
        shortAddress = address;
        remainingAddress = ''; // Set remainingAddress to an empty string
      }
    }

    splitAddress();

    return Scaffold(
      appBar: AppBar(
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
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            height: height * 0.33,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(45),
                bottomRight: Radius.circular(45),
              ),
              color: Colors.grey[300],
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 20.0,
                left: 10.0,
                right: 10.0,
              ),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.black54.withOpacity(0.2),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.7),
                      blurRadius: 3,
                      spreadRadius: 2,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const PureVegIconAndText(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                restaurant.title,
                                style: TextStyle(
                                  fontSize: 21,
                                  color: Colors.black,
                                  fontFamily: GoogleFonts.poppins().fontFamily,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Gap(5),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    size: 20,
                                  ),
                                  const Gap(2),
                                  RestaurantSectionAddressText(
                                      address: shortAddress),
                                  const Gap(2),
                                  const DotSeparatorWidget(),
                                  RestaurantSectionAddressText(
                                    address: remainingAddress,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                height: height * 0.04,
                                width: width * 0.13,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.green,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    const Gap(5),
                                    Text(
                                      restaurant.rating.toString(),
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontFamily:
                                            GoogleFonts.poppins().fontFamily,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Gap(5),
                              Text(
                                '100 Reviews',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.black.withOpacity(0.8),
                                  fontFamily: GoogleFonts.poppins().fontFamily,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        children: [
                          const RestaurantSectionDeliveryText(
                              title: 'Delivery'),
                          const Gap(5),
                          IsAvailableContainer(
                            isOpen: restaurant.delivery,
                          ),
                          const Gap(5),
                          const DotSeparatorWidget(),
                          const Gap(5),
                          const RestaurantSectionDeliveryText(
                              title: 'Pickup Orders'),
                          const Gap(5),
                          IsAvailableContainer(
                            isOpen: restaurant.pickUp,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Divider(
                        color: Colors.black.withOpacity(0.1),
                        thickness: 1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/icons/delivery_boy.png',
                            height: 25,
                            width: 25,
                            color: Colors.grey.shade700,
                          ),
                          const Gap(8),
                          Container(
                            height: 20,
                            width: 1.5,
                            color: Colors.grey.shade700,
                          ),
                          const Gap(8),
                          Text(
                            '₹46 for delivery',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade700,
                              fontFamily: GoogleFonts.poppins().fontFamily,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Divider(
                        color: Colors.black.withOpacity(0.1),
                        thickness: 1,
                      ),
                    ),
                    const Gap(5),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          Text(
                            'Opening Time',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black.withOpacity(0.8),
                              fontFamily: GoogleFonts.poppins().fontFamily,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Gap(5),
                          const DotSeparatorWidget(),
                          const Gap(5),
                          Text(
                            restaurant.time,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black.withOpacity(0.8),
                              fontFamily: GoogleFonts.poppins().fontFamily,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Gap(8),
                          Container(
                            height: 20,
                            width: 1.5,
                            color: Colors.grey.shade700,
                          ),
                          const Gap(5),
                          Text(
                            'Open',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black.withOpacity(0.8),
                              fontFamily: GoogleFonts.poppins().fontFamily,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Gap(8),
                          Container(
                            height: 15,
                            width: 15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color:
                                  restaurant.pickUp ? Colors.green : Colors.red,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  blurRadius: 1,
                                  spreadRadius: 1,
                                  offset: const Offset(0, 0),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Icon(
                                restaurant.pickUp ? Icons.check : Icons.close,
                                color: Colors.white,
                                size: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          // Display your list of foods here based on the restaurant data
          Expanded(
            child: ListView.builder(
              itemCount: restaurant.foods.length,
              itemBuilder: (context, index) {
                final food = restaurant.foods[index];
                // Check if the food is a map and contains the 'title' and 'price' fields
                if (food is Map<String, dynamic> &&
                    food.containsKey('title') &&
                    food.containsKey('price') &&
                    food.containsKey('image')) {
                  return FoodItemWidget(
                    title: food['title'] as String,
                    price: food['price'].toString(),
                    imageUrl: food['image'] as String,
                  );
                } else {
                  // Handle the case where food is not in the expected format (optional)
                  return const ListTile(
                    title: Text('Unknown Food'),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
