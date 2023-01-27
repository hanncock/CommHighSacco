import 'dart:convert';

List<LoanSchedules> loanScheduleFromJson(String str) =>
    List<LoanSchedules>.from(json.decode(str).map((x) => LoanSchedules.fromJson(x)));

String loanScheduleToJson(List<LoanSchedules> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LoanSchedules {
  LoanSchedules({
    required this.installment,
    required this.loanBalance,
    required this.principle,
    required this.interest,
    required this.schedulePayment,
    required this.cummulativeInterest,
    required this.date,
  });

  var date;
  var installment;
  var loanBalance;
  var principle;
  var interest;
  var schedulePayment;
  var cummulativeInterest;

  factory LoanSchedules.fromJson(Map<String, dynamic> json) => LoanSchedules(
    date: json["dueDate"],
    installment: json["installmentNo"],
    loanBalance: json["principalApplied"],
    principle: json["principalPayment"],
    interest: json["interestPayment"],
    schedulePayment: json["principalPayment"],
    cummulativeInterest: json["cumulativeInterest"],
  );

  Map<String, dynamic> toJson() => {
    "empid": date,
    "empname": installment,
    "empemail": loanBalance,
    "empemail": principle,
    "empemail": interest,
    "empemail": schedulePayment,
    "empemail": cummulativeInterest,
  };
}