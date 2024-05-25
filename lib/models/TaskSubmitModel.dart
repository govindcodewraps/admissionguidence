// To parse this JSON data, do
//
//     final taskSubmitModel = taskSubmitModelFromJson(jsonString);

import 'dart:convert';

TaskSubmitModel taskSubmitModelFromJson(String str) => TaskSubmitModel.fromJson(json.decode(str));

String taskSubmitModelToJson(TaskSubmitModel data) => json.encode(data.toJson());

class TaskSubmitModel {
  int? success;
  String? msg;

  TaskSubmitModel({
    this.success,
    this.msg,
  });

  factory TaskSubmitModel.fromJson(Map<String, dynamic> json) => TaskSubmitModel(
    success: json["success"],
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "msg": msg,
  };
}
