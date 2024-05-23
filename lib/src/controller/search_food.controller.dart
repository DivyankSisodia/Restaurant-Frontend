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
  bool isRestaurantSearch = false;
  String matchedRestaurant = '';

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
    isRestaurantSearch = false;
    matchedRestaurant = '';
    if (foodData.isNotEmpty) {
      if (query.isEmpty) {
        filteredFoodData = [];
      } else {
        filteredFoodData = foodData.where((food) {
          if (food.restaurantName.toLowerCase().contains(query.toLowerCase())) {
            isRestaurantSearch = true;
            matchedRestaurant = food.restaurantName;
            return true; // Keep this to find at least one matching restaurant
          }
          return food.title.toLowerCase().contains(query.toLowerCase()) ||
              food.description.toLowerCase().contains(query.toLowerCase()) ||
              food.restaurantName.toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
      if (isRestaurantSearch) {
        // Filter out all food items and keep only the restaurant information
        filteredFoodData = filteredFoodData.where((food) {
          return food.restaurantName == matchedRestaurant;
        }).toList();
      }
      notifyListeners();
    }
  }

  void onSearch() {
    searchFood(searchController.text);
  }
}
