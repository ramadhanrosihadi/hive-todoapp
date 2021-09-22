import 'dart:convert';

class User {
  final int id;
  final String email;
  final String first_name;
  final String last_name;
  final String avatar;
  User({
    this.id = 0,
    this.email = '',
    this.first_name = '',
    this.last_name = '',
    this.avatar = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'first_name': first_name,
      'last_name': last_name,
      'avatar': avatar,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id']?.toInt() ?? 0,
      email: map['email'] ?? '',
      first_name: map['first_name'] ?? '',
      last_name: map['last_name'] ?? '',
      avatar: map['avatar'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  static List<User> fromListDynamic(List<dynamic>? datas) {
    if (datas == null) return [];
    return datas.map<User>((e) => User.fromMap(e)).toList();
  }
}
