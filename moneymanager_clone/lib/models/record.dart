// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TransactionModel {
  String category;
  String date;
  String time;
  String amount;
  String type;
  String title;
  String note;
  TransactionModel({
    required this.category,
    required this.date,
    required this.time,
    required this.amount,
    required this.type,
    required this.title,
    required this.note,
  });

  // IncomeModel(
  //     {required this.category,
  //     required this.date,
  //     required this.time,
  //     required this.amount,
  //     required this.type,
  //     required this.title,
  //     required this.note});

  TransactionModel copyWith({
    String? category,
    String? date,
    String? time,
    String? amount,
    String? type,
    String? title,
    String? note,
  }) {
    return TransactionModel(
      category: category ?? this.category,
      date: date ?? this.date,
      time: time ?? this.time,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      title: title ?? this.title,
      note: note ?? this.note,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'category': category,
      'date': date,
      'time': time,
      'amount': amount,
      'type': type,
      'title': title,
      'note': note,
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      category: map['category'] as String,
      date: map['date'] as String,
      time: map['time'] as String,
      amount: map['amount'] as String,
      type: map['type'] as String,
      title: map['title'] as String,
      note: map['note'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionModel.fromJson(String source) =>
      TransactionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'IncomeModel(category: $category, date: $date, time: $time, amount: $amount, type: $type, title: $title, note: $note)';
  }

  @override
  bool operator ==(covariant TransactionModel other) {
    if (identical(this, other)) return true;

    return other.category == category &&
        other.date == date &&
        other.time == time &&
        other.amount == amount &&
        other.type == type &&
        other.title == title &&
        other.note == note;
  }

  @override
  int get hashCode {
    return category.hashCode ^
        date.hashCode ^
        time.hashCode ^
        amount.hashCode ^
        type.hashCode ^
        title.hashCode ^
        note.hashCode;
  }
}
