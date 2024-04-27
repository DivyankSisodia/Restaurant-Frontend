import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../model/restaurant.model.dart';

class RestaurantServices {
  String baseUrl = dotenv.env['API_BASE_URL'] ?? '';

  Future<List<Restaurants>> getRestaurantDetails() async {
    String endpoint = 'restaurant/all';

    Response response = await http.get(Uri.parse(baseUrl + endpoint));

    if (response.statusCode == 200) {
      final List<dynamic> result = jsonDecode(response.body)['data'];
      debugPrint('result: $result');
      return result.map((e) => Restaurants.fromMap(e)).toList();
    } else {
      throw Exception('Failed to load categories : ${response.reasonPhrase}');
    }
  }  
}
