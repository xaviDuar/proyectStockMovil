/// Usuario del JSON de acceso (`assets/users.json`).
class UserModel {
  const UserModel({
    required this.id,
    required this.username,
    required this.password,
    required this.name,
    required this.local,
  });

  final int id;
  final String username;
  final String password;
  final String name;
  final String local;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      username: json['username'] as String,
      password: json['password'] as String,
      name: json['name'] as String,
      local: json['local'] as String,
    );
  }
}
