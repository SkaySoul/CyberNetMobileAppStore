
import 'product_image.dart';
import 'product_attributes.dart';

class FullProductDTO {
  final int id;
  final String name;
  final String description;
  final int amount;
  final double price;
  final String serialNumber;
  final int manufacturerId;
  final int categoryId;
  final int subcategoryId;
  final List<ProductImageDTO> images;
  final ProductAttributesDTO productAttributes;

  FullProductDTO({
    required this.id,
    required this.name,
    required this.description,
    required this.amount,
    required this.price,
    required this.serialNumber,
    required this.manufacturerId,
    required this.categoryId,
    required this.subcategoryId,
    required this.images,
    required this.productAttributes,
  });

  factory FullProductDTO.fromJson(Map<String, dynamic> json) {

    final attrsJson = json['productAttributes'];
    final productAttributes = (attrsJson is Map<String, dynamic>)
        ? ProductAttributesDTO.fromJson(attrsJson)
        : ProductAttributesDTO.empty();


    final imagesJson = json['images'] as List<dynamic>? ?? <dynamic>[];
    final images = imagesJson
        .whereType<Map<String, dynamic>>()
        .map(ProductImageDTO.fromJson)
        .toList();

    return FullProductDTO(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String? ?? '',
      price: (json['price'] as num).toDouble(),
      categoryId: (json['categoryId'] as num).toInt(),
      subcategoryId: (json['subcategoryId'] as num).toInt(),
      manufacturerId: (json['manufacturerId'] as num).toInt(),
      productAttributes: productAttributes,
      images: images,
      amount: (json['amount'] as num).toInt(),
      serialNumber: json['serialNumber'] as String? ?? '',
    );
  }
}