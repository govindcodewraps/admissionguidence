// To parse this JSON data, do
//
//     final todayBalanceModel = todayBalanceModelFromJson(jsonString);

import 'dart:convert';

TodayBalanceModel todayBalanceModelFromJson(String str) => TodayBalanceModel.fromJson(json.decode(str));

String todayBalanceModelToJson(TodayBalanceModel data) => json.encode(data.toJson());

class TodayBalanceModel {
  int? success;
  int? data;
  String? message;

  TodayBalanceModel({
    this.success,
    this.data,
    this.message,
  });

  factory TodayBalanceModel.fromJson(Map<String, dynamic> json) => TodayBalanceModel(
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
