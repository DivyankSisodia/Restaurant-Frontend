import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../model/search_food.model.dart';
import '../services/search_food.service.dart';


final foodControllerProvider =
    ChangeNotifierProvider((ref) => FoodController());

class FoodController extends ChangeNotifier {
  final TextEditingController searchController = TextEditingController();
  List<FoodItem> foodData = [];
  List<FoodItem> filteredFoodData = [];
  bool isLoading = true;
  String error = '';

  FoodController() {
    fetchFoodData();
  }

  Future<void> fetchFoodData() async {
    try {
      foodData = await FoodService.fetchFoodData();
      isLoading = false;
    } catch (e) {
      isLoading = false;
      error = e.toString();
    }
    notifyListeners();
  }

  void searchFood(String query) {
    if (foodData.isNotEmpty) {
      if (query.isEmpty) {
        filteredFoodData = [];
      } else {
        filteredFoodData = foodData.where((food) {
          return food.title.toLowerCase().contains(query.toLowerCase()) ||
              food.description.toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
      notifyListeners();
    }
  }

  void onSearch() {
    searchFood(searchController.text);
  }
}
