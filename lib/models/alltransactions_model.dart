import 'dart:convert';

class AllTransctions {
  AllTransctions({
    required this.date,
    required this.description,
    required this.debit,
    required this.credit,
    required this.balance,
  });

  final int date;
  final double credit;
  final double debit;
  final double balance;
  final String description;
  //final String email;

  factory AllTransctions.fromJson(Map<String, dynamic> json) => AllTransctions(
    date: json["txnDate"],
    description: json["descr"],
    debit: json["debit"],
    credit: json["credit"],
    balance: json["balance"],
  );

  Map<String, dynamic> toJson() => {
    "empid": date,
    "empname": debit,
    "empemail": credit,
    "empemail": description,
    "empemail": balance,
  };
}


List<AllTransctions> allTransactionsFromJson(String str) =>
    List<AllTransctions>.from(json.decode(str).map((x) => AllTransctions.fromJson(x)));

String allTransactionsToJson(List<AllTransctions> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));