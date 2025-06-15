import 'package:get/get.dart';
import '../api_connections/api_connect.dart';
import '../models/cart.dart';


class CartController extends GetxController {
  var isLoading = true.obs;
  var items = <CartItemDTO>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchCart();
  }

  Future<void> fetchCart() async {
    isLoading.value = true;
    items.value = await APIConnect.getCart();
    isLoading.value = false;
  }

  Future<void> removeItem(int productId) async {
    await APIConnect.removeFromCart(productId);
    await fetchCart();
  }

  double get total => items.fold(
      0.0, (sum, ci) => sum + ci!.price * ci!.quantity);

  Future<void> checkout() async {
    await APIConnect.checkoutCart();
    Get.snackbar('Cart', 'Checkout successful');
    await fetchCart();
  }
}