
class ManufacturerDTO{
  final int id;
  final String name;
  final String code;

  ManufacturerDTO({required this.id, required this.name, required this.code});

  factory ManufacturerDTO.fromJson(Map<String, dynamic> json) {
    return ManufacturerDTO(
        id: json['id'],
        name: json['name'],
        code: json['code']
    );
  }
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is ManufacturerDTO && other.id == id;

  @override
  int get hashCode => id.hashCode;
}