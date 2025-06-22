import 'package:get/get.dart';

import '../api_connections/api_connect.dart';
import '../models/order/order.dart';

class OrderDetailController extends GetxController {
  var isLoading = true.obs;
  var order = Rxn<OrderDTO>();

  OrderDetailController(int id);

  void loadOrder(int id) async {
    isLoading.value = true;
    order.value = await APIConnect.getOrderById(id);
    isLoading.value = false;
  }
}