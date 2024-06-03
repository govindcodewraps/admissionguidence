// To parse this JSON data, do
//
//     final noTaskModel = noTaskModelFromJson(jsonString);

import 'dart:convert';

NoTaskModel noTaskModelFromJson(String str) => NoTaskModel.fromJson(json.decode(str));

String noTaskModelToJson(NoTaskModel data) => json.encode(data.toJson());

class NoTaskModel {
  int? success;
  String? message;

  NoTaskModel({
    this.success,
    this.message,
  });

  factory NoTaskModel.fromJson(Map<String, dynamic> json) => NoTaskModel(
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}
