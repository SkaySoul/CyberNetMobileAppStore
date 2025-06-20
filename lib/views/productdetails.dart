// lib/views/product_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../api_connections/api_connect.dart';
import '../controllers/product_details_controller.dart';
import '../models/product/fullproduct.dart';

class ProductDetailScreen extends StatelessWidget {
  final int productId;

  const ProductDetailScreen({Key? key, required this.productId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(ProductDetailController(productId));

    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          final name = ctrl.fullProduct.value?.name;
          return Text(name ?? 'Loading...',
          style: const TextStyle(
              color: Colors.grey,
              fontSize: 20,
              fontWeight: FontWeight.bold),
          );
        }),

        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Obx(() {
        if (ctrl.isLoading.value || ctrl.fullProduct.value == null) {
          return const Center(child: CircularProgressIndicator());
        }

        final prod = ctrl.fullProduct.value!;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 240,
                child: PageView.builder(
                  itemCount: prod.images.length,
                  itemBuilder: (context, i) {
                    final img = prod.images[i];
                    final url = '${APIConnect.hostConnect}${img.url}';
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          url,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => const Icon(
                            Icons.broken_image,
                            size: 100,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    ctrl.addToCart();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black54,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child:  const Text(
                    'Add to Cart',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              const Text(
                'Product Details',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),


              ...[
                {'Name': prod.name},
                {'Product Code': prod.productCode},
                {'Price': '\$${prod.price.toStringAsFixed(2)}'},
                {'In stock': prod.amount.toString()},
                {'Manufacturer': ctrl.manufacturerName.value},
                {'Category': ctrl.categoryName.value},
                {'Subcategory': ctrl.subcategoryName.value},
              ].map((entry) {
                final key = entry.keys.first;
                final value = entry.values.first;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          key,
                          style: const TextStyle(color: Colors.white70),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          value,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                );
              }),
              const Divider(color: Colors.white54),
              const SizedBox(height: 16),


              const Text(
                'Specifications',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),


              ..._buildSpecifications(prod),
              const SizedBox(height: 24),



            ],
          ),
        );
      }),
    );
  }

  List<Widget> _buildSpecifications(FullProductDTO prod) {
    final attrs = prod.productAttributes;
    final rows = <Widget>[];
    void addRow(String name, String value) {
      rows.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Expanded(
              child: Text(
                name,
                style: const TextStyle(color: Colors.white70),
              ),
            ),
            Expanded(
              child: Text(
                value,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ));
    }

    if (attrs.atrName1.isNotEmpty) addRow(attrs.atrName1, attrs.atr1);
    if (attrs.atrName2.isNotEmpty) addRow(attrs.atrName2, attrs.atr2);
    if (attrs.atrName3.isNotEmpty) addRow(attrs.atrName3, attrs.atr3);
    if (attrs.atrName4.isNotEmpty) addRow(attrs.atrName4, attrs.atr4);
    if (attrs.atrName5.isNotEmpty) addRow(attrs.atrName5, attrs.atr5);
    if (attrs.atrName6.isNotEmpty) addRow(attrs.atrName6, attrs.atr6);
    if (attrs.atrName7.isNotEmpty) addRow(attrs.atrName7, attrs.atr7);
    if (attrs.atrName8.isNotEmpty) addRow(attrs.atrName8, attrs.atr8);
    if (attrs.atrName9.isNotEmpty) addRow(attrs.atrName9, attrs.atr9);
    if (attrs.atrName10.isNotEmpty) addRow(attrs.atrName10, attrs.atr10);

    return rows;
  }
}