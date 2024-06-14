import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../services/fetchOrder.service.dart';

class OrderHistoryScreen extends ConsumerStatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  ConsumerState<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends ConsumerState<OrderHistoryScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(orderProvider.notifier).fetchOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    final orderController = ref.watch(orderProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Order Details')),
      body: Column(
        children: [
          Expanded(
            child: orderController.order == null && orderController.isLoading
                ? const Center(child: CircularProgressIndicator())
                : orderController.isError
                    ? const Center(child: Text('Failed to load orders'))
                    : ListView.builder(
                        itemCount: orderController.order?.orders.length ??
                            0 + (orderController.isLoading ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index >=
                              (orderController.order?.orders.length ?? 0)) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }

                          final orderItem =
                              orderController.order!.orders[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Order ID: ${orderItem.id}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: orderItem.foods.length,
                                    itemBuilder: (context, foodIndex) {
                                      final food = orderItem.foods[foodIndex];
                                      return ListTile(
                                        leading: CachedNetworkImage(
                                          imageUrl: food.image,
                                          placeholder: (context, url) =>
                                              const CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                          width: 50,
                                          height: 50,
                                          fit: BoxFit.cover,
                                        ),
                                        title: Text(food.title),
                                        subtitle:
                                            Text('Quantity: ${food.quantity}'),
                                        trailing: Text('\$${food.totalPrice}'),
                                      );
                                    },
                                  ),
                                  Text(
                                      'Total Price: \$${orderItem.totalPrice}'),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
          ),
          if (orderController.hasMore &&
              !orderController.isLoading &&
              !orderController.isError)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () {
                  ref.read(orderProvider.notifier).fetchOrders(loadMore: true);
                },
                child: const Text('View More Orders'),
              ),
            ),
          if (orderController.isLoading) const CircularProgressIndicator(),
        ],
      ),
    );
  }
}
