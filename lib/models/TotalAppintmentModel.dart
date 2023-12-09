// To parse this JSON data, do
//
//     final totleAppointmentCountModel = totleAppointmentCountModelFromJson(jsonString);

import 'dart:convert';

TotleAppointmentCountModel totleAppointmentCountModelFromJson(String str) => TotleAppointmentCountModel.fromJson(json.decode(str));

String totleAppointmentCountModelToJson(TotleAppointmentCountModel data) => json.encode(data.toJson());

class TotleAppointmentCountModel {
  int? success;
  int? data;
  String? message;

  TotleAppointmentCountModel({
    this.success,
    this.data,
    this.message,
  });

  factory TotleAppointmentCountModel.fromJson(Map<String, dynamic> json) => TotleAppointmentCountModel(
    success: json["success"],
    data: json["data"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data,
    "message": message,
  };
}
