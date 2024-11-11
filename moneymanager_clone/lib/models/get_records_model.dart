import 'dart:convert';

class GetTransactionModel {
  int? statusCode;
  bool? status;
  String? message;
  Data? data;

  GetTransactionModel({
    this.statusCode,
    this.status,
    this.message,
    this.data,
  });

  GetTransactionModel copyWith({
    int? statusCode,
    bool? status,
    String? message,
    Data? data,
  }) =>
      GetTransactionModel(
        statusCode: statusCode ?? this.statusCode,
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory GetTransactionModel.fromRawJson(String str) =>
      GetTransactionModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetTransactionModel.fromJson(Map<String, dynamic> json) =>
      GetTransactionModel(
        statusCode: json["statusCode"],
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  List<Record>? records;

  Data({
    this.records,
  });

  Data copyWith({
    List<Record>? records,
  }) =>
      Data(
        records: records ?? this.records,
      );

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        records: json["records"] == null
            ? []
            : List<Record>.from(
                json["records"]!.map((x) => Record.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "records": records == null
            ? []
            : List<dynamic>.from(records!.map((x) => x.toJson())),
      };
}

class Record {
  int? id;
  String? category;
  String? date;
  String? time;
  int amount;
  String? type;
  String? title;
  String? note;
  int? userId;

  Record({
    this.id,
    this.category,
    this.date,
    this.time,
    this.amount = 0,
    this.type,
    this.title,
    this.note,
    this.userId,
  });

  Record copyWith({
    int? id,
    String? category,
    String? date,
    String? time,
    int? amount,
    String? type,
    String? title,
    String? note,
    int? userId,
  }) =>
      Record(
        id: id ?? this.id,
        category: category ?? this.category,
        date: date ?? this.date,
        time: time ?? this.time,
        amount: amount ?? this.amount,
        type: type ?? this.type,
        title: title ?? this.title,
        note: note ?? this.note,
        userId: userId ?? this.userId,
      );

  factory Record.fromRawJson(String str) => Record.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Record.fromJson(Map<String, dynamic> json) => Record(
        id: json["id"],
        category: json["category"],
        date: json["date"],
        time: json["time"],
        amount: json["amount"] == null ? 0 : int.parse(json["amount"]),
        type: json["type"],
        title: json["title"],
        note: json["note"],
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category": category,
        "date": date,
        "time": time,
        "amount": amount,
        "type": type,
        "title": title,
        "note": note,
        "user_id": userId,
      };
}
