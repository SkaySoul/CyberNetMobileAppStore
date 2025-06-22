import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(CartController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Obx(() {
        if (ctrl.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (ctrl.items.isEmpty) {
          return const Center(
            child: Text('Your cart is empty', style: TextStyle(color: Colors.white)),
          );
        }
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: ctrl.items.length,
                itemBuilder: (_, i) {
                  final ci = ctrl.items[i];
                  return Card(
                    color: Colors.white24,
                    margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    child: ListTile(
                      title: Text(ci.name, style: const TextStyle(color: Colors.white)),
                      subtitle: Text(
                        '${ci.quantity} × \$${ci.price.toStringAsFixed(2)}',
                        style: const TextStyle(color: Colors.white70),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.redAccent),
                        onPressed: () => ctrl.removeItem(ci.productId),
                      ),
                    ),
                  );
                },
              ),
            ),
            const Divider(color: Colors.white54),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Expanded(
                    child: Text('Total:',
                        style: TextStyle(color: Colors.white, fontSize: 18)),
                  ),
                  Text('\$${ctrl.total.toStringAsFixed(2)}',
                      style: const TextStyle(color: Colors.white, fontSize: 18)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: ctrl.items.isEmpty
                      ? null
                      : () {
                    Get.toNamed('/order/address');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text('Checkout'),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}