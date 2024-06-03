// class TodayTaskModel {
//   int? success;
//   List<Data>? data;
//
//   TodayTaskModel({this.success, this.data});
//
//   TodayTaskModel.fromJson(Map<String, dynamic> json) {
//     success = json['success'];
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(new Data.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['success'] = this.success;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Data {
//   String? id;
//   String? taskName;
//   String? taskTime;
//   String? type;
//
//   Data({this.id, this.taskName, this.taskTime, this.type});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     taskName = json['task_name'];
//     taskTime = json['task_time'];
//     type = json['type'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['task_name'] = this.taskName;
//     data['task_time'] = this.taskTime;
//     data['type'] = this.type;
//     return data;
//   }
// }







// To parse this JSON data, do
//
//     final todayTaskModel = todayTaskModelFromJson(jsonString);

import 'dart:convert';

TodayTaskModel todayTaskModelFromJson(String str) => TodayTaskModel.fromJson(json.decode(str));

String todayTaskModelToJson(TodayTaskModel data) => json.encode(data.toJson());

class TodayTaskModel {
  int? success;
  List<Datum>? data;

  TodayTaskModel({
    this.success,
    this.data,
  });

  factory TodayTaskModel.fromJson(Map<String, dynamic> json) => TodayTaskModel(
    success: json["success"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  int? sno;
  String? id;
  String? taskName;
  String? taskTime;
  String? type;
  String? submissionTime;
  int? status;

  Datum({
    this.sno,
    this.id,
    this.taskName,
    this.taskTime,
    this.type,
    this.submissionTime,
    this.status,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    sno: json["sno"],
    id: json["id"],
    taskName: json["task_name"],
    taskTime: json["task_time"],
    type: json["type"],
    submissionTime: json["submission_time"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "sno": sno,
    "id": id,
    "task_name": taskName,
    "task_time": taskTime,
    "type": type,
    "submission_time": submissionTime,
    "status": status,
  };
}
