class OrderItemDTO {
  final int? id;
  final int orderId;
  final int productId;
  final String productName;
  final int quantity;
  final double unitPrice;
  final double totalPrice;

  OrderItemDTO({
    this.id,
    required this.orderId,
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
  });

  factory OrderItemDTO.fromJson(Map<String, dynamic> json) {
    return OrderItemDTO(
      id: json['id'] as int?,
      orderId: json['orderId'] as int,
      productId: json['productId'] as int,
      productName: json['productName'] as String,
      quantity: json['quantity'] as int,
      unitPrice: (json['unitPrice'] as num).toDouble(),
      totalPrice: (json['totalPrice'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    if (id != null) 'id': id,
    'orderId': orderId,
    'productId': productId,
    'productName': productName,
    'quantity': quantity,
    'unitPrice': unitPrice,
    'totalPrice': totalPrice,
  };
}