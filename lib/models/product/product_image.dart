// lib/models/product_image_model.dart
class ProductImageDTO {
  final int? id;
  final int? productId;
  final String? url;
  final bool? previewImage;

  ProductImageDTO({
    this.id,
    this.productId,
    this.url,
    this.previewImage,
  });

  factory ProductImageDTO.fromJson(Map<String, dynamic> json) {
    return ProductImageDTO(
      id: json['id'] != null ? (json['id'] as num).toInt() : null,
      productId: json['productId'] != null ? (json['productId'] as num).toInt() : null,
      url: json['url'] as String?,
      previewImage: json['previewImage'] as bool?,
    );
  }

  Map<String, dynamic> toJson() => {
    if (id != null) 'id': id,
    if (productId != null) 'productId': productId,
    if (url != null) 'url': url,
    if (previewImage != null) 'previewImage': previewImage,
  };
}