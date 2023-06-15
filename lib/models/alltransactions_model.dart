import 'dart:convert';

class AllTransctions {
  AllTransctions({
    required this.date,
    required this.description,
    required this.debit,
    required this.credit,
    required this.balance,
    required this.accName,
  });

  final int date;
  final double credit;
  final double debit;
  final double balance;
  final String description;
  final String accName;
  //final String email;

  factory AllTransctions.fromJson(Map<String, dynamic> json) => AllTransctions(
    date: json["txnDate"],
    description: json["descr"],
    debit: json["debit"],
    credit: json["credit"],
    balance: json["balance"],
    accName: json['accountName']
  );

  Map<String, dynamic> toJson() => {
    "date": date,
    "debit": debit,
    "credit": credit,
    "description": description,
    "accName": accName,
  };
}


List<AllTransctions> allTransactionsFromJson(String str) =>
    List<AllTransctions>.from(json.decode(str).map((x) => AllTransctions.fromJson(x)));

String allTransactionsToJson(List<AllTransctions> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));