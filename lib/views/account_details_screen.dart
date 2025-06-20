// lib/views/account_details_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/account_detail_controller.dart';
import '../models/userdata/shipping_address.dart';

class AccountDetailsScreen extends StatelessWidget {
  const AccountDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(AccountController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Details'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Obx(() {
        if (ctrl.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        final u = ctrl.user.value;
        if (u == null) {
          return const Center(
            child: Text('No user data', style: TextStyle(color: Colors.white)),
          );
        }
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // ---------- User info ----------
            _buildInfoTile('Username', u.username),
            _buildInfoTile('Name', u.name),
            _buildInfoTile('Surname', u.surname),
            _buildInfoTile('Email', u.email),
            _buildInfoTile('Phone', u.phone),
            const SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Shipping Addresses',
                    style: TextStyle(color: Colors.white, fontSize: 18)),
                ElevatedButton.icon(
                  icon: const Icon(Icons.add),
                  label: const Text('Add'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: () => _showAddAddressDialog(context, ctrl),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Obx(() {
              if (ctrl.isAddrLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (ctrl.addresses.isEmpty) {
                return const Text('No addresses',
                    style: TextStyle(color: Colors.white70));
              }
              return Column(
                children: ctrl.addresses.map((addr) {
                  return Card(
                    color: Colors.white24,
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      title: Text('${addr.addressLine1}, ${addr.city}',
                          style: const TextStyle(color: Colors.white)),
                      subtitle: Text('${addr.postalCode}, ${addr.country}',
                          style: const TextStyle(color: Colors.white70)),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.redAccent),
                        onPressed: () => ctrl.deleteAddress(addr.id!),
                      ),
                    ),
                  );
                }).toList(),
              );
            }),
          ],
        );
      }),
    );
  }

  Widget _buildInfoTile(String label, String? value) {
    return Card(
      color: Colors.white24,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        title: Text(label, style: const TextStyle(color: Colors.white70)),
        subtitle: Text(value ?? '-', style: const TextStyle(color: Colors.white)),
      ),
    );
  }

  void _showAddAddressDialog(
      BuildContext context, AccountController ctrl) {
    final addressLine1 = TextEditingController();
    final addressLine2 = TextEditingController();
    final city = TextEditingController();
    final postal = TextEditingController();
    final country = TextEditingController();

    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.grey[900],
        title: const Text('New Address', style: TextStyle(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _field('Address line 1', addressLine1),
            _field('Address line 2', addressLine2),
            _field('City', city),
            _field('Postal Code', postal),
            _field('Country', country),
          ],
        ),
        actions: [
          TextButton(
            child: const Text('Cancel', style: TextStyle(color: Colors.white70)),
            onPressed: () => Get.back(),
          ),
          ElevatedButton(
            child: const Text('Save'),
            onPressed: () {
              final dto = ShippingAddressDTO(
                id: null,
                userId: ctrl.user.value?.id,
                addressLine1: addressLine1.text,
                addressLine2: addressLine2.text,
                city: city.text,
                postalCode: postal.text,
                country: country.text,
              );
              ctrl.addAddress(dto);
              Get.back();
            },
          ),
        ],
      ),
    );
  }

  Widget _field(String label, TextEditingController ctrl) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: TextField(
        controller: ctrl,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white70),
          filled: true,
          fillColor: Colors.white10,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}