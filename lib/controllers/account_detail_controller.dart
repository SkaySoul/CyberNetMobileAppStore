import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../api_connections/api_connect.dart';
import '../models/userdata/shipping_address.dart';
import '../models/userdata/user.dart';

class AccountController extends GetxController {

  final isLoading = true.obs;
  final user = Rxn<UserDTO>();


  final isAddrLoading = false.obs;
  final addresses = <ShippingAddressDTO>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadUser();
    _loadAddresses();
  }

  Future<void> _loadUser() async {
    try {
      isLoading.value = true;
      user.value = await APIConnect.getUserData();
    } catch (e) {
      debugPrint('Error loading user: $e');
      Get.snackbar('Error', 'Cannot load user data');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _loadAddresses() async {
    try {
      isAddrLoading.value = true;
      final list = await APIConnect.getAddresses();
      addresses.assignAll(list);
    } catch (e) {
      debugPrint('Error loading addresses: $e');
      Get.snackbar('Error', 'Cannot load addresses');
    } finally {
      isAddrLoading.value = false;
    }
  }

  Future<void> deleteAddress(int id) async {
    try {
      await APIConnect.deleteAddress(id);
      addresses.removeWhere((a) => a.id == id);
    } catch (e) {
      debugPrint('Error deleting address: $e');
      Get.snackbar('Error', 'Cannot delete address');
    }
  }

  Future<void> addAddress(ShippingAddressDTO dto) async {
    try {
      final created = await APIConnect.addAddress(dto);
      addresses.add(created);
    } catch (e) {
      debugPrint('Error creating address: $e');
      Get.snackbar('Error', 'Cannot add address');
    }
  }
}