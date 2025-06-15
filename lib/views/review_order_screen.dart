import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/order_flow_controller.dart';


class ReviewOrderScreen extends StatelessWidget {
  final OrderFlowController c = Get.find();
  ReviewOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,                                             // ✂— style changes here
      appBar: AppBar(
        title: const Text('Check Order'),
        backgroundColor: Colors.black,                                           // ✂— style changes here
      ),
      body: Obx(() {
        final items = c.cartController.items;
        final total = items.fold<double>(
          0, (sum, i) => sum + i.unitPrice * i.quantity,
        );
        return Column(
          children: [
            Expanded(
              child: ListView(
                children: items.map((i) => Card(
                  color: Colors.white24,                                           // ✂— style changes here
                  margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  child: ListTile(
                    title: Text(i.productName, style: const TextStyle(color: Colors.white)),
                    subtitle: Text(
                      '${i.quantity} × ${i.unitPrice}',
                      style: const TextStyle(color: Colors.white70),
                    ),
                    trailing: Text(
                      '${i.quantity * i.unitPrice}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                )).toList(),
              ),
            ),
            ListTile(
              title: const Text('Shipment', style: TextStyle(color: Colors.white70)),
              trailing: Text(c.selectedDelivery.value, style: const TextStyle(color: Colors.white)),
            ),
            ListTile(
              title: const Text('Payment', style: TextStyle(color: Colors.white70)),
              trailing: Text(c.selectedPayment.value, style: const TextStyle(color: Colors.white)),
            ),
            ListTile(
              title: const Text('Total', style: TextStyle(color: Colors.white70)),
              trailing: Text('\$${total.toStringAsFixed(2)}', style: const TextStyle(color: Colors.white)),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: c.submitOrder,
                child: const Text('Submit'),
              ),
            ),
          ],
        );
      }),
    );
  }
}