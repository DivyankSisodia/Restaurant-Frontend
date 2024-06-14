import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

Future<void> updateUserDetail(BuildContext context, String phone,
    String userName, String email, String? address) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String? token = pref.getString('token');

  if (token == null) {
    print('Error: Token is null');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: AwesomeSnackbarContent(
          title: 'Token Error',
          message: 'User token is missing. Please log in again.',
          contentType: ContentType.failure,
        ),
      ),
    );
    return;
  }

  debugPrint('andar aagya');

  final url = Uri.parse(
      'https://restaurants-backend-gnl2.onrender.com/api/v1/user/updateUser');
  final body = json.encode({
    'phone': phone,
    'userName': userName,
    'email': email,
    'address': address,
  });

  debugPrint('body: $body');

  try {
    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': token,
      },
      body: body,
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    print('Response headers: ${response.headers}');

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      if (responseBody['success'] == true) {
        print('Profile updated successfully');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: AwesomeSnackbarContent(
              title: 'Profile Updated ✅',
              message: 'Your Profile Data has been updated successfully',
              contentType: ContentType.success,
            ),
          ),
        );
      } else {
        print('Failed to update profile: ${responseBody['message']}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: AwesomeSnackbarContent(
              title: 'Update Failed',
              message: responseBody['message'] ?? 'Please provide valid data',
              contentType: ContentType.warning,
            ),
          ),
        );
      }
    } else {
      print('Failed to update profile: ${response.statusCode}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: AwesomeSnackbarContent(
            title: 'Error ${response.statusCode}',
            message: 'Failed to update your info',
            contentType: ContentType.failure,
          ),
        ),
      );
    }
  } catch (e) {
    print('Network error: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: AwesomeSnackbarContent(
          title: 'Network Error',
          message: 'Failed to update profile due to network error: $e',
          contentType: ContentType.failure,
        ),
      ),
    );
  }
}
