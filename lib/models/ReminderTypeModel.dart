// To parse this JSON data, do
//
//     final reminderTypeModel = reminderTypeModelFromJson(jsonString);

import 'dart:convert';

ReminderTypeModel reminderTypeModelFromJson(String str) => ReminderTypeModel.fromJson(json.decode(str));

String reminderTypeModelToJson(ReminderTypeModel data) => json.encode(data.toJson());

class ReminderTypeModel {
  int? success;
  List<Datum>? data;

  ReminderTypeModel({
    this.success,
    this.data,
  });

  factory ReminderTypeModel.fromJson(Map<String, dynamic> json) => ReminderTypeModel(
    success: json["success"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  String? id;
  String? type;
  String? status;

  Datum({
    this.id,
    this.type,
    this.status,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    type: json["type"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "status": status,
  };
}
