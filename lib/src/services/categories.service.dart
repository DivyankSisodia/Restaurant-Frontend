import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:food_delivery/src/model/category.model.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class FoodServices {
  String baseUrl = dotenv.env['API_BASE_URL'] ?? '';

  Future<List<FoodCategory>> getCategories() async {
    String endpoint = 'category/getAll';

    Response response = await http.get(Uri.parse(baseUrl + endpoint));

    if (response.statusCode == 200) {
      final List<dynamic> result = jsonDecode(response.body)['data'];
      return result.map((e) => FoodCategory.fromMap(e)).toList();
    }else{
      throw Exception('Failed to load categories : ${response.reasonPhrase}');
    }
  }
}
