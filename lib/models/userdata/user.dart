class UserDTO {
  final String username;
  final String email;
  final String name;
  final String surname;
  final String phone;
  final int id;

  UserDTO({
    required this.id,
    required this.username,
    required this.email,
    required this.name,
    required this.surname,
    required this.phone,
  });

  factory UserDTO.fromJson(Map<String, dynamic> json) {
    return UserDTO(
      id: json['id'] as int,
      username: json['username'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      surname: json['surname'] as String,
      phone: json['phone'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'username': username,
    'email': email,
    'name': name,
    'surname': surname,
    'phone': phone,
  };
}