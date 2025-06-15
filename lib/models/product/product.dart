// lib/models/product_model.dart
import 'dart:convert';
import 'dart:typed_data';
import 'package:cyber_net_application/models/product/product_image.dart';

class ProductDTO {
  final int id;
  final String name;
  final String description;        // Добавлено поле description
  final double price;
  final int categoryId;
  final int subcategoryId;
  final int manufacturerId;
  final ProductImageDTO? mainImage;

  ProductDTO({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.categoryId,
    required this.subcategoryId,
    required this.manufacturerId,
    this.mainImage,
  });

  factory ProductDTO.fromJson(Map<String, dynamic> json) {
    return ProductDTO(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      description: json['description'] as String? ?? '',
      price: (json['price'] as num).toDouble(),
      categoryId: (json['categoryId'] as num).toInt(),
      subcategoryId: (json['subcategoryId'] as num).toInt(),
      manufacturerId: (json['manufacturerId'] as num).toInt(),
      mainImage: json['mainImage'] != null
          ? ProductImageDTO.fromJson(json['mainImage'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'price': price,
    'categoryId': categoryId,
    'subcategoryId': subcategoryId,
    'manufacturerId': manufacturerId,
    if (mainImage != null) 'mainImage': mainImage!.toJson(),
  };
}