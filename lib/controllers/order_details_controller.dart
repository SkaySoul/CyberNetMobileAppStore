import 'package:get/get.dart';
import '../api_connections/api_connect.dart';
import '../models/order.dart';

class OrderDetailController extends GetxController {
  final _api = APIConnect();
  var isLoading = true.obs;
  var order = Rxn<OrderDTO>();

  void loadOrder(int id) async {
    isLoading.value = true;
    order.value = await APIConnect.getOrderById(id);
    isLoading.value = false;
  }
}