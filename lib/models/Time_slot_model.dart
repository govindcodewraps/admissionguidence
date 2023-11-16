// To parse this JSON data, do
//
//     final timeslotModel = timeslotModelFromJson(jsonString);

import 'dart:convert';

TimeslotModel timeslotModelFromJson(String str) => TimeslotModel.fromJson(json.decode(str));

String timeslotModelToJson(TimeslotModel data) => json.encode(data.toJson());

class TimeslotModel {
  int? success;
  List<Datum>? data;

  TimeslotModel({
    this.success,
    this.data,
  });

  factory TimeslotModel.fromJson(Map<String, dynamic> json) => TimeslotModel(
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
  String? slotFrom;
  String? slotTo;

  Datum({
    this.id,
    this.slotFrom,
    this.slotTo,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    slotFrom: json["slot_from"],
    slotTo: json["slot_to"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "slot_from": slotFrom,
    "slot_to": slotTo,
  };
}
