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
  Name? name;
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
    name: nameValues.map[json["name"]]!,
    appointmentTime: json["appointment_time"],
    status: json["status"],
    remark: json["remark"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "appointment_date": "${appointmentDate!.year.toString().padLeft(4, '0')}-${appointmentDate!.month.toString().padLeft(2, '0')}-${appointmentDate!.day.toString().padLeft(2, '0')}",
    "email": email,
    "name": nameValues.reverse[name],
    "appointment_time": appointmentTime,
    "status": status,
    "remark": remark,
  };
}

enum Name {
  GOVIND_KUMAR
}

final nameValues = EnumValues({
  "Govind kumar": Name.GOVIND_KUMAR
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
