// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Import flutter_riverpod
import 'package:food_delivery/src/views/home.screen.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

final loginProvider = ChangeNotifierProvider((ref) => LoginController());

class LoginController extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late SharedPreferences pref;

  LoginController() {
    initSharedPref();
  }

  void initSharedPref() async {
    pref = await SharedPreferences.getInstance();
  }

  Future<void> loginUser(BuildContext context) async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      debugPrint('Email or password cannot be empty');
      return;
    }

    var resBody = {
      "email": emailController.text,
      "password": passwordController.text,
    };

    debugPrint('resBody $resBody');

    String baseUrl = dotenv.env['API_BASE_URL'] ?? '';
    String loginEndPoint = 'auth/login';

    String finalEndPoint = baseUrl + loginEndPoint;
    debugPrint('finalEndPoint: $finalEndPoint');

    try {
      debugPrint('Connecting...');
      var response = await http.post(
        Uri.parse(finalEndPoint),
        body: jsonEncode(resBody),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      debugPrint('Response: ${response.body}');

      if (response.statusCode == 200) {
        var jsonRes = jsonDecode(response.body);

        if (jsonRes['success'] != null && jsonRes['success'] == true) {
          var myToken = jsonRes['token'] ?? '';
          pref.setString('token', myToken);
          debugPrint('Token: $myToken');

          // Navigate to HomeScreen with the token and user data
          Navigator.push(
            context,
            PageTransition(
              duration: const Duration(milliseconds: 1200),
              type: PageTransitionType.leftToRightWithFade,
              child: HomeScreen(
                token: myToken,
                userData: jsonRes['user'],
              ),
            ),
          );
        } else {
          var errorMessage = jsonRes['message'] ?? 'Unknown error';
          debugPrint('Login failed: $errorMessage');
        }
      } else {
        debugPrint('Failed to login, status code: ${response.statusCode}');
      }
    } catch (error) {
      debugPrint('Error connecting: $error');
    }
  }
}
