// lib/controllers/register_controller.dart
import 'package:get/get.dart';

import '../api_connections/api_connect.dart';

class RegisterController extends GetxController {
  var isLoading = false.obs;

  Future<bool> register(
      String login,
      String password,
      String email,
      String phone,
      String name,
      String surname,
      ) async {
    isLoading.value = true;
    try {
      final success = await APIConnect.register(
        login: login,
        password: password,
        email: email,
        phone: phone,
        name: name,
        surname: surname,

      );
      return success;
    } catch (e) {
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}