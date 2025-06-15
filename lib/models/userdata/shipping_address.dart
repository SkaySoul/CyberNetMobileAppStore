// lib/models/shipping_address_dto.dart

class ShippingAddressDTO {
  final int? id;
  final int? userId;
  final String? country;
  final String? city;
  final String? addressLine1;
  final String? addressLine2;
  final String? postalCode;

  ShippingAddressDTO({
    this.id,
    required this.userId,
    required this.country,
    required this.city,
    required this.addressLine1,
    required this.addressLine2,
    required this.postalCode,
  });

  factory ShippingAddressDTO.fromJson(Map<String, dynamic> json) {
    return ShippingAddressDTO(
      id: json['id'] as int?,
      userId: json['userId'] as int?,
      country: json['country'] as String?,
      city: json['city'] as String?,
      addressLine1: json['addressLine1'] as String?,
      addressLine2: json['addressLine2'] as String?,
      postalCode: json['postalCode'] as String?,
    );
  }

  Map<String?, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'country': country,
      'city': city,
      'addressLine1': addressLine1,
      'addressLine2': addressLine2,
      'postalCode': postalCode,
    };
  }
}