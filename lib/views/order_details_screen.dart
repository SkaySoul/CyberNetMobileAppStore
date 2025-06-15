import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/order_details_controller.dart';


class OrderDetailScreen extends GetView<OrderDetailController> {
  const OrderDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final id = int.parse(Get.parameters['id']!);
    controller.loadOrder(id);
    return Scaffold(
      appBar: AppBar(title: Text('Order #$id')),
      body: Obx(() {
        if (controller.isLoading.value) return const Center(child: CircularProgressIndicator());
        final o = controller.order.value!;
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(
                'Date: ${o.createdAt != null ? DateFormat.yMMMd().add_Hm().format(o.createdAt!) : '—'}',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              const SizedBox(height: 4),
              Text(
                'Status: ${o.status}',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              const Divider(height: 32),

              if (o.shippingAddressId != null) ...[
                Text('Shipping Address ID: ${o.shippingAddressId}'),
                const Divider(height: 32),
              ],

              Text('Items:', style: Theme.of(context).textTheme.headline6),
              const SizedBox(height: 8),
              Expanded(
                child: ListView.builder(
                  itemCount: o.items.length,
                  itemBuilder: (_, i) {
                    final item = o.items[i];
                    final itemTotal = item.unitPrice * item.quantity;
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      child: ListTile(
                        title: Text(item.productName),
                        subtitle: Text(
                          '${item.quantity} × \$${item.unitPrice.toStringAsFixed(2)}',
                        ),
                        trailing: Text(
                          '\$${itemTotal.toStringAsFixed(2)}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const Divider(height: 32),


              Text('Delivery: ${o.deliveryMethod}'),
              const SizedBox(height: 4),
              Text('Payment: ${o.paymentMethod}'),
              const Divider(height: 32),


              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total:',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Text(
                    '\$${o.totalAmount.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}