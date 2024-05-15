// ignore_for_file: file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/src/model/food.model.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class FoodsBottomSheetWidget extends StatelessWidget {
  const FoodsBottomSheetWidget({
    super.key,
    required this.food,
  });

  final Foods food;

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
            height: 280,
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Stack(
              children: [
                Center(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    child: CachedNetworkImage(
                      height: 280,
                      imageUrl: food.image,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: IconButton(
                    icon: const Icon(
                      Iconsax.close_circle,
                      size: 32,
                      color: Colors.redAccent,
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
            child: SingleChildScrollView(
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
                            food.title, // Access 'title' property
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              fontFamily: GoogleFonts.poppins().fontFamily,
                            ),
                          ),
                          const Gap(4),
                          Text(
                            '₹${food.price}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                              fontFamily: GoogleFonts.poppins().fontFamily,
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
                                '${food.rating}', // Access 'rating' property
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.green[600],
                                  fontFamily: GoogleFonts.poppins().fontFamily,
                                ),
                              ),
                              Text(
                                '(${food.ratingCount})', // Access 'rating' property
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.green[600],
                                  fontFamily: GoogleFonts.poppins().fontFamily,
                                ),
                              ),
                            ],
                          ),
                          const Gap(2),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: .0),
                            child: Text(
                              food.description,
                              maxLines: 5,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[700],
                                fontFamily: GoogleFonts.poppins().fontFamily,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      height: 30,
                      width: 20,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.7),
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
                            fontFamily:
                                GoogleFonts.robotoCondensed().fontFamily,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
