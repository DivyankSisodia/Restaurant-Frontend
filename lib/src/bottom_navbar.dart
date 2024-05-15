// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/src/views/foods.screen.dart';
import 'package:food_delivery/src/views/sign.screen.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'views/home.screen.dart';
import 'views/profile.screen.dart';
import 'views/search.screen.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({super.key});

  @override
  _CustomBottomNavBarState createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  int _currentIndex = 0;
  String? _token;
  String? _address;
  late List<Widget> _screens = []; // Initialize _screens with an empty list

  @override
  void initState() {
    super.initState();
    _initializeScreens(); // Call _initializeScreens in initState
  }

  void _initializeScreens() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token');
    _address = prefs.getString('user_address');

    setState(() {
      if (_token != null && !JwtDecoder.isExpired(_token!)) {
        _screens = [
          HomeScreen(token: _token, userData: {
            'address': [_address]
          }),
          const FoodScreen(),
          const SearchScreen(),
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
    return Scaffold(
      body: _screens.isNotEmpty
          ? _screens[_currentIndex]
          : Container(), // Check if _screens is not empty before accessing its elements
      bottomNavigationBar: _token != null && !JwtDecoder.isExpired(_token!)
          ? Container(
              height: 100,
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
              child: CupertinoTabBar(
                // type: BottomNavigationBarType.fixed,
                // selectedFontSize: 12,
                // unselectedFontSize: 12,
                // selectedItemColor: Colors.orange,
                // unselectedItemColor: Colors.black,
                currentIndex: _currentIndex,
                onTap: (int index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                items: const [
                  BottomNavigationBarItem(
                    tooltip: 'Home',
                    icon: Icon(Iconsax.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Iconsax.box), // Replace with the correct icon
                    label: 'Food',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Iconsax.heart), // Replace with the correct icon
                    label: 'Favorites',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'Profile',
                  ),
                ],
              ),
            )
          : null, // Set bottomNavigationBar to null if token is expired or not present
    );
  }
}
