// To parse this JSON data, do
//
//     final notificationListModel = notificationListModelFromJson(jsonString);

import 'dart:convert';

NotificationListModel notificationListModelFromJson(String str) => NotificationListModel.fromJson(json.decode(str));

String notificationListModelToJson(NotificationListModel data) => json.encode(data.toJson());

class NotificationListModel {
  int? success;
  List<Datum>? data;

  NotificationListModel({
    this.success,
    this.data,
  });

  factory NotificationListModel.fromJson(Map<String, dynamic> json) => NotificationListModel(
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
  String? reminder;
  DateTime? reminderCreateDate;

  Datum({
    this.id,
    this.reminder,
    this.reminderCreateDate,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    reminder: json["reminder"],
    reminderCreateDate: json["reminder_create_date"] == null ? null : DateTime.parse(json["reminder_create_date"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "reminder": reminder,
    "reminder_create_date": "${reminderCreateDate!.year.toString().padLeft(4, '0')}-${reminderCreateDate!.month.toString().padLeft(2, '0')}-${reminderCreateDate!.day.toString().padLeft(2, '0')}",
  };
}
