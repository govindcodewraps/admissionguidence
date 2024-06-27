// To parse this JSON data, do
//
//     final logindetailsModel = logindetailsModelFromJson(jsonString);

import 'dart:convert';

LogindetailsModel logindetailsModelFromJson(String str) => LogindetailsModel.fromJson(json.decode(str));

String logindetailsModelToJson(LogindetailsModel data) => json.encode(data.toJson());

class LogindetailsModel {
  int success;
  List<Datum> data;

  LogindetailsModel({
    required this.success,
    required this.data,
  });

  factory LogindetailsModel.fromJson(Map<String, dynamic> json) => LogindetailsModel(
    success: json["success"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  int sno;
  String userId;
  String loginTime;
  String? logoutTime;
  DateTime loginDate;

  Datum({
    required this.sno,
    required this.userId,
    required this.loginTime,
    required this.logoutTime,
    required this.loginDate,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    sno: json["sno"],
    userId: json["user_id"],
    loginTime: json["login_time"],
    logoutTime: json["logout_time"],
    loginDate: DateTime.parse(json["login_date"]),
  );

  Map<String, dynamic> toJson() => {
    "sno": sno,
    "user_id": userId,
    "login_time": loginTime,
    "logout_time": logoutTime,
    "login_date": "${loginDate.year.toString().padLeft(4, '0')}-${loginDate.month.toString().padLeft(2, '0')}-${loginDate.day.toString().padLeft(2, '0')}",
  };
}
