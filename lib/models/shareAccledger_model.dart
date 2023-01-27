import 'dart:convert';

List<ShareAccLedgers> shareLedgerFromJson(String str) =>
    List<ShareAccLedgers>.from(json.decode(str).map((x) => ShareAccLedgers.fromJson(x)));

String shareLedgerToJson(List<ShareAccLedgers> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ShareAccLedgers {
  ShareAccLedgers({
    required this.debit,
    required this.credit,
    required this.description,
    required this.balance,
    required this.date,
  });

  var date;
  var debit;
  var credit;
  var balance;
  var description;

  factory ShareAccLedgers.fromJson(Map<String, dynamic> json) => ShareAccLedgers(
    date: json["txnDate"],
    debit: json["debit"],
    credit: json["credit"],
    description: json["descr"],
    balance: json["balance"],
  );

  Map<String, dynamic> toJson() => {
    "empid": date,
    "empname": description,
    "empemail": debit,
    "empemail": credit,
    "empemail": balance,
  };
}