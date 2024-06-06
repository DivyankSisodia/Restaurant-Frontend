// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:food_delivery/src/views/cart.screen.dart';
import 'package:food_delivery/src/views/foods.screen.dart';
import 'package:food_delivery/src/views/sign.screen.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'views/home.screen.dart';
import 'views/profile.screen.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({super.key});

  @override
  _CustomBottomNavBarState createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  int _currentIndex = 0;
  String? _token;
  late List<Widget> _screens = []; // Initialize _screens with an empty list

  @override
  void initState() {
    super.initState();
    _initializeScreens(); // Call _initializeScreens in initState
  }

  void _initializeScreens() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token');

    setState(() {
      if (_token != null && !JwtDecoder.isExpired(_token!)) {
        _screens = [
          HomeScreen(token: _token),
          FoodScreen(
            token: _token,
          ),
          const CartScreen(),
          const ProfileScreen(),
        ];
      } else {
        _screens = [
          const SignUpScreen(),
          Container(), // Add an empty container for each bottom navigation bar item
          Container(),
          Container(),
        ];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: _screens.isNotEmpty
          ? _screens[_currentIndex]
          : Container(), // Check if _screens is not empty before accessing its elements
      bottomNavigationBar: _token != null && !JwtDecoder.isExpired(_token!)
          ? Container(
              height: height * 0.11,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: BottomNavigationBar(
                backgroundColor: Colors.white,
                iconSize: height * 0.035,
                type: BottomNavigationBarType.fixed,
                selectedFontSize: 12,
                unselectedFontSize: 12,
                selectedItemColor: Colors.orange,
                unselectedItemColor: Colors.black,
                currentIndex: _currentIndex,
                onTap: (int index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                items: const [
                  BottomNavigationBarItem(
                    tooltip: 'Home',
                    icon: Icon(
                      Iconsax.home,
                    ),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Iconsax.box,
                    ), // Replace with the correct icon
                    label: 'Food',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Iconsax.shopping_cart,
                    ), // Replace with the correct icon
                    label: 'Cart',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.person,
                    ),
                    label: 'Profile',
                  ),
                ],
              ),
            )
          : null, // Set bottomNavigationBar to null if token is expired or not present
    );
  }
}
