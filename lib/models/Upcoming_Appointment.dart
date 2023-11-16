// To parse this JSON data, do
//
//     final upcommingAppointmentModel = upcommingAppointmentModelFromJson(jsonString);

import 'dart:convert';

UpcommingAppointmentModel upcommingAppointmentModelFromJson(String str) => UpcommingAppointmentModel.fromJson(json.decode(str));

String upcommingAppointmentModelToJson(UpcommingAppointmentModel data) => json.encode(data.toJson());

class UpcommingAppointmentModel {
  int? success;
  List<Datum>? data;

  UpcommingAppointmentModel({
    this.success,
    this.data,
  });

  factory UpcommingAppointmentModel.fromJson(Map<String, dynamic> json) => UpcommingAppointmentModel(
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

  Datum({
    this.id,
    this.appointmentDate,
    this.email,
    this.name,
    this.appointmentTime,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    appointmentDate: json["appointment_date"] == null ? null : DateTime.parse(json["appointment_date"]),
    email: json["email"],
    name: json["name"],
    appointmentTime: json["appointment_time"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "appointment_date": "${appointmentDate!.year.toString().padLeft(4, '0')}-${appointmentDate!.month.toString().padLeft(2, '0')}-${appointmentDate!.day.toString().padLeft(2, '0')}",
    "email": email,
    "name": name,
    "appointment_time": appointmentTime,
  };
}
