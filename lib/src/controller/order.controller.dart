import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/order.model.dart';
import '../services/fetchOrder.service.dart';

final orderProvider = FutureProvider<Order>((ref) async {
  return fetchOrder();
});
