import 'order_item.dart';

class CartItemDTO {
  final int    id;
  final int    productId;
  final String name;
  final double price;
  final int    quantity;
  final String url;

  CartItemDTO({
    required this.id,
    required this.productId,
    required this.name,
    required this.price,
    required this.quantity,
    required this.url,
  });

  factory CartItemDTO.fromJson(Map<String, dynamic> json) {

    int parseInt(dynamic v, [int def = 0]) {
      if (v == null) return def;
      if (v is int) return v;
      if (v is String) return int.tryParse(v) ?? def;
      if (v is num) return v.toInt();
      return def;
    }
    
    double parseDouble(dynamic v, [double def = 0.0]) {
      if (v == null) return def;
      if (v is double) return v;
      if (v is String) return double.tryParse(v) ?? def;
      if (v is num) return v.toDouble();
      return def;
    }

    return CartItemDTO(
      id:         parseInt(json['id']),
      productId:  parseInt(json['productId']),
      name:       (json['name'] as String?) ?? '—',
      price:      parseDouble(json['price']),
      quantity:   parseInt(json['quantity'], 1),
      url:        (json['url'] as String?) ?? '',
    );
  }

  String get productName => name;
  get unitPrice => price;

}

extension CartItemDtoX on CartItemDTO {
  OrderItemDTO toOrderItemDTO() {
    return OrderItemDTO(
      productId: productId,
      productName: name,
      quantity: quantity,
      unitPrice: price,
      orderId: id,
      totalPrice: quantity * price,
    );
  }
}