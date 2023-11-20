// To parse this JSON data, do
//
//     final appointmentsListModel = appointmentsListModelFromJson(jsonString);

import 'dart:convert';

AppointmentsListModel appointmentsListModelFromJson(String str) => AppointmentsListModel.fromJson(json.decode(str));

String appointmentsListModelToJson(AppointmentsListModel data) => json.encode(data.toJson());

class AppointmentsListModel {
  int? success;
  List<Datum>? data;

  AppointmentsListModel({
    this.success,
    this.data,
  });

  factory AppointmentsListModel.fromJson(Map<String, dynamic> json) => AppointmentsListModel(
    success: json["success"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  String? id;
  DateTime? appointmentDate;
  String? email;
  String? name;
  String? appointmentTime;
  String? status;

  Datum({
    this.id,
    this.appointmentDate,
    this.email,
    this.name,
    this.appointmentTime,
    this.status,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    appointmentDate: json["appointment_date"] == null ? null : DateTime.parse(json["appointment_date"]),
    email: json["email"],
    name: json["name"],
    appointmentTime: json["appointment_time"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "appointment_date": "${appointmentDate!.year.toString().padLeft(4, '0')}-${appointmentDate!.month.toString().padLeft(2, '0')}-${appointmentDate!.day.toString().padLeft(2, '0')}",
    "email": email,
    "name": name,
    "appointment_time": appointmentTime,
    "status": status,
  };
}
