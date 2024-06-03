/*
// To parse this JSON data, do
//
//     final reminderListModel = reminderListModelFromJson(jsonString);

import 'dart:convert';

ReminderListModel reminderListModelFromJson(String str) => ReminderListModel.fromJson(json.decode(str));

String reminderListModelToJson(ReminderListModel data) => json.encode(data.toJson());

class ReminderListModel {
  int? success;
  List<Datum>? data;
  Pagination? pagination;

  ReminderListModel({
    this.success,
    this.data,
    this.pagination,
  });

  factory ReminderListModel.fromJson(Map<String, dynamic> json) => ReminderListModel(
    success: json["success"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "pagination": pagination?.toJson(),
  };
}

class Datum {
  String? id;
  DateTime? date;
  String? remark;
  String? status;
  String? time;
  String? reminderType;

  Datum({
    this.id,
    this.date,
    this.remark,
    this.status,
    this.time,
    this.reminderType,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    remark: json["remark"],
    status: json["status"],
    time: json["time"],
    reminderType: json["reminder_type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "remark": remark,
    "status": status,
    "time": time,
    "reminder_type": reminderType,
  };
}

class Pagination {
  int? totalPages;
  int? currentPage;
  int? nextPage;
  int? prevPage;

  Pagination({
    this.totalPages,
    this.currentPage,
    this.nextPage,
    this.prevPage,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    totalPages: json["totalPages"],
    currentPage: json["currentPage"],
    nextPage: json["nextPage"],
    prevPage: json["prevPage"],
  );

  Map<String, dynamic> toJson() => {
    "totalPages": totalPages,
    "currentPage": currentPage,
    "nextPage": nextPage,
    "prevPage": prevPage,
  };
}
*/





/*

// To parse this JSON data, do
//
//     final reminderListModel = reminderListModelFromJson(jsonString);

import 'dart:convert';

ReminderListModel reminderListModelFromJson(String str) => ReminderListModel.fromJson(json.decode(str));

String reminderListModelToJson(ReminderListModel data) => json.encode(data.toJson());

class ReminderListModel {
  int success;
  List<Datum> data;
  Pagination pagination;

  ReminderListModel({
    required this.success,
    required this.data,
    required this.pagination,
  });

  factory ReminderListModel.fromJson(Map<String, dynamic> json) => ReminderListModel(
    success: json["success"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    pagination: Pagination.fromJson(json["pagination"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "pagination": pagination.toJson(),
  };
}

class Datum {
  String id;
  DateTime date;
  String remark;
  String status;
  String time;
  String reminderType;

  Datum({
    required this.id,
    required this.date,
    required this.remark,
    required this.status,
    required this.time,
    required this.reminderType,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    date: DateTime.parse(json["date"]),
    remark: json["remark"],
    status: json["status"],
    time: json["time"],
    reminderType: json["reminder_type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "remark": remark,
    "status": status,
    "time": time,
    "reminder_type": reminderType,
  };
}

class Pagination {
  int totalPages;
  int currentPage;
  int nextPage;
  int prevPage;

  Pagination({
    required this.totalPages,
    required this.currentPage,
    required this.nextPage,
    required this.prevPage,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    totalPages: json["totalPages"],
    currentPage: json["currentPage"],
    nextPage: json["nextPage"],
    prevPage: json["prevPage"],
  );

  Map<String, dynamic> toJson() => {
    "totalPages": totalPages,
    "currentPage": currentPage,
    "nextPage": nextPage,
    "prevPage": prevPage,
  };
}
*/





// To parse this JSON data, do
//
//     final reminderListModel = reminderListModelFromJson(jsonString);

import 'dart:convert';

ReminderListModel reminderListModelFromJson(String str) => ReminderListModel.fromJson(json.decode(str));

String reminderListModelToJson(ReminderListModel data) => json.encode(data.toJson());

class ReminderListModel {
  int success;
  List<Datum> data;
  Pagination pagination;

  ReminderListModel({
    required this.success,
    required this.data,
    required this.pagination,
  });

  factory ReminderListModel.fromJson(Map<String, dynamic> json) => ReminderListModel(
    success: json["success"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    pagination: Pagination.fromJson(json["pagination"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "pagination": pagination.toJson(),
  };
}

class Datum {
  String id;
  String date;
  String remark;
  String status;
  String time;
  String reminderType;

  Datum({
    required this.id,
    required this.date,
    required this.remark,
    required this.status,
    required this.time,
    required this.reminderType,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    date: json["date"],
    remark: json["remark"],
    status: json["status"],
    time: json["time"],
    reminderType: json["reminder_type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "date": date,
    "remark": remark,
    "status": status,
    "time": time,
    "reminder_type": reminderType,
  };
}

class Pagination {
  int totalPages;
  int currentPage;
  int nextPage;
  int prevPage;

  Pagination({
    required this.totalPages,
    required this.currentPage,
    required this.nextPage,
    required this.prevPage,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    totalPages: json["totalPages"],
    currentPage: json["currentPage"],
    nextPage: json["nextPage"],
    prevPage: json["prevPage"],
  );

  Map<String, dynamic> toJson() => {
    "totalPages": totalPages,
    "currentPage": currentPage,
    "nextPage": nextPage,
    "prevPage": prevPage,
  };
}
