// To parse this JSON data, do
//
//     final notificationCountModel = notificationCountModelFromJson(jsonString);

import 'dart:convert';

NotificationCountModel notificationCountModelFromJson(String str) => NotificationCountModel.fromJson(json.decode(str));

String notificationCountModelToJson(NotificationCountModel data) => json.encode(data.toJson());

class NotificationCountModel {
  int? success;
  int? data;

  NotificationCountModel({
    this.success,
    this.data,
  });

  factory NotificationCountModel.fromJson(Map<String, dynamic> json) => NotificationCountModel(
    success: json["success"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data,
  };
}
