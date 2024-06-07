import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/src/model/food.model.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class FoodsBottomSheetWidget extends StatelessWidget {
  const FoodsBottomSheetWidget({
    Key? key,
    required this.food,
  }) : super(key: key);

  final Foods food;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Container(
        height: height * 0.5,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            Flexible(
              flex: 4,
              child: Container(
                height: height * 0.3,
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      child: SizedBox(
                        height: height * 0.3,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                          child: Hero(
                            tag: food.id,
                            child: CachedNetworkImage(
                              width: width,
                              imageUrl: food.image,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 0,
                      child: IconButton(
                        icon: Icon(
                          Iconsax.close_circle,
                          size: width * 0.08,
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
            ),
            Flexible(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  right: 8.0,
                  bottom: 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                            const Gap(5),
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
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily,
                                  ),
                                ),
                                const Gap(4),
                                Text(
                                  '(${food.ratingCount})', // Access 'rating' property
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.green[600],
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily,
                                  ),
                                ),
                              ],
                            ),
                            const Gap(2),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 3),
                              child: Text(
                                food.description,
                                // maxLines: 5,
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
                    const Gap(15),
                    Expanded(
                      flex: 3,
                      child: Container(
                        height: height * 0.04,
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
      ),
    );
  }
}
