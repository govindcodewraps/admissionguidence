// To parse this JSON data, do
//
//     final paymentListModel = paymentListModelFromJson(jsonString);

import 'dart:convert';

PaymentListModel paymentListModelFromJson(String str) => PaymentListModel.fromJson(json.decode(str));

String paymentListModelToJson(PaymentListModel data) => json.encode(data.toJson());

class PaymentListModel {
  int? success;
  List<Datum>? data;
  Pagination? pagination;

  PaymentListModel({
    this.success,
    this.data,
    this.pagination,
  });

  factory PaymentListModel.fromJson(Map<String, dynamic> json) => PaymentListModel(
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
  String? type;
  String? amount;
  String? oldBalance;
  String? newBalance;
  String? bankName;
  String? remark;
  DateTime? date;

  Datum({
    this.id,
    this.type,
    this.amount,
    this.oldBalance,
    this.newBalance,
    this.bankName,
    this.remark,
    this.date,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    type: json["type"],
    amount: json["amount"],
    oldBalance: json["old_balance"],
    newBalance: json["new_balance"],
    bankName: json["bank_name"],
    remark: json["remark"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "amount": amount,
    "old_balance": oldBalance,
    "new_balance": newBalance,
    "bank_name": bankName,
    "remark": remark,
    "date": date?.toIso8601String(),
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
