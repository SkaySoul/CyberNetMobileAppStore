class CategoryDTO {
  final int id;
  final String name;

  CategoryDTO({required this.id, required this.name});

  factory CategoryDTO.fromJson(Map<String, dynamic> json) {
    return CategoryDTO(
      id: json['id'],
      name: json['name'],
    );

  }
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is CategoryDTO && other.id == id;

  @override
  int get hashCode => id.hashCode;
}