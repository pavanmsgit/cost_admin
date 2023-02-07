///NEW FILE
///
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

User userProfileFromJson(str) => User.fromJson((str));

String userProfileToJson(User data) => json.encode(data.toJson());

List<User> usersFromJson(str) =>
    List<User>.from((str).map((x) => User.fromJson(x.data())));

String usersToJson(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  User({
    required this.name,
    required this.phone,
    required this.email,
    required this.profileImage,
    required this.password,
    required this.createdAt,
    required this.status,
  });

  ///GO HOME RENTAL
  String name;
  String phone;
  String email;
  String profileImage;
  String password;
  Timestamp createdAt;
  bool status;



  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        phone: json["phone"],
        email: json["email"],
        profileImage: json["profile_image"],
        password: json["password"],
        createdAt: json["created_at"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "phone": phone,
        "email": email,
        "profile_image": profileImage,
        "password": password,
        "created_at": createdAt,
        "status": status,
      };
}
