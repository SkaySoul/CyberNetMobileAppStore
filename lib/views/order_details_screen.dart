import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/order_details_controller.dart';

class OrderDetailScreen extends GetView<OrderDetailController> {
  const OrderDetailScreen({super.key, required int id});

  @override
  Widget build(BuildContext context) {
    final id = int.parse(Get.parameters['id']!);
    final ctrl = Get.put(OrderDetailController(id));
    ctrl.loadOrder(id);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Order #$id'),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      body: Obx(() {
        if (ctrl.isLoading.value) {
          return const Center(child: CircularProgressIndicator(color: Colors.white));
        }
        final o = ctrl.order.value!;

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Date: ${o.createdAt != null ? DateFormat.yMMMd().add_Hm().format(o.createdAt!) : '—'}',
                style: const TextStyle(color: Colors.white70, fontSize: 16),
              ),
              const SizedBox(height: 4),
              Text(
                'Status: ${o.status}',
                style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const Divider(color: Colors.white54, height: 32),


              if (ctrl.shippingAddress.value != null) ...[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.location_on, color: Colors.white70),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '${ctrl.shippingAddress.value!.addressLine1}, '
                            '${ctrl.shippingAddress.value!.city}, '
                            '${ctrl.shippingAddress.value!.country}',
                        style: const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ],
                ),
                const Divider(color: Colors.white54, height: 32),
              ],


              const Text('Items:', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Expanded(
                child: ListView.builder(
                  itemCount: o.items.length,
                  itemBuilder: (_, i) {
                    final item = o.items[i];
                    final itemTotal = item.unitPrice * item.quantity;
                    return Card(
                      color: Colors.white24,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        title: Text(item.productName, style: const TextStyle(color: Colors.white)),
                        subtitle: Text(
                          '${item.quantity} × \$${item.unitPrice.toStringAsFixed(2)}',
                          style: const TextStyle(color: Colors.white70),
                        ),
                        trailing: Text(
                          '\$${itemTotal.toStringAsFixed(2)}',
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const Divider(color: Colors.white54, height: 32),

              Row(
                children: [
                  const Icon(Icons.delivery_dining, color: Colors.white70),
                  const SizedBox(width: 8),
                  Text('Delivery: ${o.deliveryMethod}', style: const TextStyle(color: Colors.white, fontSize: 16)),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.payment, color: Colors.white70),
                  const SizedBox(width: 8),
                  Text('Payment: ${o.paymentMethod}', style: const TextStyle(color: Colors.white, fontSize: 16)),
                ],
              ),
              const Divider(color: Colors.white54, height: 32),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total:', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                  Text('\$${o.totalAmount.toStringAsFixed(2)}',
                      style: const TextStyle(color: Colors.greenAccent, fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}