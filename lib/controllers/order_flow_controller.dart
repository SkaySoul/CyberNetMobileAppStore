import 'package:cyber_net_application/api_connections/api_connect.dart';
import 'package:cyber_net_application/models/order/cart.dart';
import 'package:get/get.dart';

import '../models/order/order.dart';
import '../models/userdata/shipping_address.dart';
import 'cart_controller.dart';

class OrderFlowController extends GetxController {

  final CartController cartController = Get.find<CartController>();

  var addresses = <ShippingAddressDTO>[].obs;
  var selectedAddress = Rxn<ShippingAddressDTO>();


  final deliveryMethods = ['COURIER', 'PICKUP'].obs;
  var selectedDelivery = ''.obs;

  final paymentMethods = ['CARD', 'CASH'].obs;
  var selectedPayment = ''.obs;

  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAddresses();
  }

  Future<void> fetchAddresses() async {
    isLoading.value = true;
    addresses.value = await APIConnect.getAddresses();
    isLoading.value = false;
  }

  void pickAddress(ShippingAddressDTO? m) {
    if (m != null) {
      selectedAddress.value = m;
    }
  }
  void pickDelivery(String? m) {
    if (m != null) {
      selectedDelivery.value = m;
    }
  }
  void pickPayment(String? m) {
    if (m != null) {
      selectedPayment.value = m;
    }
  }

  Future<void> submitOrder() async {
    if (selectedAddress.value == null ||
        selectedDelivery.value.isEmpty ||
        selectedPayment.value.isEmpty) {
      Get.snackbar('Error', 'Fill all of the steps of order');
      return;
    }
    isLoading.value = true;
    final dto = OrderDTO(
      status: "CREATED",
      shippingAddressId: selectedAddress.value?.id,
      deliveryMethod: selectedDelivery.value,
      paymentMethod: selectedPayment.value,
      items: cartController.items.map((i) => i.toOrderItemDTO()).toList(),
      userId: -1,
      totalAmount: 0,
    );
    await APIConnect.createOrder(dto);
    isLoading.value = false;
    Get.offAllNamed('/orders/history');
  }
}