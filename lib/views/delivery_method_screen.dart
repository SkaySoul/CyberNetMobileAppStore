import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/order_flow_controller.dart';

class DeliveryMethodScreen extends StatelessWidget {
  final OrderFlowController c = Get.find();
  DeliveryMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,                                             // ✂— style changes here
      appBar: AppBar(
        title: const Text('Delivery Method'),
        backgroundColor: Colors.black,                                           // ✂— style changes here
      ),
      body: Obx(() => ListView(
        children: c.deliveryMethods.map((m) => RadioListTile<String>(
          activeColor: Colors.green,                                             // ✂— style changes here
          title: Text(m, style: const TextStyle(color: Colors.white)),
          value: m,
          groupValue: c.selectedDelivery.value,
          onChanged: c.pickDelivery,
        )).toList(),
      )),
      bottomNavigationBar: Obx(() => Padding(
        padding: const EdgeInsets.all(8),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
          onPressed: c.selectedDelivery.value.isEmpty
              ? null
              : () => Get.toNamed('/order/payment'),
          child: const Text('Next'),
        ),
      ),
    )
    );
  }
}