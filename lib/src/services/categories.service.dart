import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:food_delivery/src/model/category.model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class FoodServices {
  String baseUrl = dotenv.env['API_BASE_URL'] ?? '';

  Future<List<FoodCategory>> getCategories() async {
    final categoryBox = Hive.box<FoodCategory>('foodCategoryBox');

    if (categoryBox.isNotEmpty) {
      return categoryBox.values.toList();
    } else {
      String endpoint = 'category/getAll';

      try {
        Response response = await http.get(Uri.parse(baseUrl + endpoint));

        if (response.statusCode == 200) {
          final List<dynamic> result = jsonDecode(response.body)['data'];
          final categories = result.map((e) => FoodCategory.fromMap(e)).toList();
          
          // Save the categories to the Hive box
          await categoryBox.addAll(categories);
          
          return categories;
        } else {
          // Return an empty list or a default value instead of throwing an exception
          return [];
        }
      } catch (e) {
        // Return the cached categories from the Hive box if there is an error (e.g., no internet)
        return categoryBox.values.toList();
      }
    }
  }
}
