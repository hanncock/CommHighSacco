// import 'dart:convert';
//
// class LoanLedger {
//   LoanLedger({
//     required this.date,
//     required this.description,
//     required this.debit,
//     required this.credit,
//     required this.balance,
//   });
//
//   final int date;
//   final double credit;
//   final double debit;
//   final double balance;
//   final String description;
//
//   factory LoanLedger.fromJson(Map<String, dynamic> json) => LoanLedger(
//     date: json["txnDate"],
//     description: json["descr"],
//     debit: json["debit"],
//     credit: json["credit"],
//     balance: json["balance"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "date": date,
//     "debit": debit,
//     "credit": credit,
//     "description": description,
//     "balance": balance,
//   };
// }
//
// List<LoanLedger> loanLedgerFromJson(String str) =>
//     List<LoanLedger>.from(json.decode(str).map((x) => LoanLedger.fromJson(x)));
//
// String loanLedgerToJson(List<LoanLedger> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
import 'dart:convert';

List<LoanLedgers> loanLedgerFromJson(String str) =>
    List<LoanLedgers>.from(json.decode(str).map((x) => LoanLedgers.fromJson(x)));

String loanLedgerToJson(List<LoanLedgers> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LoanLedgers {
  LoanLedgers({
    required this.date,
    required this.description,
    required this.debit,
    required this.credit,
    required this.balance,
  });

  var date;
  var description;
  var debit;
  var credit;
  var balance;

  factory LoanLedgers.fromJson(Map<String, dynamic> json) => LoanLedgers(
    date: json["txnDate"],
    description: json["descr"],
    debit: json["debit"],
    credit: json["credit"],
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