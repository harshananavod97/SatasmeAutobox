// To parse this JSON data, do
//
//     final userRegister = userRegisterFromJson(jsonString);

import 'dart:convert';

UserRegister userRegisterFromJson(String str) =>
    UserRegister.fromJson(json.decode(str));

String userRegisterToJson(UserRegister data) => json.encode(data.toJson());

class UserRegister {
  String stat;
  int id;

  UserRegister({
    required this.stat,
    required this.id,
  });

  factory UserRegister.fromJson(Map<String, dynamic> json) => UserRegister(
        stat: json["stat"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "stat": stat,
        "id": id,
      };
}
