import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RestaurantsFoodSearchBar extends StatelessWidget {
  const RestaurantsFoodSearchBar({
    super.key,
    required this.height,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      automaticallyImplyLeading: false,
      expandedHeight: height * 0.08,
      backgroundColor:
          Colors.transparent, // Set the background color to transparent
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          height: height * 0.08,
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: 10,
          ),
          color: Colors.transparent, // Set the container color to transparent
          child: TextFormField(
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey.withOpacity(0.2),
              hintText: 'Search for dishes...',
              hintStyle: TextStyle(
                color: Colors.grey[700],
                fontFamily: GoogleFonts.poppins().fontFamily,
              ),
              border: InputBorder.none,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      // Handle search icon press
                    },
                    icon: Icon(
                      CupertinoIcons.search,
                      color: Colors.grey[800],
                    ),
                  ),
                  Container(
                    height: 20,
                    width: 2,
                    color: Colors.grey[600],
                  ),
                  IconButton(
                    onPressed: () {
                      // Handle mic icon press
                    },
                    icon: const Icon(
                      CupertinoIcons.mic_solid,
                      color: Colors.redAccent,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
