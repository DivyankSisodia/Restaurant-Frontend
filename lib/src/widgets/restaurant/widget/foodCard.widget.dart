import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/helper/bottomSheetWidget.dart';

class FoodCardWidget extends StatelessWidget {
  const FoodCardWidget({
    super.key,
    required this.height,
    required this.width,
    required this.food,
  });

  final double height;
  final double width;
  final Map<String, dynamic> food;

  @override
  Widget build(BuildContext context) {   
    return Container(
      height: height * 0.23,
      width: width,
      margin: const EdgeInsets.only(
        // vertical: 8,
        left: 16,
        right: 16,
        bottom: 10,
      ),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    food['title'] as String, // Access 'title' property
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Gap(4),
                  Text(
                    '₹${food['price']}', // Access 'price' property
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.green[600],
                        size: 13,
                      ),
                      Text(
                        '${food['rating']}', // Access 'rating' property
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.green[600],
                        ),
                      ),
                      Text(
                        '(${food['ratingCount']})', // Access 'rating' property
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.green[600],
                        ),
                      ),
                    ],
                  ),
                  const Gap(4),
                  Text(
                    maxLines: 3,
                    food['description']
                        as String, // Access 'description' property
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    bottomSheet(context);
                  },
                  child: Container(
                    height: height * 0.19,
                    width: width * 0.38,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.5),
                      ),
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: NetworkImage(
                          food['image'] as String, // Access 'image' property
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 30,
                    width: 80,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.5),
                      ),
                      borderRadius: BorderRadius.circular(8),
                      color: const Color.fromARGB(255, 255, 255, 255),
                    ),
                    child: Center(
                      child: Text(
                        'ADD',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 15,
                          fontFamily: GoogleFonts.robotoCondensed().fontFamily,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
   void bottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return BottomSheetWidget(food: food);
      },
    );
  }
}

