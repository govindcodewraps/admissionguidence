// To parse this JSON data, do
//
//     final reminderListModel = reminderListModelFromJson(jsonString);

import 'dart:convert';

ReminderListModel reminderListModelFromJson(String str) => ReminderListModel.fromJson(json.decode(str));

String reminderListModelToJson(ReminderListModel data) => json.encode(data.toJson());

class ReminderListModel {
  int? success;
  List<Datum>? data;

  ReminderListModel({
    this.success,
    this.data,
  });

  factory ReminderListModel.fromJson(Map<String, dynamic> json) => ReminderListModel(
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
  String? date;
  String? remark;
  String? status;

  Datum({
    this.id,
    this.date,
    this.remark,
    this.status,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    date: json["date"],
    remark: json["remark"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "date": date,
    "remark": remark,
    "status": status,
  };
}
