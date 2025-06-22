import 'package:get/get.dart';

import '../api_connections/api_connect.dart';
import '../models/order/order.dart';
import '../models/userdata/shipping_address.dart';

class OrderDetailController extends GetxController {
  var isLoading = true.obs;
  var order = Rxn<OrderDTO>();
  final shippingAddress = Rxn<ShippingAddressDTO>();

  OrderDetailController(int id);

  Future<void> loadOrder(int id) async {
    isLoading.value = true;
    final o = await APIConnect.getOrderById(id);
    order.value = o;
    if (o.shippingAddressId != null) {
      final addr = await APIConnect.getAddressById(o.shippingAddressId!);
      shippingAddress.value = addr;
    }

    isLoading.value = false;
  }
}