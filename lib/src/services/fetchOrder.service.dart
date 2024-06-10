import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import '../model/order.model.dart';

Future<Order> fetchOrder() async {
  final userBox = Hive.box('user_info');
  final String userId = userBox.get('userId');
  debugPrint('User ID from Hive: $userId');
  final response = await http.get(
    Uri.parse(
      'https://restaurants-backend-gnl2.onrender.com/api/v1/order/$userId',
    ),
  );

  if (response.statusCode == 200) {
    return Order.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load orders');
  }
}
