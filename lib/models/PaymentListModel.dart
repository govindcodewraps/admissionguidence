// To parse this JSON data, do
//
//     final paymentListModel = paymentListModelFromJson(jsonString);

import 'dart:convert';

PaymentListModel paymentListModelFromJson(String str) => PaymentListModel.fromJson(json.decode(str));

String paymentListModelToJson(PaymentListModel data) => json.encode(data.toJson());

class PaymentListModel {
  int? success;
  List<Datum>? data;

  PaymentListModel({
    this.success,
    this.data,
  });

  factory PaymentListModel.fromJson(Map<String, dynamic> json) => PaymentListModel(
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
  String? amount;
  String? oldBalance;
  String? newBalance;
  String? bankName;

  Datum({
    this.id,
    this.type,
    this.amount,
    this.oldBalance,
    this.newBalance,
    this.bankName,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    type: json["type"],
    amount: json["amount"],
    oldBalance: json["old_balance"],
    newBalance: json["new_balance"],
    bankName: json["bank_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "amount": amount,
    "old_balance": oldBalance,
    "new_balance": newBalance,
    "bank_name": bankName,
  };
}
