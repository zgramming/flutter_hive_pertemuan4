import 'dart:convert';

List<Users> usersFromJson(String str) =>
    List<Users>.from(json.decode(str).map((x) => Users.fromMap(x)));

String usersToJson(List<Users> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Users {
  int id;
  String username;
  String email;
  String password;
  String avatar;

  Users({
    this.id,
    this.username,
    this.email,
    this.password,
    this.avatar,
  });

  factory Users.fromMap(Map<String, dynamic> json) => Users(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        password: json["password"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "username": username,
        "email": email,
        "password": password,
        "avatar": avatar,
      };
}
