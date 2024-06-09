import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../../bottom_navbar.dart';

class EmptyCartWidget extends StatelessWidget {
  const EmptyCartWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.grey[200], // Background color for the list
      child: Column(
        children: [
          const SizedBox(height: 20),
          Lottie.network(
            'https://lottie.host/b89e1ba5-9d84-40b1-a182-baabc467b3d6/HtfOdYnszd.json',
            height: 200,
          ),
          const SizedBox(height: 20),
          Text(
            'Your cart is empty!',
            style: TextStyle(
              color: Colors.amber.shade700,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Looks like you haven\'t added anything to your cart yet',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade900,
              fontFamily: GoogleFonts.dmSans().fontFamily,
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CustomBottomNavBar(),
                ),
              );
            },
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.amber.shade700,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text(
                  'Start Shopping',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
