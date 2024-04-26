// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 2),
            child: Column(
              children: [
                Container(
                  height: height * 0.07,
                  width: width,
                  color: const Color.fromARGB(0, 143, 19, 19),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
