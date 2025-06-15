import 'dart:convert';

import 'package:get/get.dart';
import '../api_connections/api_connect.dart';

class LoginController{
  var isLoading = false.obs;

  Future<bool> login(String login, String password) async {
    isLoading.value = true;
    final credentials = base64Encode(utf8.encode('$login:$password'));
    try {
      bool ok = await APIConnect.login(login: login, password: password,);
      if (ok) {
        APIConnect.basicAuthHeader = 'Basic $credentials';
      }
      return ok;
    } finally {
      isLoading.value = false;
    }
  }

}