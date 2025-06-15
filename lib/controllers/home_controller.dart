import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../api_connections/api_connect.dart';
import '../models/product/product.dart';
import '../models/product/category.dart';
import '../models/product/subcategory.dart';

class HomeController extends GetxController {

  final searchTerm = ''.obs;
  var products       = <ProductDTO>[].obs;
  var categories     = <CategoryDTO>[].obs;
  var subcategories  = <SubcategoryDTO>[].obs;
  var isLoading      = false.obs;
  var selectedCategory    = Rxn<CategoryDTO>();
  var selectedSubcategory = Rxn<SubcategoryDTO>();

  @override
  void onInit() {
    super.onInit();
    fetchEverything();
  }

  List<SubcategoryDTO> get filteredSubcategories {
    final cat = selectedCategory.value;
    if (cat == null) return subcategories;
    return subcategories.where((sub) => sub.categoryId == cat.id).toList();
  }

  void setSearchTerm(String term) {
    searchTerm.value = term;
  }
  List<ProductDTO> get filteredProducts {
    final lower = searchTerm.value.toLowerCase();
    return products.where((p) {
      final byCat = selectedCategory.value == null
          || p.categoryId == selectedCategory.value!.id;
      final bySub = selectedSubcategory.value == null
          || p.subcategoryId == selectedSubcategory.value!.id;
      final byText = lower.isEmpty
          || p.name.toLowerCase().contains(lower);
      return byCat && bySub && byText;
    }).toList();
  }

  Future<void> fetchEverything() async {
    isLoading.value = true;
    try {
      final prods = await APIConnect.getAllProducts();
      final cats  = await APIConnect.getCategories();
      final subs  = await APIConnect.getSubcategories();

      products.assignAll(prods);
      categories.assignAll(cats);
      subcategories.assignAll(subs);

      selectedCategory.value = null;
      selectedSubcategory.value = null;
    } catch (e) {
      Get.snackbar('Error', 'Failed to load data');
    } finally {
      isLoading.value = false;
    }
  }



  void selectCategory(CategoryDTO? cat) {
    selectedCategory.value = cat;
    if (selectedSubcategory.value != null &&
        selectedSubcategory.value!.categoryId != cat?.id) {
      selectedSubcategory.value = null;
    }
  }

  void selectSubcategory(SubcategoryDTO? sub) {
    selectedSubcategory.value = sub;
  }
}