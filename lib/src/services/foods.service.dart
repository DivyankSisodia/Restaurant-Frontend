import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:food_delivery/src/model/food.model.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class FoodServices{
  String baseUrl = dotenv.env['API_BASE_URL'] ?? '';

  Future<List<Foods>> getAllFoods() async {
    String endpoint = 'food/all';

    Response response = await http.get(Uri.parse(baseUrl + endpoint));

    if (response.statusCode == 200) {
      final List<dynamic> result = jsonDecode(response.body)['data'];
      debugPrint(' ---------food Results: $result');
      return result.map((e) => Foods.fromMap(e)).toList();
    }else{
      throw Exception('Failed to load categories : ${response.reasonPhrase}');
    }
  }
}