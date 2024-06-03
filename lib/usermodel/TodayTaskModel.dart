// To parse this JSON data, do
//
//     final todayTaskModel = todayTaskModelFromJson(jsonString);

import 'dart:convert';

TodayTaskModel todayTaskModelFromJson(String str) => TodayTaskModel.fromJson(json.decode(str));

String todayTaskModelToJson(TodayTaskModel data) => json.encode(data.toJson());

class TodayTaskModel {
  int success;
  List<Datum> data;

  TodayTaskModel({
    required this.success,
    required this.data,
  });

  factory TodayTaskModel.fromJson(Map<String, dynamic> json) => TodayTaskModel(
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
  String submissionTime;
  int status;

  Datum({
    required this.id,
    required this.taskName,
    required this.taskTime,
    required this.type,
    required this.submissionTime,
    required this.status,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    taskName: json["task_name"],
    taskTime: json["task_time"],
    type: json["type"],
    submissionTime: json["submission_time"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "task_name": taskName,
    "task_time": taskTime,
    "type": type,
    "submission_time": submissionTime,
    "status": status,
  };
}
