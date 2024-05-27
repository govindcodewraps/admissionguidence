// To parse this JSON data, do
//
//     final todaytaskListModel = todaytaskListModelFromJson(jsonString);

import 'dart:convert';

TodaytaskListModel todaytaskListModelFromJson(String str) => TodaytaskListModel.fromJson(json.decode(str));

String todaytaskListModelToJson(TodaytaskListModel data) => json.encode(data.toJson());

class TodaytaskListModel {
  int success;
  List<Datum> data;

  TodaytaskListModel({
    required this.success,
    required this.data,
  });

  factory TodaytaskListModel.fromJson(Map<String, dynamic> json) => TodaytaskListModel(
    success: json["success"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String id;
  String taskName;
  String taskTime;
  String type;

  Datum({
    required this.id,
    required this.taskName,
    required this.taskTime,
    required this.type,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    taskName: json["task_name"],
    taskTime: json["task_time"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "task_name": taskName,
    "task_time": taskTime,
    "type": type,
  };
}
