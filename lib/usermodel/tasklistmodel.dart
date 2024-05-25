// To parse this JSON data, do
//
//     final taskListModel = taskListModelFromJson(jsonString);

import 'dart:convert';

TaskListModel taskListModelFromJson(String str) => TaskListModel.fromJson(json.decode(str));

String taskListModelToJson(TaskListModel data) => json.encode(data.toJson());

class TaskListModel {
  int success;
  List<Datum> data;

  TaskListModel({
    required this.success,
    required this.data,
  });

  factory TaskListModel.fromJson(Map<String, dynamic> json) => TaskListModel(
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
