// To parse this JSON data, do
//
//     final pastAppointmentModel = pastAppointmentModelFromJson(jsonString);

import 'dart:convert';

PastAppointmentModel pastAppointmentModelFromJson(String str) => PastAppointmentModel.fromJson(json.decode(str));

String pastAppointmentModelToJson(PastAppointmentModel data) => json.encode(data.toJson());

class PastAppointmentModel {
  int? success;
  List<Datum>? data;
  Pagination? pagination;

  PastAppointmentModel({
    this.success,
    this.data,
    this.pagination,
  });

  factory PastAppointmentModel.fromJson(Map<String, dynamic> json) => PastAppointmentModel(
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
  DateTime? appointmentDate;
  dynamic email;
  String? name;
  String? appointmentTime;
  String? status;
  String? remark;

  Datum({
    this.id,
    this.appointmentDate,
    this.email,
    this.name,
    this.appointmentTime,
    this.status,
    this.remark,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    appointmentDate: json["appointment_date"] == null ? null : DateTime.parse(json["appointment_date"]),
    email: json["email"],
    name: json["name"],
    appointmentTime: json["appointment_time"],
    status: json["status"],
    remark: json["remark"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "appointment_date": "${appointmentDate!.year.toString().padLeft(4, '0')}-${appointmentDate!.month.toString().padLeft(2, '0')}-${appointmentDate!.day.toString().padLeft(2, '0')}",
    "email": email,
    "name": name,
    "appointment_time": appointmentTime,
    "status": status,
    "remark": remark,
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
