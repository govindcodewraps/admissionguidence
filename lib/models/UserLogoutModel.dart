// To parse this JSON data, do
//
//     final userLogoutModel = userLogoutModelFromJson(jsonString);

import 'dart:convert';

UserLogoutModel userLogoutModelFromJson(String str) => UserLogoutModel.fromJson(json.decode(str));

String userLogoutModelToJson(UserLogoutModel data) => json.encode(data.toJson());

class UserLogoutModel {
  int? success;
  String? message;

  UserLogoutModel({
    this.success,
    this.message,
  });

  factory UserLogoutModel.fromJson(Map<String, dynamic> json) => UserLogoutModel(
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}
