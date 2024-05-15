// home_app_bar.dart

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    final box = Hive.box('user_info');
    final dynamic userAddress = box.get('address');
    final dynamic userProfilePic = box.get('profilePic');

    debugPrint('User address: $userAddress',);
    debugPrint('User profile pic: $userProfilePic');

    String addressText = '';
    if (userAddress != null) {
      if (userAddress is List) {
        addressText = userAddress.join(', ');
      } else {
        addressText = userAddress as String;
      }
    }

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
                addressText,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 5.0),
                child: Icon(
                  Icons.notifications,
                  color: Colors.redAccent,
                  size: 35,
                ),
              ),
              const Gap(10),
              CircleAvatar(
                radius: 24,
                backgroundImage: NetworkImage(
                  userProfilePic ?? 'https://via.placeholder.com/150',
                  scale: 0.2,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
