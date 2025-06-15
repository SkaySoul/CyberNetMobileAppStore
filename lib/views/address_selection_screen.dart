import 'package:cyber_net_application/models/userdata/shipping_address.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/order_flow_controller.dart';

class AddressSelectionScreen extends StatelessWidget {
  final OrderFlowController c = Get.put(OrderFlowController());
  AddressSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,                                             // ✂— style changes here
      appBar: AppBar(
        title: const Text('Select Address'),
        backgroundColor: Colors.black,                                           // ✂— style changes here
      ),
      body: Obx(() {
        if (c.isLoading.value) return const Center(child: CircularProgressIndicator());
        return ListView(
          children: c.addresses.map((a) => RadioListTile<ShippingAddressDTO>(
            activeColor: Colors.green,                                           // ✂— style changes here
            title: Text(
              "${a.addressLine1}, ${a.city}",
              style: const TextStyle(color: Colors.white),
            ),
            value: a,
            groupValue: c.selectedAddress.value,
            onChanged: c.pickAddress,
          )).toList(),
        );
      }),
      bottomNavigationBar: Obx(() =>Padding(
        padding: const EdgeInsets.all(8),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,                                        // ✂— style changes here
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
          onPressed: c.selectedAddress.value == null
              ? null
              : () => Get.toNamed('/order/delivery'),
          child: const Text('Next'),
        ),
      ),
    )
    );
  }
}