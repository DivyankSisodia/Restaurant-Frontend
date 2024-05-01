import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../model/restaurant.model.dart';
import '../utils/helper/filterFood.dart';
import '../utils/helper/splitAddress.dart';
import '../widgets/common/heading_row.dart';
import '../widgets/restaurant/view/restaurant.coupons.dart';
import '../widgets/restaurant/view/restaurant.details.container.dart';
import '../widgets/restaurant/view/restaurant.foodList.dart';
import '../widgets/restaurant/view/restaurant.headingText.dart';
// Import your Restaurants model here

class FoodScreenWidget extends StatefulWidget {
  final Restaurants restaurant;

  const FoodScreenWidget({
    super.key,
    required this.restaurant,
  });

  @override
  State<FoodScreenWidget> createState() => _FoodScreenWidgetState();
}

class _FoodScreenWidgetState extends State<FoodScreenWidget> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> listOfFoods = [];

  @override
  void initState() {
    super.initState();
    listOfFoods = List.from(widget.restaurant.foods);
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  void filterFoods(String keyword) {
    setState(() {
      listOfFoods = FoodFilter.filterFoods(widget.restaurant.foods, keyword);
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('foodsList --------: $listOfFoods');
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    String shortAddress =
        AddressHelper.getShortAddress(widget.restaurant.address);
    String remainingAddress =
        AddressHelper.getRemainingAddress(widget.restaurant.address);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          RestaurantDetailsHeaderContainer(
            height: height,
            restaurant: widget.restaurant,
            shortAddress: shortAddress,
            remainingAddress: remainingAddress,
            width: width,
          ),
          RestaurantDiscountCoupons(
            height: height,
            width: width,
          ),
          const MenuHeadingText(),
          buildSearchBar(height),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(left: 3.0, bottom: 25),
              child: HeadingRow(
                title: 'Popular Dishes',
              ),
            ),
          ),
          RestaurantFoodList(listOfFoods: listOfFoods),
        ],
      ),
    );
  }

  SliverAppBar buildSearchBar(double height) {
    return SliverAppBar(
      floating: true,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          height: height * 0.08,
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
          ),
          color: Colors.transparent,
          child: TextFormField(
            cursorColor: Colors.grey[400],
            onChanged: (value) {
              filterFoods(value);
            },
            controller: _searchController,
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
                      filterFoods(_searchController.text);
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
