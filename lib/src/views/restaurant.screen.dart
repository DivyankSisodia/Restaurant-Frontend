import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import '../model/restaurant.model.dart';
import '../widgets/food/view/food.cards.dart';
import '../widgets/restaurant/view/restaurant.appBar.dart';
import '../widgets/restaurant/view/restaurantInfo.container.dart';
// Import your Restaurants model here

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
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            expandedHeight: height * 0.4,
            flexibleSpace: FlexibleSpaceBar(
              background: Column(
                children: [
                  const RestaurantAppBar(),
                  Container(
                    padding: const EdgeInsets.all(8),
                    height: height * 0.33,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(45),
                        bottomRight: Radius.circular(45),
                      ),
                      color: Colors.grey[300], // Container color
                    ),
                    child: RestaurantInfoContainer(
                      restaurant: restaurant,
                      shortAddress: shortAddress,
                      remainingAddress: remainingAddress,
                      height: height,
                      width: width,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.only(
                top: 20,
                left: 16,
                right: 16,
              ),
              height: height * 0.1,
              width: width * 0.8,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey[700]!,
                  width: 1,
                ),
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/logo/discount.png',
                        height: 50,
                        color: Colors.green[400],
                      ),
                      const Gap(10),
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '20% off up to ₹250',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Use code: FIRST20',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    height: height * 0.07,
                    width: width * 0.2,
                    decoration: BoxDecoration(
                      color: Colors.green[400],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(
                      child: Text(
                        'Apply',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Transform.rotate(
                    angle: 3.14 * 2.4,
                    child: Image.asset(
                      color: Colors.black87,
                      'assets/logo/pngwing.com (1).png',
                      height: 30,
                    ),
                  ),
                  const Gap(5),
                  Text(
                    'Menu',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey.shade600,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                    ),
                  ),
                  const Gap(5),
                  Transform.rotate(
                    angle: 4.4,
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/logo/pngwing.com (1).png',
                      height: 30,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: height * 0.08,
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: 10,
              ),
              child: TextFormField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.2),
                  hintText: 'Search for dishes...',
                  hintStyle: TextStyle(
                    color: Colors.grey[700],
                    fontFamily: GoogleFonts.poppins().fontFamily,
                  ),
                  border: InputBorder.none,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          // Handle search icon press
                        },
                        icon: Icon(
                          CupertinoIcons.search,
                          color: Colors.grey[800],
                        ),
                      ),
                      Container(
                        height: 20,
                        width: 2,
                        color: Colors.grey[600],
                      ),
                      IconButton(
                        onPressed: () {
                          // Handle mic icon press
                        },
                        icon: const Icon(
                          CupertinoIcons.mic_solid,
                          color: Colors.redAccent,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverList.separated(
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
            separatorBuilder: (context, index) => const Divider(),
            itemCount: restaurant.foods.length,
          ),
        ],
      ),
    );
  }
}
