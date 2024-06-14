import 'dart:convert';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<void> updatePassword(BuildContext context, String oldPassword, String newPassword) async {
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

  final url = Uri.parse(
      'https://restaurants-backend-gnl2.onrender.com/api/v1/user/changePassword');
  final body = json.encode({
    'oldPassword': oldPassword,
    'newPassword': newPassword,
  });

  try {
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': token,
      },
      body: body,
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      if (responseBody['success'] == true) {
        print('Password updated successfully');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: AwesomeSnackbarContent(
              title: 'Password Updated',
              message: 'Your password has been updated successfully',
              contentType: ContentType.success,
            ),
          ),
        );
      } else {
        print('Failed to update password: ${responseBody['message']}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: AwesomeSnackbarContent(
              title: 'Update Failed',
              message: responseBody['message'],
              contentType: ContentType.failure,
            ),
          ),
        );
      }
    } else {
      print('Failed to update password: ${response.statusCode}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: AwesomeSnackbarContent(
            title: 'Error ${response.statusCode}',
            message: 'Failed to update password',
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
          message: 'Failed to update password due to network error: $e',
          contentType: ContentType.failure,
        ),
      ),
    );
  }
}
