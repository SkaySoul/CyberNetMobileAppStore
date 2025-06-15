import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../api_connections/api_connect.dart';
import '../controllers/home_controller.dart';
import '../models/product/category.dart';
import '../models/product/subcategory.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(HomeController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Get.toNamed('/cart');
            },

          ),
          IconButton(
            icon: const Icon(Icons.menu),
            tooltip: 'Menu',
            onPressed: () => Get.toNamed('/menu'),
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search products...',
                hintStyle: const TextStyle(color: Colors.white54),
                prefixIcon: const Icon(Icons.search, color: Colors.white70),
                filled: true,
                fillColor: Colors.white10,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: c.setSearchTerm,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                // Category
                Expanded(
                  child: Obx(() => DropdownButtonFormField<CategoryDTO?>(
                    isExpanded: true,
                    dropdownColor: Colors.grey[900],
                    decoration: const InputDecoration(
                      labelText: 'Category',
                      labelStyle: TextStyle(color: Colors.white70),
                      filled: true,
                      fillColor: Colors.white10,
                      border: OutlineInputBorder(),
                    ),
                    value: c.selectedCategory.value,
                    items: [
                      const DropdownMenuItem<CategoryDTO?>(
                        value: null,
                        child: Text('All categories',
                            style: TextStyle(color: Colors.white)),
                      ),
                      ...c.categories.map((cat) => DropdownMenuItem<CategoryDTO?>(
                        value: cat,
                        child: Text(cat.name,
                            style: const TextStyle(color: Colors.white)),
                      )),
                    ],
                    onChanged: c.selectCategory,
                  )),
                ),
                const SizedBox(width: 8),
                // Subcategory
                Expanded(
                  child: Obx(() => DropdownButtonFormField<SubcategoryDTO?>(
                    isExpanded: true,
                    dropdownColor: Colors.grey[900],
                    decoration: const InputDecoration(
                      labelText: 'Subcategory',
                      labelStyle: TextStyle(color: Colors.white70),
                      filled: true,
                      fillColor: Colors.white10,
                      border: OutlineInputBorder(),
                    ),
                    value: c.selectedSubcategory.value,
                    items: [
                      const DropdownMenuItem<SubcategoryDTO?>(
                        value: null,
                        child: Text('All subcategories',
                            style: TextStyle(color: Colors.white)),
                      ),
                      ...c.filteredSubcategories.map((sub) => DropdownMenuItem<SubcategoryDTO?>(
                        value: sub,
                        child: Text(sub.name,
                            style: const TextStyle(color: Colors.white)),
                      )),
                    ],
                    onChanged: c.selectSubcategory,
                  )),
                ),
              ],
            ),
          ),

          // — product list —
          Expanded(
            child: Obx(() {
              if (c.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              final list = c.filteredProducts;
              return RefreshIndicator(
                onRefresh: c.fetchEverything,
                child: list.isEmpty
                    ? ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: const [
                    SizedBox(height: 200),
                    Center(
                        child: Text('No products found',
                            style: TextStyle(color: Colors.white))),
                  ],
                )
                    : ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(8),
                  itemCount: list.length,
                  itemBuilder: (_, i) {
                    final p = list[i];
                    final imgUrl = p.mainImage?.url;
                    return Card(
                      color: Colors.white24,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 12),
                      child: ListTile(
                        leading: imgUrl != null
                            ? CircleAvatar(
                          radius: 28,
                          backgroundImage: NetworkImage(
                            '${APIConnect.hostConnect}$imgUrl',
                          ),
                        )
                            : const CircleAvatar(
                          radius: 28,
                          backgroundColor: Colors.grey,
                          child: Icon(Icons.image_not_supported,
                              color: Colors.white),
                        ),
                        title: Text(p.name,
                            style: const TextStyle(color: Colors.white)),
                        subtitle: Text('\$${p.price.toStringAsFixed(2)}',
                            style:
                            const TextStyle(color: Colors.white70)),
                        onTap: () => Get.toNamed('/product/${p.id}'),
                      ),
                    );
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}