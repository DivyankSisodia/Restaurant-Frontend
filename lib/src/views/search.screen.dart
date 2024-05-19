import 'dart:convert';
import 'package:food_delivery/src/widgets/food/view/food.searchBar.widget.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../widgets/search/food_cards.dart';

class FoodSearchScreen extends StatefulWidget {
  const FoodSearchScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FoodSearchScreenState createState() => _FoodSearchScreenState();
}

class _FoodSearchScreenState extends State<FoodSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _foodData = [];
  List<dynamic> _filteredFoodData = [];
  bool _isLoading = true;
  String _error = '';

  @override
  void initState() {
    super.initState();
    fetchFoodData();
  }

  void fetchFoodData() async {
    try {
      final response = await http.get(Uri.parse(
          'https://restaurants-backend-gnl2.onrender.com/api/v1/food/all'));

      if (response.statusCode == 200) {
        final responseBody = response.body;
        if (responseBody.isNotEmpty) {
          final decodedData = json.decode(responseBody);
          if (decodedData.containsKey('data')) {
            setState(() {
              _foodData = decodedData['data'];
              _isLoading = false;
            });
          } else {
            throw Exception('Data key not found in the response');
          }
        } else {
          throw Exception('Response body is empty');
        }
      } else {
        throw Exception('Failed to load food data');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _error = e.toString();
      });
    }
  }

  void searchFood(String query) {
    if (_foodData.isNotEmpty) {
      if (query.isEmpty) {
        setState(() {
          _filteredFoodData = [];
        });
      } else {
        List<dynamic> filteredFood = _foodData.where((food) {
          return (food['title'] ?? '')
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              (food['description'] ?? '')
                  .toLowerCase()
                  .contains(query.toLowerCase());
        }).toList();

        setState(() {
          _filteredFoodData = filteredFood;
        });
      }
    }
  }

  void _onSearch() {
    searchFood(_searchController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          FoodSearchBar(
            controller: _searchController,
            onSearch: _onSearch,
            onChanged: (value) {
              searchFood(value);
            },
          ),
          if (_isLoading)
            const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            )
          else if (_error.isNotEmpty)
            SliverFillRemaining(
              child: Center(child: Text(_error)),
            )
          else if (_searchController.text.isEmpty && _filteredFoodData.isEmpty)
            const SliverFillRemaining(
              child: Center(
                child: Text(
                  'Enter a search term to see results',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          else
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  final food = _filteredFoodData[index];
                  return FoodItemWidget(
                    title: food['title'] ?? '',
                    description: food['description'] ?? '',
                    imageUrl: food['image'] ??
                        'https://via.placeholder.com/100', // Default image URL
                  );
                },
                childCount: _filteredFoodData.length,
              ),
            ),
        ],
      ),
    );
  }
}
