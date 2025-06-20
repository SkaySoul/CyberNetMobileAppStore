import 'package:get/get.dart';

import '../api_connections/api_connect.dart';
import '../models/product/fullproduct.dart';

class ProductDetailController extends GetxController {
  final int productId;
  var isLoading = true.obs;
  var fullProduct = Rxn<FullProductDTO>();
  var categoryName    = ''.obs;
  var subcategoryName = ''.obs;
  var manufacturerName = ''.obs;
  ProductDetailController(this.productId);



  @override
  void onInit() {
    super.onInit();
    _fetchDetail();
  }

  Future<void> _fetchDetail() async {
    try {
      isLoading.value = true;
      final dto = await APIConnect.getFullProductById(id: productId);
      final cat = await APIConnect.getCategory(id: dto.categoryId);
      final sub = await APIConnect.getSubcategory(id: dto.subcategoryId);
      final man = await APIConnect.getManufacturer(id: dto.manufacturerId);
      categoryName.value    = cat.name;
      subcategoryName.value = sub.name;
      fullProduct.value = dto;
      manufacturerName.value = man.name;
    } finally {
      isLoading.value = false;
    }
  }
  Future<void> addToCart({int quantity = 1}) async {
    try {
      await APIConnect.addToCart(productId, quantity);
      Get.snackbar('Cart', 'Added to cart',
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar('Error', e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

}