import 'package:flutter/material.dart';
import '../model/restaurant.model.dart'; // Import your Restaurants model here

class FoodScreenWidget extends StatelessWidget {
  final Restaurants restaurant;

  const FoodScreenWidget({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(restaurant.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Foods available at ${restaurant.title}:',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            // Display your list of foods here based on the restaurant data
            Expanded(
              child: ListView.builder(
                itemCount: restaurant.foods.length,
                itemBuilder: (context, index) {
                  final food = restaurant.foods[index];
                  debugPrint('Food: $food');
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
      ),
    );
  }
}

class FoodItemWidget extends StatelessWidget {
  final String title;
  final String price;
  final String imageUrl;

  const FoodItemWidget({
    Key? key,
    required this.title,
    required this.price,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey[200],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            imageUrl,
            width: double.infinity,
            height: 150,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Price: \$${price}',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}
