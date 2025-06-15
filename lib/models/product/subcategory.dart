class SubcategoryDTO {
  final int id;
  final String name;
  final int categoryId;

  SubcategoryDTO({required this.id, required this.name, required this.categoryId});

  factory SubcategoryDTO.fromJson(Map<String, dynamic> json) {
    return SubcategoryDTO(
      id: json['id'],
      name: json['name'],
      categoryId: json['categoryId']
    );
  }
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is SubcategoryDTO && other.id == id;

  @override
  int get hashCode => id.hashCode;
}