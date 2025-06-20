import 'package:cyber_net_application/api_connections/api_connect.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/order.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,                                             // ✂— style changes here
      appBar: AppBar(
        title: const Text('Orders History'),
        backgroundColor: Colors.black,                                           // ✂— style changes here
      ),
      body: FutureBuilder<List<OrderDTO>>(
        future: APIConnect.fetchOrders(),
        builder: (ctx, snap) {
          if (!snap.hasData) return const Center(child: CircularProgressIndicator());
          final orders = snap.data!;
          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (_, i) {
              final o = orders[i];
              return Card(
                color: Colors.white24,                                             // ✂— style changes here
                margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: ListTile(
                  title: Text('Order #${o.id}', style: const TextStyle(color: Colors.white)),
                  subtitle: Text('${o.createdAt} — ${o.status}',
                      style: const TextStyle(color: Colors.white70)),
                  onTap: () => Get.toNamed('/orders/${o.id}', arguments: o),
                ),
              );
            },
          );
        },
      ),
    );
  }
}