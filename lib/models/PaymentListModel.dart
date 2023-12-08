// // To parse this JSON data, do
// //
// //     final paymentListModel = paymentListModelFromJson(jsonString);
//
// import 'dart:convert';
//
// PaymentListModel paymentListModelFromJson(String str) => PaymentListModel.fromJson(json.decode(str));
//
// String paymentListModelToJson(PaymentListModel data) => json.encode(data.toJson());
//
// class PaymentListModel {
//   int? success;
//   List<Datum>? data;
//
//   PaymentListModel({
//     this.success,
//     this.data,
//   });
//
//   factory PaymentListModel.fromJson(Map<String, dynamic> json) => PaymentListModel(
//     success: json["success"],
//     data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "success": success,
//     "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
//   };
// }
//
// class Datum {
//   String? id;
//   String? type;
//   String? amount;
//   String? oldBalance;
//   String? newBalance;
//   String? bankName;
//
//   Datum({
//     this.id,
//     this.type,
//     this.amount,
//     this.oldBalance,
//     this.newBalance,
//     this.bankName,
//   });
//
//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//     id: json["id"],
//     type: json["type"],
//     amount: json["amount"],
//     oldBalance: json["old_balance"],
//     newBalance: json["new_balance"],
//     bankName: json["bank_name"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "type": type,
//     "amount": amount,
//     "old_balance": oldBalance,
//     "new_balance": newBalance,
//     "bank_name": bankName,
//   };
// }




// To parse this JSON data, do
//
//     final paymentListModel = paymentListModelFromJson(jsonString);






//
// import 'dart:convert';
//
// PaymentListModel paymentListModelFromJson(String str) => PaymentListModel.fromJson(json.decode(str));
//
// String paymentListModelToJson(PaymentListModel data) => json.encode(data.toJson());
//
// class PaymentListModel {
//   int? success;
//   List<Datum>? data;
//
//   PaymentListModel({
//     this.success,
//     this.data,
//   });
//
//   factory PaymentListModel.fromJson(Map<String, dynamic> json) => PaymentListModel(
//     success: json["success"],
//     data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "success": success,
//     "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
//   };
// }
//
// class Datum {
//   String? id;
//   Type? type;
//   String? amount;
//   String? oldBalance;
//   String? newBalance;
//   BankName? bankName;
//   String? remark;
//
//   Datum({
//     this.id,
//     this.type,
//     this.amount,
//     this.oldBalance,
//     this.newBalance,
//     this.bankName,
//     this.remark,
//   });
//
//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//     id: json["id"],
//     type: typeValues.map[json["type"]]!,
//     amount: json["amount"],
//     oldBalance: json["old_balance"],
//     newBalance: json["new_balance"],
//     bankName: bankNameValues.map[json["bank_name"]]!,
//     remark: json["remark"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "type": typeValues.reverse[type],
//     "amount": amount,
//     "old_balance": oldBalance,
//     "new_balance": newBalance,
//     "bank_name": bankNameValues.reverse[bankName],
//     "remark": remark,
//   };
// }
//
// enum BankName {
//   PNB_12345678901234567890,
//   SBI_348539853453453
// }
//
// final bankNameValues = EnumValues({
//   "PNB-12345678901234567890": BankName.PNB_12345678901234567890,
//   "SBI -348539853453453": BankName.SBI_348539853453453
// });
//
// enum Type {
//   CR,
//   DR,
//   TYPE_CR,
//   TYPE_DR
// }
//
// final typeValues = EnumValues({
//   "Cr": Type.CR,
//   "Dr": Type.DR,
//   "CR": Type.TYPE_CR,
//   "DR": Type.TYPE_DR
// });
//
// class EnumValues<T> {
//   Map<String, T> map;
//   late Map<T, String> reverseMap;
//
//   EnumValues(this.map);
//
//   Map<T, String> get reverse {
//     reverseMap = map.map((k, v) => MapEntry(v, k));
//     return reverseMap;
//   }
// }
//
//



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
  Type? type;
  String? amount;
  String? oldBalance;
  String? newBalance;
  BankName? bankName;
  String? remark;

  Datum({
    this.id,
    this.type,
    this.amount,
    this.oldBalance,
    this.newBalance,
    this.bankName,
    this.remark,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    type: typeValues.map[json["type"]]!,
    amount: json["amount"],
    oldBalance: json["old_balance"],
    newBalance: json["new_balance"],
    bankName: bankNameValues.map[json["bank_name"]]!,
    remark: json["remark"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": typeValues.reverse[type],
    "amount": amount,
    "old_balance": oldBalance,
    "new_balance": newBalance,
    "bank_name": bankNameValues.reverse[bankName],
    "remark": remark,
  };
}

enum BankName {
  PNB_12345678901234567890,
  SBI_348539853453453
}

final bankNameValues = EnumValues({
  "PNB-12345678901234567890": BankName.PNB_12345678901234567890,
  "SBI -348539853453453": BankName.SBI_348539853453453
});

enum Type {
  CR,
  DR,
  TYPE_CR,
  TYPE_DR
}

final typeValues = EnumValues({
  "Cr": Type.CR,
  "Dr": Type.DR,
  "CR": Type.TYPE_CR,
  "DR": Type.TYPE_DR
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
