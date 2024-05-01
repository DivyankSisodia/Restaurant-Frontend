import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../model/restaurant.model.dart';
import '../widgets/restaurant/view/restaurant.coupons.dart';
import '../widgets/restaurant/view/restaurant.details.container.dart';
import '../widgets/restaurant/view/restaurant.headingText.dart';
import '../widgets/restaurant/view/restaurant.searchBar.dart';
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
          RestaurantDetailsHeaderContainer(
            height: height,
            restaurant: restaurant,
            shortAddress: shortAddress,
            remainingAddress: remainingAddress,
            width: width,
          ),
          RestaurantDiscountCoupons(
            height: height,
            width: width,
          ),
          const MenuHeadingText(),
          RestaurantsFoodSearchBar(height: height),
          SliverList.separated(
            itemBuilder: (context, index) {
              final food = restaurant.foods[index];
              // debugPrint('Food for restaurant: $food');
              // Check if the food is a map and contains the 'title' and 'price' fields
              return Container(
                height: 300,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(
                  // vertical: 8,
                  horizontal: 16,
                ),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey[200],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      food['image'] as String,
                      width: double.infinity,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      food['title'] as String,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Price: \$${food['price']}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => const Gap(10),
            itemCount: restaurant.foods.length,
          ),
        ],
      ),
    );
  }
}

