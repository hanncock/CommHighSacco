import 'package:ezenSacco/constants.dart';
import 'package:ezenSacco/disp_pages/loan_ledger.dart';
import 'package:ezenSacco/disp_pages/loan_schedule.dart';
import 'package:ezenSacco/routes.dart';
import 'package:ezenSacco/services/auth.dart';
import 'package:ezenSacco/utils/formatter.dart';
import 'package:ezenSacco/widgets/backbtn_overide.dart';
import 'package:ezenSacco/widgets/spin_loader.dart';
import 'package:flutter/material.dart';

import 'guarantorslist.dart';

class Loans extends StatefulWidget {
  const Loans({Key? key}) : super(key: key);
  @override
  State<Loans> createState() => _LoansState();
}

var loanLedger;
class _LoansState extends State<Loans> {

  final AuthService auth = AuthService();
  bool loading = false;
  bool noLoans = true;
  var dispensedLoans ;
  bool initial_load = true;
  //DateTime today = DateTime.fromMillisecondsSinceEpoch();

  loansItem () async{
    var check_connection = await auth.internetFunctions();
    if(check_connection == true){
      var response = await auth.getUserAppliedLoans();
      print(response);
      if(response['count']==null){
        initial_load = false;
        noLoans = false;
      }else{
        noLoans = false;
        initial_load = false;
        setState(() {
          dispensedLoans = response['list'];
          print(dispensedLoans);
        });
      }
    }else{
      initial_load = true;
    }


}

  @override
  void initState() {
    loansItem();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final styles = TextStyle(fontFamily: 'Muli',fontWeight: FontWeight.bold,fontSize: width* 0.035);
    final styles2 = TextStyle(fontFamily: 'Muli',color: Colors.black45,fontSize: width* 0.035);
    return Scaffold(
      appBar: AppBar(
        leading: goback(context),
        title: Text(
          'My Loans',
          style: TextStyle(
            color: Colors.redAccent,
            fontFamily: "Muli"
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: initial_load?
          LoadingSpinCircle()
      : Column(
        children: [
          Flexible(
              child: noLoans ?
                  Center(
                    child: Text(
                      'There are no disbursed Loans',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                        fontFamily: "Muli"
                      ),
                    ),
                  ): ListView.builder(
                itemBuilder: (context, index){
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        children: [
                          Card(
                            color: dispensedLoans[index]['submittedForAppraisal'].toString().toUpperCase() == 'YES' ? Colors.lightBlueAccent:
                            dispensedLoans[index]['status'] == 'PENDING' ? Colors.orange:
                            dispensedLoans[index]['status'] == 'APPROVED' ? Colors.green :
                            Colors.grey,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        'Loan Type',
                                      style: styles2,
                                      ),
                                      Text(
                                        dispensedLoans[index]['product'].toString(),
                                        style: styles,
                                      )
                                    ],
                                  ),

                                  SizedBox(width: width * 0.1,),
                                  Column(
                                    children: [
                                      Text(
                                        ' Amount',
                                        style: styles2,
                                      ),
                                      Text(
                                        '${formatCurrency(dispensedLoans[index]['loanAmount'])}',
                                        style: styles,
                                      ),
                                    ],
                                  ),

                                ],
                              ),
                            ),
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     ElevatedButton(
                          //       onPressed: (){
                          //
                          //       },
                          //       child: Text('Attachments'),
                          //     )
                          //   ],
                          // ),
                          Card(
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Divider(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Date Applied',
                                        style: styles,
                                      ),
                                      Text(f.format(new DateTime.fromMillisecondsSinceEpoch(dispensedLoans[index]['dateOfApplication'])),style: styles2,),
                                    ],
                                  ),

                                  Divider(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          'Loan ID/No',
                                        style:styles,
                                      ),
                                      Text( dispensedLoans[index]['loanNumber'].toString(),style: styles2,),
                                    ],
                                  ),
                                  Divider(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Loan Principle',
                                        style: styles,),
                                      Text('${formatCurrency(dispensedLoans[index]['amountAppliedFor'])}' , style: styles2,),
                                    ],
                                  ),
                                  Divider(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Amount Applied',
                                        style: styles,),
                                      Text('${formatCurrency(dispensedLoans[index]['amountAppliedFor'])}',style: styles2,),
                                    ],
                                  ),
                                  Divider(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Disbursed Amount',
                                        style: styles,),
                                      Text( '${formatCurrency(dispensedLoans[index]['loanAmount'])}',style: styles2,),
                                    ],
                                  ),
                                  Divider(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Loan Period(Months)',
                                        style: styles,),
                                      Text( dispensedLoans[index]['numberOfInstallments'].toString() == null ? '' : dispensedLoans[index]['numberOfInstallments'].toString(),style: styles2,),
                                    ],
                                  ),
                                  Divider(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Interest Type',
                                        style: styles,
                                      ),
                                      SizedBox(
                                        width: width * 0.5,
                                        child: Text(
                                          textAlign: TextAlign.left,
                                          softWrap:true,
                                          dispensedLoans[index]['loanType'].toString(),style: styles2,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Interest Rate',
                                        style: styles),
                                      Text(dispensedLoans[index]['interestRate'].toString(),style: styles2,),
                                    ],
                                  ),
                                  Divider(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Total Fees',
                                        style: styles,),
                                      Text(dispensedLoans[index]['totalLoanFee'].toString(),style: styles2,),
                                    ],
                                  ),
                                  Divider(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Installment Amount',
                                        style: styles),
                                      Text( '${formatCurrency(dispensedLoans[index]['installmentAmount'])}',style: styles2,),
                                    ],
                                  ),
                                  Divider(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Grace Period',
                                        style: styles,),
                                      Text(dispensedLoans[index]['gracePeriodMonths'].toString(),style: styles2,),
                                    ],
                                  ),
                                  Divider(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Repayment Frequency',
                                        style: styles,),
                                      Text( dispensedLoans[index]['repaymentFreq'].toString(),style: styles2,),
                                    ],
                                  ),
                                  Divider(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Repayment Start Date',
                                        style: styles),
                                      Text(f.format(new DateTime.fromMillisecondsSinceEpoch(dispensedLoans[index]['dateOfApplication'])),style: styles2,),
                                    ],
                                  ),
                                  Divider(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Loan Balance',
                                        style: styles,),
                                      Text('${formatCurrency(dispensedLoans[index]['loanBalance'])}' ,style: styles2,),
                                    ],
                                  ),
                                  Divider(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Loan Status',
                                        style:styles,),
                                      Text(
                                        dispensedLoans[index]['status'],
                                        style: TextStyle(color: dispensedLoans[index]['status'] == 'PENDING' ? Colors.orange: dispensedLoans[index]['status'] == 'APPROVED' ? Colors.green : Colors.grey),
                                      ),
                                    ],
                                  ),
                                  Divider(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      ElevatedButton(
                                        onPressed: (){
                                           Navigator.push(context, customePageTransion(LoanSchedule(loanId: dispensedLoans[index]['id'].toString())));
                                        },
                                        child: Text(
                                          'Schedule',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Muli",
                                              fontSize: width* 0.035
                                          ),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.redAccent,
                                          padding:  EdgeInsets.all(10.0),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),
                                        ),
                                      ),
                                      dispensedLoans[index]['submittedForAppraisal'].toString().toUpperCase() == 'YES' ?
                                      ElevatedButton(
                                        onPressed: (){
                                          // Navigator.push(context, customePageTransion(LoanSchedule(loanId: dispensedLoans[index]['id'].toString())));
                                          Navigator.push(context, customePageTransion(Guarantorslist(loanId: dispensedLoans[index])));
                                        },
                                        child: Text(
                                          'Request Guarantors',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: "Muli",
                                              fontSize: width* 0.035
                                          ),
                                        ),
                                        // child: Icon(Icons.add_task_outlined),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.redAccent,
                                          padding:  EdgeInsets.all(10.0),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),
                                        ),
                                      ): SizedBox(),
                                      ElevatedButton(
                                        onPressed: () async {
                                          Navigator.push(context, customePageTransion(LoanLedger(LoanLedgerId: dispensedLoans[index]['ledgerId'].toString(),)));
                                        },
                                        child: Text(
                                          'Ledger',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Muli",
                                              fontSize: width* 0.035
                                          ),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.redAccent,
                                          padding:  EdgeInsets.all(10.0),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                shrinkWrap: true,
                itemCount: dispensedLoans.length,
                scrollDirection: Axis.vertical,
              ),
          )
        ],
      ),
    );
  }
}
