// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'views/foods.screen.dart';
import 'views/home.screen.dart';
import 'views/login.screen.dart';
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
  List<Widget> _screens = []; // Initialize _screens as an empty list

  _CustomBottomNavBarState();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _token = prefs.getString('token');
      _address = prefs.getString('user_address');
      _initializeScreens(); // Call _initializeScreens after setting _token and _address
    });
  }

  void _initializeScreens() {
    _screens = [
      if (_token != null && !JwtDecoder.isExpired(_token!))
        HomeScreen(token: _token, userData: {
          'address': [_address]
        })
      else
        const LoginScreen(),
      const FoodScreen(),
      const SearchScreen(),
      const ProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens.isEmpty
          ? const CircularProgressIndicator() // Show a loading indicator if _screens is empty
          : _screens[_currentIndex],
      bottomNavigationBar: Container(
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
      ),
    );
  }
}
