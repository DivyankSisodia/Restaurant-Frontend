import 'package:flutter/material.dart';
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

    try {
      if (widget.token != null) {
        Map<String, dynamic> jwtDecodeToken = JwtDecoder.decode(widget.token!);
        print('Decoded token: $jwtDecodeToken');

        // Set address from widget.userData
        if (widget.userData != null && widget.userData['address'] != null) {
          address = widget.userData['address'][0];
        } else {
          print('Address not found in userData');
          address = 'Unknown';
        }

        print('Address found: $address');
      } else {
        print('Token is null');
        address = 'Unknown';
      }
    } catch (e) {
      print('Error decoding token: $e');
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Address: $address'),
          ],
        ),
      ),
    );
  }
}
