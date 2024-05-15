import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/helper/filterFood.dart';

class FoodSearchBar extends StatefulWidget {
  const FoodSearchBar({
    super.key,
    required TextEditingController searchFoodController,
  }) : _searchFoodController = searchFoodController;

  final TextEditingController _searchFoodController;

  @override
  State<FoodSearchBar> createState() => _FoodSearchBarState();
}

class _FoodSearchBarState extends State<FoodSearchBar> {
  List<Map<String, dynamic>> listOfFoods = [];

  void filterFoods(String keyword) {
    setState(() {
      listOfFoods = FoodFilter.filterFoods(listOfFoods, keyword);
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return SliverAppBar(
      expandedHeight: height * 0.1,
      elevation: 5,
      floating: true,
      stretch: true,
      pinned: true,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        background: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 8,
              bottom: 10,
            ),
            color: Colors.white,
            child: Center(
              child: TextFormField(
                cursorColor: Colors.grey[400],
                onChanged: (value) {
                  filterFoods(value);
                },
                controller: widget._searchFoodController,
                textAlign: TextAlign.start,
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
                          // filterFoods(_searchController.text);
                        },
                        icon: Icon(
                          Iconsax.search_favorite,
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
        ),
      ),
    );
  }
}
