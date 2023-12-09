// To parse this JSON data, do
//
//     final accountNameNumberModel = accountNameNumberModelFromJson(jsonString);

import 'dart:convert';

AccountNameNumberModel accountNameNumberModelFromJson(String str) => AccountNameNumberModel.fromJson(json.decode(str));

String accountNameNumberModelToJson(AccountNameNumberModel data) => json.encode(data.toJson());

class AccountNameNumberModel {
  int? success;
  List<Datum>? data;

  AccountNameNumberModel({
    this.success,
    this.data,
  });

  factory AccountNameNumberModel.fromJson(Map<String, dynamic> json) => AccountNameNumberModel(
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
  String? type;
  String? status;

  Datum({
    this.id,
    this.type,
    this.status,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    type: json["type"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "status": status,
  };
}
