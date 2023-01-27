// class DisbursementModel {
//   String member;
//   int membershipId;
//   int amount;
//   int loanId;
//   String loanName;
//   String loanNo;
//   int loanAmount;
//   String loanType;
//   String status;
//   int dateOfApplication;
//   int disbursementDate;
//   String paymentMethod;
//   String comments;
//   int paymentId;
//   Null paidAccountNo;
//   Null paidAccountName;
//   Null paidBank;
//   String refNo;
//   Null bankId;
//   Null branchId;
//   int cashbookId;
//   Null interestIncomeId;
//   int companyId;
//   int id;
//
//   DisbursementModel(
//       {required this.member,
//       required this.membershipId,
//       required this.amount,
//       required this.loanId,
//       required this.loanName,
//       required this.loanNo,
//       required this.loanAmount,
//       required this.loanType,
//       required this.status,
//       required this.dateOfApplication,
//       required this.disbursementDate,
//       required this.paymentMethod,
//       required this.comments,
//       required this.paymentId,
//       this.paidAccountNo,
//       this.paidAccountName,
//       this.paidBank,
//       required this.refNo,
//       this.bankId,
//       this.branchId,
//       required this.cashbookId,
//       this.interestIncomeId,
//       required this.companyId,
//       required this.id});
//
//   DisbursementModel.fromJson(Map<String, dynamic> json) {
//     member = json['member'];
//     membershipId = json['membershipId'];
//     amount = json['amount'];
//     loanId = json['loanId'];
//     loanName = json['loanName'];
//     loanNo = json['loanNo'];
//     loanAmount = json['loanAmount'];
//     loanType = json['loanType'];
//     status = json['status'];
//     dateOfApplication = json['dateOfApplication'];
//     disbursementDate = json['disbursementDate'];
//     paymentMethod = json['paymentMethod'];
//     comments = json['comments'];
//     paymentId = json['paymentId'];
//     paidAccountNo = json['paidAccountNo'];
//     paidAccountName = json['paidAccountName'];
//     paidBank = json['paidBank'];
//     refNo = json['refNo'];
//     bankId = json['bankId'];
//     branchId = json['branchId'];
//     cashbookId = json['cashbookId'];
//     interestIncomeId = json['interestIncomeId'];
//     companyId = json['companyId'];
//     id = json['id'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['member'] = this.member;
//     data['membershipId'] = this.membershipId;
//     data['amount'] = this.amount;
//     data['loanId'] = this.loanId;
//     data['loanName'] = this.loanName;
//     data['loanNo'] = this.loanNo;
//     data['loanAmount'] = this.loanAmount;
//     data['loanType'] = this.loanType;
//     data['status'] = this.status;
//     data['dateOfApplication'] = this.dateOfApplication;
//     data['disbursementDate'] = this.disbursementDate;
//     data['paymentMethod'] = this.paymentMethod;
//     data['comments'] = this.comments;
//     data['paymentId'] = this.paymentId;
//     data['paidAccountNo'] = this.paidAccountNo;
//     data['paidAccountName'] = this.paidAccountName;
//     data['paidBank'] = this.paidBank;
//     data['refNo'] = this.refNo;
//     data['bankId'] = this.bankId;
//     data['branchId'] = this.branchId;
//     data['cashbookId'] = this.cashbookId;
//     data['interestIncomeId'] = this.interestIncomeId;
//     data['companyId'] = this.companyId;
//     data['id'] = this.id;
//     return data;
//   }
// }
//
// class DisbursementModelResponse {
//   List<DisbursementModel> results;
//
//   DisbursementModelResponse.fromJson(json) {
//     if (json != null) {
//       results = List<DisbursementModel>();
//       json.forEach((v) {
//         results.add(DisbursementModel.fromJson(v));
//       });
//     }
//   }
// }
