import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/userDetails.model.dart';
import 'package:http/http.dart' as http;

class UserDetailsService {
  late String _userId; // Declare _userId as a non-nullable String

  UserDetailsService() {
    _initializeUserId(); // Initialize _userId during construction
  }

  Future<void> _initializeUserId() async {
    final box = await Hive.openBox('user_info');
    _userId = box.get('userId')!; // Initialize _userId from Hive box
    debugPrint('User ID: $_userId');
  }

  Future<UserDetailsModel> getUserDetails() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString('token')!;

    debugPrint('Token: $token');

    const url =
        'https://restaurants-backend-gnl2.onrender.com/api/v1/user/getUser';

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': token,
      },
    );

    if (kDebugMode) {
      print('Response Body: ${response.body}');
    } // Print response body for debugging

    if (response.statusCode == 200) {
      try {
        final result = jsonDecode(response.body)['user'];
        final x = UserDetailsModel.fromMap(result);
        debugPrint('User Details: $x');
        return x;
      } catch (e) {
        throw Exception('Failed to parse user details: $e');
      }
    } else {
      throw Exception('Failed to load user details: ${response.reasonPhrase}');
    }
  }
}
