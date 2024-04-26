// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/home/animated_searchBar.dart';
import '../widgets/home/home_appbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.token, required this.userData});

  final token;
  final userData;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String address;

  @override
  void initState() {
    super.initState();

    debugPrint('Token: ${(widget.userData)}');

    try {
      if (widget.token != null) {
        Map<String, dynamic> jwtDecodeToken = JwtDecoder.decode(widget.token!);
        debugPrint('Decoded token: $jwtDecodeToken');

        // Set address from widget.userData
        address = widget.userData != null && widget.userData['address'] != null
            ? widget.userData['address'][0] ?? 'Unknown'
            : 'Unknown';

        debugPrint('Address found: $address');
      } else {
        debugPrint('Token is null');
        address = 'Unknown';
      }
    } catch (e) {
      debugPrint('Error decoding token: $e');
      address = 'Unknown';
    }

    // Store address using SharedPreferences
    storeAddress(address);
  }

  // Function to store address using SharedPreferences
  Future<void> storeAddress(String address) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_address', address);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Container(
          height: height,
          width: width,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 2),
            child: Column(
              children: [
                HomeAppBar(height: height, width: width, address: address),
                const Gap(10),
                AnimatedTextSearchBar(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
