import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class FoodItemWidget extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;

  const FoodItemWidget({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: width,
        height: height * 0.17,
        child: Card(
          color: Colors.white,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    imageUrl,
                    height: height * 0.15,
                    width: width * 0.3,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: GoogleFonts.dmSans().fontFamily,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Flexible(
                        fit: FlexFit.loose,
                        child: Text(
                          description,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                            fontFamily: GoogleFonts.dmSans().fontFamily,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const Gap(10),
                      Flexible(
                        fit: FlexFit.loose,
                        child: Container(
                          height: height * 0.04,
                          alignment: Alignment.bottomRight,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Colors.orangeAccent.withOpacity(0.8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              'Order Now',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontFamily: GoogleFonts.dmSans().fontFamily,
                                fontWeight: FontWeight.w500,
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
      ),
    );
  }
}
