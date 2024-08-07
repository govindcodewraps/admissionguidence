// // To parse this JSON data, do
// //
// //     final taskListModel = taskListModelFromJson(jsonString);
//
// import 'dart:convert';
//
// TaskListModel taskListModelFromJson(String str) => TaskListModel.fromJson(json.decode(str));
//
// String taskListModelToJson(TaskListModel data) => json.encode(data.toJson());
//
// class TaskListModel {
//   int? success;
//   List<Datum>? data;
//
//   TaskListModel({
//      this.success,
//      this.data,
//   });
//
//   factory TaskListModel.fromJson(Map<String, dynamic> json) => TaskListModel(
//     success: json["success"],
//     // data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
//     data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "success": success,
//     // "data": List<dynamic>.from(data.map((x) => x.toJson())),
//     "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
//
//   };
// }
//
// class Datum {
//   dynamic sno;
//   String? id;
//   String? taskName;
//   String? taskTime;
//   String? type;
//   int? status;
//   String? submissionTime;
//   String? date;
//
//   Datum({
//     this.sno,
//      this.id,
//      this.taskName,
//      this.taskTime,
//      this.type,
//      this.status,
//      this.submissionTime,
//      this.date,
//   });
//
//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//     sno: json["sno"],
//     id: json["id"],
//     taskName: json["task_name"],
//     taskTime: json["task_time"],
//     type: json["type"],
//     status: json["status"],
//     submissionTime: json["submission_time"],
//     date: json["date"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "sno": sno,
//     "id": id,
//     "task_name": taskName,
//     "task_time": taskTime,
//     "type": type,
//     "status": status,
//     "submission_time": submissionTime,
//     "date": date,
//   };
// }


// To parse this JSON data, do
//
//     final taskListModel = taskListModelFromJson(jsonString);

import 'dart:convert';

TaskListModel taskListModelFromJson(String str) => TaskListModel.fromJson(json.decode(str));

String taskListModelToJson(TaskListModel data) => json.encode(data.toJson());

class TaskListModel {
  int success;
  List<Datum> data;
  String totalTasks;
  int totalPages;
  int currentPage;

  TaskListModel({
    required this.success,
    required this.data,
    required this.totalTasks,
    required this.totalPages,
    required this.currentPage,
  });

  factory TaskListModel.fromJson(Map<String, dynamic> json) => TaskListModel(
    success: json["success"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    totalTasks: json["total_tasks"],
    totalPages: json["total_pages"],
    currentPage: json["current_page"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "total_tasks": totalTasks,
    "total_pages": totalPages,
    "current_page": currentPage,
  };
}

class Datum {
  int sno;
  String id;
  String taskName;
  String taskTime;
  String type;
  int status;
  String submissionTime;
  DateTime date;

  Datum({
    required this.sno,
    required this.id,
    required this.taskName,
    required this.taskTime,
    required this.type,
    required this.status,
    required this.submissionTime,
    required this.date,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    sno: json["sno"],
    id: json["id"],
    taskName: json["task_name"],
    taskTime: json["task_time"],
    type: json["type"],
    status: json["status"],
    submissionTime: json["submission_time"],
    date: DateTime.parse(json["date"]),
  );

  Map<String, dynamic> toJson() => {
    "sno": sno,
    "id": id,
    "task_name": taskName,
    "task_time": taskTime,
    "type": type,
    "status": status,
    "submission_time": submissionTime,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
  };
}
