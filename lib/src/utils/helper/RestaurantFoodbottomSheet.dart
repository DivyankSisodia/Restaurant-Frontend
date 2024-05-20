// ignore_for_file: file_names
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomSheetWidget extends StatelessWidget {
  const BottomSheetWidget({
    super.key,
    required this.food,
  });

  final Map<String, dynamic> food;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Container(
            height: 300,
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Stack(
              children: [
                CachedNetworkImage(
                  height: 300,
                  imageUrl: food['image'] as String,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 8.0,
              right: 8.0,
              bottom: 0,
            ),
            child: Row(
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
                  flex: 4,
                  child: Container(
                    height: 30,
                    width: 50,
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
}
