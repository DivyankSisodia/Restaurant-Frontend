// login_controller.dart

// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_delivery/src/bottom_navbar.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../views/login.screen.dart';

final loginProvider = ChangeNotifierProvider((ref) => LoginController());

class LoginController extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late SharedPreferences pref;
  late final Box box;
  bool _isLoading = false; // Added isLoading variable
  bool get isLoading => _isLoading;

  LoginController() {
    initSharedPref();
    box = Hive.box('user_info'); // Initialize the box instance
  }

  void initSharedPref() async {
    pref = await SharedPreferences.getInstance();
  }

  Future<void> loginUser(BuildContext context) async {
    // Toggle isLoading to true when login process starts
    _isLoading = true;
    notifyListeners();

    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      debugPrint('Email or password cannot be empty');
      ScaffoldMessenger.maybeOf(context)?.showSnackBar(
        SnackBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 10,
          backgroundColor: Colors.redAccent.shade400,
          content: const Text(
            'Email or password cannot be empty',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      );
      // Toggle isLoading back to false when login process ends
      _isLoading = false;
      notifyListeners();
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
          debugPrint('TokenInfo: $myToken');

          var user = jsonRes['user'];

          var userAddress = user['address'];
          box.put('address', userAddress);
          // debugPrint('User Address: $userAddress');
          var userProfile = user['profile'];
          // debugPrint('User profile: $userProfile');
          box.put('profilePic', userProfile);

          // Navigate to HomeScreen with the token and user data
          Navigator.push(
            context,
            PageTransition(
              duration: const Duration(milliseconds: 1200),
              childCurrent: const LoginScreen(),
              type: PageTransitionType.leftToRightJoined,
              child: const CustomBottomNavBar(),
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
    } finally {
      // Toggle isLoading back to false when login process ends
      _isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
