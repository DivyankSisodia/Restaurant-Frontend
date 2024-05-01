import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class RestaurantFoodList extends StatelessWidget {
  const RestaurantFoodList({
    super.key,
    required this.listOfFoods,
  });

  final List<Map<String, dynamic>> listOfFoods;

  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      itemBuilder: (context, index) {
        final food = listOfFoods[index];
        // Access the properties of each food map using the correct keys
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
                food['image'] as String, // Access 'image' property
                width: double.infinity,
                height: 150,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 8),
              Text(
                food['title'] as String, // Access 'title' property
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Price: \$${food['price']}', // Access 'price' property
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
      itemCount: listOfFoods.length, // Use the length of listOfFoods
    );
  }
}
