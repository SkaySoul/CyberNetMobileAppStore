// lib/controllers/menu_controller.dart

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../api_connections/api_connect.dart';
import '../models/userdata/user.dart';

class MenuController extends GetxController {

  final RxString username = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _loadUsername();
  }

  Future<void> _loadUsername() async {
    try {
      final UserDTO me = await APIConnect.getUserData();
      username.value = me.username;
    } catch (err) {
      username.value = 'Guest';
      debugPrint('Error loading username: $err');
    }
  }
}