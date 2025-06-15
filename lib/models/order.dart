import 'order_item.dart';

class OrderDTO {
  final int? id;
  final int userId;
  final DateTime? createdAt;
  final String status;
  final int? shippingAddressId;
  final List<OrderItemDTO> items;
  final String deliveryMethod;
  final double totalAmount;
  final String paymentMethod;

  OrderDTO({
    this.id,
    required this.userId,
    this.createdAt,
    required this.status,
    required this.shippingAddressId,
    required this.items,
    required this.deliveryMethod,
    required this.totalAmount,
    required this.paymentMethod,
  });

  factory OrderDTO.fromJson(Map<String, dynamic> json) {
    return OrderDTO(
      id: json['id'] as int?,
      userId: json['userId'] as int,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      status: json['status'] as String,
      shippingAddressId: json['shippingAddressId'] as int?,
      items: (json['items'] as List<dynamic>)
          .map((e) => OrderItemDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      deliveryMethod: json['deliveryMethod'] as String,
      totalAmount: (json['totalAmount'] as num).toDouble(),
      paymentMethod: json['paymentMethod'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    if (id != null) 'id': id,
    if (createdAt != null) 'createdAt': createdAt!.toIso8601String(),
    'status': status,
    'shippingAddressId': shippingAddressId,
    'items': items.map((e) => e.toJson()).toList(),
    'deliveryMethod': deliveryMethod,
    'totalAmount': totalAmount,
    'paymentMethod': paymentMethod,
  };
}