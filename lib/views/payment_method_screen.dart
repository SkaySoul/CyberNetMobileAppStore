import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/order_flow_controller.dart';

class PaymentMethodScreen extends StatelessWidget {
  final OrderFlowController c = Get.find();
  PaymentMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,                                             // ✂— style changes here
      appBar: AppBar(
        title: const Text('Payment Type'),
        backgroundColor: Colors.black,                                           // ✂— style changes here
      ),
      body: Obx(() => ListView(
        children: c.paymentMethods.map((m) => RadioListTile<String>(
          activeColor: Colors.green,                                             // ✂— style changes here
          title: Text(m, style: const TextStyle(color: Colors.white)),
          value: m,
          groupValue: c.selectedPayment.value,
          onChanged: c.pickPayment,
        )).toList(),
      )),
      bottomNavigationBar: Obx(() =>Padding(
        padding: const EdgeInsets.all(8),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
          onPressed: c.selectedPayment.value.isEmpty
              ? null
              : () => Get.toNamed('/order/review'),
          child: const Text('Next'),
        ),
      ),
    )
    );
  }
}