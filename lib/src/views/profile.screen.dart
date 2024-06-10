import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controller/order.controller.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderAsyncValue = ref.watch(orderProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Order Details')),
      body: orderAsyncValue.when(
        data: (order) {
          if (order.orders.isEmpty) {
            return const Center(child: Text('No orders found'));
          }
          return ListView.builder(
            itemCount: order.orders.length,
            itemBuilder: (context, index) {
              final orderItem = order.orders[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Order ID: ${orderItem.id}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: orderItem.foods.length,
                        itemBuilder: (context, foodIndex) {
                          final food = orderItem.foods[foodIndex];
                          return ListTile(
                            leading: CachedNetworkImage(
                              imageUrl: food.image,
                              placeholder: (context, url) => const CircularProgressIndicator(),
                              errorWidget: (context, url, error) => const Icon(Icons.error),
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                            title: Text(food.title),
                            subtitle: Text('Quantity: ${food.quantity}'),
                            trailing: Text('\$${food.totalPrice}'),
                          );
                        },
                      ),
                      Text('Total Price: \$${orderItem.totalPrice}'),
                    ],
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => const Center(child: Text('Failed to load orders')),
      ),
    );
  }
}
