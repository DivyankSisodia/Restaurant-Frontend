import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/search_food.model.dart';

class FoodService {
  static Future<List<FoodItem>> fetchFoodData() async {
    final response = await http.get(Uri.parse(
        'https://restaurants-backend-gnl2.onrender.com/api/v1/food/all'));

    if (response.statusCode == 200) {
      final responseBody = response.body;
      if (responseBody.isNotEmpty) {
        final decodedData = json.decode(responseBody);
        if (decodedData.containsKey('data')) {
          return (decodedData['data'] as List)
              .map((item) => FoodItem.fromJson(item))
              .toList();
        } else {
          throw Exception('Data key not found in the response');
        }
      } else {
        throw Exception('Response body is empty');
      }
    } else {
      throw Exception('Failed to load food data');
    }
  }
}
