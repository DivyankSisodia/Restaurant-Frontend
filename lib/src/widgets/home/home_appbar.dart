import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
    required this.height,
    required this.width,
    required this.address,
  });

  final double height;
  final double width;
  final String address;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.07,
      width: width,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.shopping_bag,
                    color: Colors.redAccent,
                  ),
                  Text(
                    'Work',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Text(
                address,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 5.0),
                child: Icon(
                  Icons.notifications,
                  color: Colors.redAccent,
                  size: 35,
                ),
              ),
              Gap(10),
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(
                  'https://via.placeholder.com/150',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
