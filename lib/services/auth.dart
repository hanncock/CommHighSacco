import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:ezenSacco/Pages/Home/homescreen.dart';
import 'package:ezenSacco/models/LoanLedger_Transactionmodel.dart';
import 'package:ezenSacco/models/alltransactions_model.dart';
import 'package:ezenSacco/models/loanShedule_model.dart';
import 'package:ezenSacco/models/shareAccledger_model.dart';
import 'package:ezenSacco/wrapper.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ezenSacco/models/user.dart';

class AuthService {

  User? _userdata(use){
    return use != null ? User(email: use) : null ;
  }

  Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  internetFunctions()async{
    try {
      final checkConnection = await InternetAddress.lookup('google.com');
      if (checkConnection.isNotEmpty && checkConnection[0].rawAddress.isNotEmpty) {
        return true;
      }
    }on SocketException catch (_) {
      print('not connected');
      return false;
    }
  }


  SignIn(String email, String password, String url) async {
    String all = url.toString()+'/live/api/auth/login';
    Map data = {
      "username": email,
      "password": password
    };

    var send = jsonEncode(data);
    Response response = await http.post(Uri.parse(all), body: send, headers: headers);
    User? use = _userdata(jsonDecode(response.body));
    return use;
  }

  CreateUser(String mbrNo, String idNo, String url) async {
    String all = url.toString()+'/live/api/auth/register';
    print(all);
    Map data = {
      "saccoMemberNo": mbrNo.toString(),
      "saccoMemberIdNo": idNo.toString()
    };
    print(data);

    var send = jsonEncode(data);
    Response response = await http.post(Uri.parse(all), body: send, headers: headers);
    var jsondata = jsonDecode(response.body);
    print(jsondata);
    return jsondata;
  }

  Future userCorouselInfo() async {
    String getInfo = userData[0].toString() +'/api/sacco_members/load/'+userData[1]['saccoMembershipId'].toString() ;
    print(getInfo);
    try{
      var response =  await get(Uri.parse(getInfo));
      // var response =await Dio().get(getProperties,options: buildCacheOptions(Duration(Days: 1)));

      var jsondata = jsonDecode(response.body);
      return jsondata;
    }catch(e){
      return e.toString();
    }
  }

  Future membersList() async {
    String membersList = userData[0].toString() +'/api/sacco_members/list?companyId='+userData[1]['companyId'].toString()+'&start=-1&limit=-1'  ;
    try{
      var response =  await get(Uri.parse(membersList));
      var jsondata = jsonDecode(response.body);
      return jsondata;
    }catch(e){
      return e.toString();
    }
  }

  Future requestGuarantorship(loanId, memberId,requestedAmount,requestMsg)async {
    var all = userData[0] + '/live/api/sacco_loan/saveguarantor';

    Map data = {
      "membershipId": memberId,
      "loanId": loanId,
      "guaranteedAmountReq": requestedAmount,
      "guaranteeReqMsg": requestMsg,
    };
    var send = jsonEncode(data);
    // return send;
    Response response = await http.post(Uri.parse(all), body: send, headers: headers);
    var use = jsonDecode(response.body);
    return use;
  }

  Future acceptrejectGuarantorship(memberId,status,amounttoGuarantee,guarenteeMsg,)async {
    var all = userData[0] + '/live/api/sacco_loan/approveguarantor';

    Map data = {
      "id": memberId,
      "status": status,
      "guaranteedAmount": amounttoGuarantee,
      "guaranteeApprovalMsg": guarenteeMsg,
    };
    var send = jsonEncode(data);
    // return send;
    Response response = await http.post(Uri.parse(all), body: send, headers: headers);
    var use = jsonDecode(response.body);
    return use;
  }


  Future guarantors_guaranteedloan(value) async{
    String guarantors_guaranteed =  userData[0]+'/api/sacco_loan/guarantors?loanId='+value.toString();
    // return guarantors_guaranteed;
    try{
      var response =  await get(Uri.parse(guarantors_guaranteed));
      var jsondata = jsonDecode(response.body);
      return jsondata;
    }catch(e){
      return e.toString();
    }
  }

  Future guarantors_guaranteedmbdrship() async{
    String guarantors_guaranteedmbrshp =  userData[0]+'/api/sacco_loan/guarantors?loanMembershipId='+userData[1]['saccoMembershipId'].toString();
    print(guarantors_guaranteedmbrshp);
    // return guarantors_guaranteed;
    try{
      var response =  await get(Uri.parse(guarantors_guaranteedmbrshp));
      var jsondata = jsonDecode(response.body);
      return jsondata;
    }catch(e){
      return e.toString();
    }
  }

  Future guarantors_guaranteedissued() async{
    String guarantors_guaranteedmbrshp =  userData[0]+'/api/sacco_loan/guarantors?membershipId='+userData[1]['saccoMembershipId'].toString();
    // return guarantors_guaranteed;
    try{
      var response =  await get(Uri.parse(guarantors_guaranteedmbrshp));
      var jsondata = jsonDecode(response.body);
      return jsondata;
    }catch(e){
      return e.toString();
    }
  }

  Future guarantors_guaranteedincoming() async{
    String guarantors_guaranteedmbrshp =  userData[0]+'/api/sacco_loan/guarantors?membershipId='+userData[1]['saccoMembershipId'].toString();
    // return guarantors_guaranteed;
    try{
      var response =  await get(Uri.parse(guarantors_guaranteedmbrshp));
      var jsondata = jsonDecode(response.body);
      return jsondata;
    }catch(e){
      return e.toString();
    }
  }



  Future getUserAppliedLoans() async{
    String gettingLoans =  userData[0]+'/api/sacco_loan/applications?memberId='+userData[1]['saccoMembershipId'].toString();
    try{
      var response =  await get(Uri.parse(gettingLoans));
      var jsondata = jsonDecode(response.body);
      return jsondata;
    }catch(e){
      return e.toString();
    }
  }

  Future getLoanRepaymentSchedule(loanId) async{
    //https://online.ezenfinancials.com/live/api/sacco_loan/repaymentschedule?loanId=950835
    String gettingLoans =  userData[0]+'/live/api/sacco_loan/repaymentschedule?loanId='+loanId.toString();
   // return gettingLoans;
    try{
      var response =  await get(Uri.parse(gettingLoans));
      var jsondata = jsonDecode(response.body);
      return jsondata;
    }catch(e){
      return e.toString();
    }
  }

   Future getUserLoans() async{
    String gettingLoans =  userData[0]+'/api/sacco_loan/applications?membershipId='+userData[1]['saccoMembershipId'].toString()+'&companyId='+userData[1]['companyId'].toString();
   try{
     var response =  await get(Uri.parse(gettingLoans));
     var jsondata = jsonDecode(response.body);
     return jsondata;
   }catch(e){
     return e.toString();
   }
  }

  Future getLoanProduct() async{
    //https://online.ezenfinancials.com/live/api/sacco_loanproducts/list?companyId=1202
    String gettingLoans =  userData[0]+'/api/sacco_loanproducts/list?companyId='+userData[1]['companyId'].toString();
    //return gettingLoans;
    try{
      var response =  await get(Uri.parse(gettingLoans));
      var jsondata = jsonDecode(response.body);
      return jsondata;
    }catch(e){
      return e.toString();
    }
  }

  Future loansGuaranteed() async{
    // String gettingloansGuaranteed = userData[0] + '//api/sacco_loan/guarantors?companyId=' + userData[1]['companyId'].toString();
    String gettingloansGuaranteed = 'http://online.ezenfinancials.com/live/api/sacco_loan/guarantors?companyId=36765664';
    try{
      var resposne = await get(Uri.parse(gettingloansGuaranteed));
      var jsondata = jsonDecode(resposne.body);
      return jsondata;
    }catch(e){
      return e.toString();
    }
  }

  Future getShares() async{
    String gettingShares = userData[0] + '/api/sacco_shares/accounts?memberId=' + userData[1]['saccoMembershipId'].toString();
    try{
      var resposne = await get(Uri.parse(gettingShares));
      var jsondata = jsonDecode(resposne.body);
      return jsondata;
    }catch(e){
      return e.toString();
    }
  }

  Future getShareDeposits() async{
    String gettingShares = userData[0] + '/live/api/sacco_shares/deposits?membershipId=' + currentUserData['id'].toString();
    try{
      var resposne = await get(Uri.parse(gettingShares));
      var jsondata = jsonDecode(resposne.body);
      return jsondata;
    }catch(e){
      return e.toString();
    }
  }

  Future shareLedger(ledgerId) async{
   // https://online.ezenfinancials.com/live/api/sacco_shares/ledger?ledgerId=9277055&companyId=1202
    String getLedger = userData[0] + '/api/sacco_shares/ledger?ledgerId=' + ledgerId.toString()+'&companyId='+userData[1]['companyId'].toString();
    //return getLedger;
    try{
      var resposne = await get(Uri.parse(getLedger));
      var jsondata = jsonDecode(resposne.body);
      return jsondata;
    }catch(e){
      return e.toString();
    }
  }

  Future getShareProducts() async{
    //https://online.ezenfinancials.com/live/api/sacco_shareproducts/list?companyId=1202
    String gettingShares = userData[0] + '/api/sacco_shareproducts/list?companyId=' + userData[1]['companyId'].toString();
    print(gettingShares);
    try{
      var resposne = await get(Uri.parse(gettingShares));
      var jsondata = jsonDecode(resposne.body);
      return jsondata;
    }catch(e){
      return e.toString();
    }
  }


  Future getMonthlyContributions(yearFrom,yearTo) async{
    //https://cloud.ezenfinancials.com/live/api/members/5749/getMemberContribution/8456/2021/2022
    String gettingShares = userData[0] +'/live/api/members/'+userData[1]['companyId'].toString()+'/getMemberContribution/' +userData[1]['saccoMembershipId'].toString()+'/'+yearFrom.toString()+'/'+yearTo.toString();
    //return gettingShares;
    try{
      var resposne = await get(Uri.parse(gettingShares));
      var jsondata = jsonDecode(resposne.body);
      return jsondata;
    }catch(e){
      return e.toString();
    }
   //'/api/sacco_shareproducts/list?companyId=' + userData[1]['companyId'].toString();
  }



  Future getShareTransferOutgoing() async{
    //https://online.ezenfinancials.com/live/api/sacco_shares/transfers?membershipFromId=9295777
    String gettingShares = userData[0] + '/api/sacco_shares/transfers?membershipFromId=' + userData[1]['saccoMembershipId'].toString();
    try{
      var resposne = await get(Uri.parse(gettingShares));
      var jsondata = jsonDecode(resposne.body);
      return jsondata;
    }catch(e){
      return e.toString();
    }
  }

  Future getSavingsTransferIncoming() async{
    //https://online.ezenfinancials.com/live/api/sacco_savings/transfers?membershipToId=9295777
    String savingsTrans = userData[0] + '/api/sacco_savings/transfers?membershipToId=' + userData[1]['saccoMembershipId'].toString();
    try{
      var resposne = await get(Uri.parse(savingsTrans));
      var jsondata = jsonDecode(resposne.body);
      return jsondata;
    }catch(e){
      return e.toString();
    }
  }

  Future getSavingsTransferOutgoing() async{
    //https://online.ezenfinancials.com/live/api/sacco_savings/transfers?membershipFromId=9295777
    String savingsTrans = userData[0] + '/api/sacco_savings/transfers?membershipFromId=' + userData[1]['saccoMembershipId'].toString();
    try{
      var resposne = await get(Uri.parse(savingsTrans));
      var jsondata = jsonDecode(resposne.body);
      return jsondata;
    }catch(e){
      return e.toString();
    }
  }


  Future getShareTransferIncoming() async{
    //https://online.ezenfinancials.com/live/api/sacco_shares/transfers?membershipToId=9295777
    String gettingShares = userData[0] + '/api/sacco_shares/transfers?membershipToId=' + userData[1]['saccoMembershipId'].toString();
    try{
      var resposne = await get(Uri.parse(gettingShares));
      var jsondata = jsonDecode(resposne.body);
      return jsondata;
    }catch(e){
      return e.toString();
    }
  }


  Future getSavings() async{
    //https://online.ezenfinancials.com/live/api/sacco_savings/accounts?memberId=9295777

    String gettingShares = userData[0] + '/api/sacco_savings/accounts?memberId=' + currentUserData['id'].toString();
    try{
      var resposne = await get(Uri.parse(gettingShares));
      var jsondata = jsonDecode(resposne.body);
      return jsondata;
    }catch(e){
      return e.toString();
    }
  }

  Future<List> fetchAllTransactions() async {
    String allTransactions = userData[0]+'/api/sacco_members/ledger_txns?membershipId='+userData[1]['saccoMembershipId'].toString()+'&companyId='+userData[1]['companyId'].toString();
    print(allTransactions);
    final response = await http.get(Uri.parse(allTransactions));
    var jsonData= jsonDecode(response.body);
    var returnData = jsonEncode(jsonData['list']);
    return allTransactionsFromJson(returnData);
  }

  fetchAllTransactions2() async {
    String allTransactions = userData[0]+'/api/sacco_members/ledger_txns?membershipId='+userData[1]['saccoMembershipId'].toString()+'&companyId='+userData[1]['companyId'].toString();
    final response = await http.get(Uri.parse(allTransactions));
    var jsonData= jsonDecode(response.body);
    var returnData = jsonData['list'];
    return returnData;
  }

  Future<List> fetchLoanLedger(ledgerId) async {
    String loanledgers = userData[0] + '/api/sacco_loan/ledger?ledgerId=' + ledgerId.toString()+'&companyId='+userData[1]['companyId'].toString();
    final response = await http.get(Uri.parse(loanledgers));
    var jsonData= jsonDecode(response.body);
    var returnData = jsonEncode(jsonData['list']);
    return loanLedgerFromJson(returnData);
  }

  fetchLoanLedger2(ledgerId) async {
    var loanledgers = userData[0] + '/api/sacco_loan/ledger?ledgerId=' + ledgerId.toString()+'&companyId='+userData[1]['companyId'].toString();
    final response = await http.get(Uri.parse(loanledgers));
    var jsonData= jsonDecode(response.body);
    var returnData = jsonData['list'];
    return returnData;
  }

   fetchLoanRepaymentSchedule(loanId) async {
    String gettingLoans =  userData[0]+'/live/api/sacco_loan/repaymentschedule?loanId='+loanId.toString();
    final response = await http.get(Uri.parse(gettingLoans));
    var jsonData= jsonDecode(response.body);
    var returnData = jsonEncode(jsonData['list']);
    return loanScheduleFromJson(returnData);
  }

  fetchLoanRepaymentSchedule2(loanId) async {
    String gettingLoans =  userData[0]+'/live/api/sacco_loan/repaymentschedule?loanId='+loanId.toString();
    final response = await http.get(Uri.parse(gettingLoans));
    var jsonData= jsonDecode(response.body);
    return jsonData;
  }

  Future<List> fetchShareLedger(ledgerId) async {
    String getLedger = userData[0] + '/api/sacco_shares/ledger?ledgerId=' + ledgerId.toString()+'&companyId='+userData[1]['companyId'].toString();
    print(getLedger);
    final response = await http.get(Uri.parse(getLedger));
    var jsonData= jsonDecode(response.body);
    var returnData = jsonEncode(jsonData['list']);
    return shareLedgerFromJson(returnData);
  }

  Future getInterestEarned() async{
    String interstEarned = userData[0]+'/live/api/sacco_savings/interests?membershipFromId='+userData[1]['saccoMembershipId'].toString();
    //return interstEarned;
    try{
      var resposne = await get(Uri.parse(interstEarned));
      var jsondata = jsonDecode(resposne.body);
      return jsondata;
    }catch(e){
      return e.toString();
    }
  }

  Future savingsProduct() async{
    //https://online.ezenfinancials.com/live/api/sacco_savingproducts/list?companyId=1202
    String savingsProduct = userData[0]+'/api/sacco_savingproducts/list?companyId='+userData[1]['companyId'].toString();
    try{
      var resposne = await get(Uri.parse(savingsProduct));
      var jsondata = jsonDecode(resposne.body);
      return jsondata;
    }catch(e){
      return e.toString();
    }
  }

  Future getSavingsDeposits() async{
    String savingsProduct = userData[0]+'/live/api/sacco_savings/deposits?membershipId='+currentUserData['id'].toString();
    try{
      var resposne = await get(Uri.parse(savingsProduct));
      var jsondata = jsonDecode(resposne.body);
      return jsondata;
    }catch(e){
      return e.toString();
    }
  }

  Future getSavingsLedger(ledgerId) async{
    String getSavingsLedger = userData[0] + '/api/sacco_savings/ledger?ledgerId=' + ledgerId.toString()+'&companyId='+userData[1]['companyId'].toString();
    try{
      var resposne = await get(Uri.parse(getSavingsLedger));
      var jsondata = jsonDecode(resposne.body);
      return jsondata;
    }catch(e){
      return e.toString();
    }
  }


  getLoanLimit(loanprodId) async{
    String loanLimit = userData[0] + '/api/sacco_loan/loandefaults?membershipId='+userData[1]['saccoMembershipId'].toString()+'&loanProductId='+loanprodId.toString();
    // return loanLimit;
    try{
      var resposne = await get(Uri.parse(loanLimit));
      var jsondata = jsonDecode(resposne.body);
      return jsondata;
    }catch(e){
      return e.toString();
    }
  }

  getNominees() async{
    String loanLimit = userData[0] + '/api/sacco_nominee/list?membershipId='+userData[1]['saccoMembershipId'].toString();
    print(loanLimit);
    try{
      var resposne = await get(Uri.parse(loanLimit));
      var jsondata = jsonDecode(resposne.body);
      return jsondata;
    }catch(e){
      return e.toString();
    }
  }

  addNominees(updateId, nomineeId, nomineeName, selRelation, selectedDate, nomineeAddr, nomineePhone)async{

    String all = userData[0].toString()+'/api/sacco_nominee/save';
    print(all);
    Map data = {
      "id":  updateId ?? '',
      "name": nomineeName,
      "nxtKinId": nomineeId,
      "dob": selectedDate,
      "relation": selRelation,
      "address": nomineeAddr,
      "phone": nomineePhone,
      "membershipId": userData[1]['saccoMembershipId']
    };
    print(data);

    var send = jsonEncode(data);
    Response response = await http.post(Uri.parse(all), body: send, headers: headers);
    var jsondata = jsonDecode(response.body);
    print(jsondata);
    return jsondata;

  }



  uploadImage(fileBaseSixFour)async{
    var all = userData[0] + '/live/api/sacco_members/profile_upload';
    print(all);

    Map data = {
      "membershipId":userData[1]['saccoMembershipId'],
      "fileBaseSixFour": fileBaseSixFour
    };
    print(data);
    try{
      var send = jsonEncode(data);
      // print(send);
      Response response = await http.post(Uri.parse(all), body: send, headers: headers);
      print(response.statusCode);
      var use = jsonDecode(response.body);
      return use;
    }catch(e){
      return e.toString();
    }


  }

  getStatement()async{
    var memberStatement = await userData[0] + '/live/api/sacco_members/statementpdf?membershipId='+userData[1]['saccoMembershipId'].toString();
    print(memberStatement);
    try{
      var resposne = await get(Uri.parse(memberStatement));
      var jsondata = jsonDecode(resposne.body);
      return jsondata['message'];
      // var data = await http.get(Uri.parse(jsondata['message']));
      // return data.bodyBytes;
    }catch(e){
      return e.toString();
    }

  }


  Future fileRequirements(prodId)async{
    // String gettingLoans =  userData[0]+'/api/sacco_loanproducts/applications?memberId='+userData[1]['saccoMembershipId'].toString();
    String requiredfiles =  userData[0]+'/api/sacco_loanproducts/list_product_files?productId='+prodId.toString();
    print(requiredfiles);
    try{
      var response =  await get(Uri.parse(requiredfiles));
      var jsondata = jsonDecode(response.body);
      return jsondata;
    }catch(e){
      return e.toString();
    }
  }
  uploadDocs(loanId,fileName,fileBaseSixFour) async{

    var all = userData[0] + '/live/api/sacco_loan/file_upload';

    Map data = {
      "loanId":loanId,
      "fileName": fileName,
      "fileBaseSixFour": fileBaseSixFour
    };
    // return data;
    print('$data is the end');
    var send = jsonEncode(data);
    Response response = await http.post(Uri.parse(all), body: send, headers: headers);
    var use = jsonDecode(response.body);
    return use;
  }

  loanProjections(loanAmount,feesAsPrincipal,interstRate,numInstal,instalAmnt,intType,intFreq,repayFreq) async{

    var all = userData[0] + '/live/api/sacco_loan/projection';

    Map data = {
    "loanAmount":loanAmount,
    "feeAsPrincipal": feesAsPrincipal,
    "interestRate": interstRate,
    "numberOfInstallments": numInstal,
    "installmentAmount": instalAmnt,
    "interestType": intType,
    "interestFrequency": intFreq,
    "repaymentFrequency": repayFreq
    };

    // return data;
    var send = jsonEncode(data);
    Response response = await http.post(Uri.parse(all), body: send, headers: headers);
    var use = jsonDecode(response.body);
    return use;
  }


  calcLoan(selectedAmount, interstRate, numInstal, instalAmnt) async{

    var all = userData[0] + '/live/api/sacco_loan/projection';

    Map data = {
      "loanAmount":selectedAmount,
      "interestRate": interstRate,
      "numberOfInstallments": numInstal ?? 0,
      "installmentAmount": instalAmnt ?? 0,
      "interestType": "REDUCING_INTEREST_EMI",
      "interestFrequency": "ANNUALLY",
    };

    // return data;
    var send = jsonEncode(data);
    Response response = await http.post(Uri.parse(all), body: send, headers: headers);
    var use = jsonDecode(response.body);
    return use;
  }

  Future requestLoan(loanId,loanAmount,numberOfInstallments,loanRegNotes)async{
    var all = userData[0] + '/api/sacco_loan/save';

    Map data = {
      "membershipId": userData[1]['saccoMembershipId'],
      "loanProductId":loanId,
      "amountAppliedFor": loanAmount,
      "numberOfInstallments": numberOfInstallments,
      "moreLoanReason":loanRegNotes
      // "assignableShareAtLoan": 0,
      // "assignableSavingAtLoan": 20000,
      // "assignableShareAndSavingAtLoan": 20000
      // "assignableShareAtLoan": number [optional] Assignable Shares amount,
      // "assignableSavingAtLoan": number [optional] Assignable Savings amount,
      // "assignableShareAndSavingAtLoan": number [optional] Assignable Shares + Saving Amount
    };

    // return data;
    var send = jsonEncode(data);
    Response response = await http.post(Uri.parse(all), body: send, headers: headers);
    var use = jsonDecode(response.body);
    return use;
  }
  Future getDividents() async{
    String getDividents = userData[0] + '/api/sacco_shares/dividends?memberId=' + userData[1]['saccoMembershipId'].toString();
    try{
      var resposne = await get(Uri.parse(getDividents));
      var jsondata = jsonDecode(resposne.body);
      return jsondata;
    }catch(e){
      return e.toString();
    }
  }

  Future transferShares() async{
    String shareTransfer = userData[0] + '/api/sacco_shares/transfers?membershipFromId=' + userData[1]['saccoMembershipId'].toString();
    try{
      var resposne = await get(Uri.parse(shareTransfer));
      var jsondata = jsonDecode(resposne.body);
      return jsondata;
    }catch(e){
      return e.toString();
    }
  }

  Future getPaybills()async{
    String getPaybills = userData[0] + '/live/api/lipanampesa/list?companyId=' + userData[1]['companyId'].toString();
    try{
      var resposne = await get(Uri.parse(getPaybills));
      var jsondata = jsonDecode(resposne.body);
      return jsondata;
    }catch(e){
      return e.toString();
    }
  }


  Future changePassword(int userId, String oldPassword, String newPassword, String confirmPassword,) async{
    String all = userData[0] + '/live/api/auth/changepwd';
    Map credentials = {
      "userId": userId,
      "oldPassword": oldPassword,
      "newPassword": newPassword,
      "confirmPassword": confirmPassword,
    };
    var sendCredentials = jsonEncode(credentials);
    Response response = await http.post(Uri.parse(all), body: sendCredentials, headers: headers);
    var changed = jsonDecode(response.body);
    return changed;
  }

  Future lipaNaMpesa(bizShortCode, amount, phoneNo, accountRef) async{
    Map paymentDetails = {
      "bizShortCode" : bizShortCode,
      "amount": amount,
      "phoneNo" : phoneNo,
      "accountRef" : accountRef,
    };
    var paymentPayload = jsonEncode(paymentDetails);
    String url = userData[0].toString() + '/api/lipanampesa/stkpush';//+ paymentPayload.toString() + headers.toString();
   // return url;
    try{
      var payment = await http.post(Uri.parse(url), body: paymentPayload, headers: headers);
      // print(payment);
      // return payment;
      var jsondata = jsonDecode(payment.body);
      return jsondata;
    }catch(e){
      return e.toString();
    }
  }

 Future registerWithEmailAndPassword(String email, String password) async{

    try{
      Response response = await get(Uri.parse("http://worldtimeapi.org/api/timezone/Europe/London"));
      Map data = jsonDecode(response.body);
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString(email, data['name']);
    }
    catch(e){
      return e.toString();
   }
 }

}