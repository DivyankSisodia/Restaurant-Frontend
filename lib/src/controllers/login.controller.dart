import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Import flutter_riverpod
import 'package:food_delivery/src/views/home.screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

final loginProvider = ChangeNotifierProvider((ref) => LoginController());

class LoginController extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late SharedPreferences pref;

  void initSharedPref() async {
    pref = await SharedPreferences.getInstance();
  }

  Future<void> loginUser(BuildContext context) async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      print('Email or password cannot be empty');
      return;
    }

    var resBody = {
      "email": emailController.text,
      "password": passwordController.text,
    };

    print(resBody);

    try {
      print('Connecting...');
      var response = await http.post(
        Uri.parse(
            'https://restaurants-backend-gnl2.onrender.com/api/v1/auth/login'),
        body: jsonEncode(resBody),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      print('Response: ${response.body}');

      if (response.statusCode == 200) {
        var jsonRes = jsonDecode(response.body);

        if (jsonRes['success'] != null && jsonRes['success'] == true) {
          var myToken = jsonRes['token'] ?? '';
          print('Token: $myToken');

          // Navigate to HomeScreen with the token and user data
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(
                  token: myToken, userData: jsonRes['user']),
            ),
          );
        } else {
          var errorMessage = jsonRes['message'] ?? 'Unknown error';
          print('Login failed: $errorMessage');
        }
      } else {
        print('Failed to login, status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error connecting: $error');
    }
  }
}
