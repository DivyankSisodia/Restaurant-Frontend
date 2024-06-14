import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/order.model.dart';

final orderProvider = ChangeNotifierProvider((ref) => OrderController());

class OrderController extends ChangeNotifier {
  Order? order;
  bool isLoading = false;
  bool isError = false;
  int currentPage = 1;
  bool hasMore = true;

  Future<void> fetchOrders({bool loadMore = false}) async {
    if (isLoading) return;

    isLoading = true;
    isError = false;

    if (loadMore) currentPage++;
    final userBox = Hive.box('user_info');
    final String userId = userBox.get('userId');
    final response = await http.get(
      Uri.parse(
        'https://restaurants-backend-gnl2.onrender.com/api/v1/order/$userId?page=$currentPage',
      ),
    );

    if (response.statusCode == 200) {
      var newOrder = Order.fromJson(json.decode(response.body));
      print('New Order: $newOrder');
      if (loadMore) {
        order?.orders.addAll(newOrder.orders);
      } else {
        order = newOrder;
      }
      hasMore = newOrder.currentPage < newOrder.totalPages;
    }
    if (response.statusCode != 200) {
      isError = true;
      AwesomeSnackbarContent(
        inMaterialBanner: false,
        color: Colors.redAccent,
        title: 'Failed to fetch Orders',
        message: response.body,
        contentType: ContentType.failure,
      );
      print('Failed to fetch orders: ${response.body}');
    } else {
      print('Orders fetched: ${order?.orders}');
    }

    isLoading = false;
    notifyListeners();
  }
}
