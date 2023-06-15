import 'package:ezenSacco/constants.dart';
import 'package:ezenSacco/disp_pages/loans/loan_ledger.dart';
import 'package:ezenSacco/disp_pages/loans/loan_schedule.dart';
import 'package:ezenSacco/routes.dart';
import 'package:ezenSacco/services/auth.dart';
import 'package:ezenSacco/utils/formatter.dart';
import 'package:ezenSacco/widgets/backbtn_overide.dart';
import 'package:ezenSacco/widgets/spin_loader.dart';
import 'package:flutter/material.dart';

import '../attach_files.dart';
import '../guarantorslist.dart';
import 'loan_details.dart';

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
  var showmore;
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
              color: Colors.blue,
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
                return InkWell(
                  onLongPress: (){
                    print('soke');
                  },
                  onTap: (){
                    Navigator.push(context, customePageTransion(LoanDetails(loanvalues: dispensedLoans[index])));
                  },
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context, customePageTransion(LoanDetails(loanvalues: dispensedLoans[index])));
                      setState(() {
                        showmore  == dispensedLoans[index] ? showmore = null : showmore = dispensedLoans[index];

                      });
                    },
                    child: Card
                      (
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  dispensedLoans[index]['status'] == 'APPROVED' ? SizedBox(
                                    width: 30,
                                    child: Image.asset('assets/icons/double-tick-indicator.png',color: Colors.green,),
                                  ) :dispensedLoans[index]['submittedForAppraisal'].toString().toUpperCase() == 'YES' ?
                                  SizedBox(
                                    width: 30,
                                    child: Image.asset('assets/icons/clock.png',color: Colors.blueAccent,),
                                  ):
                                  dispensedLoans[index]['status'] == 'PENDING' ?SizedBox(
                                    width: 30,
                                    child: Image.asset('assets/icons/clock.png',color: Colors.orange,),
                                  ) :
                                  SizedBox(
                                    width: 30,
                                    child: Image.asset('assets/icons/Close.svg',color: Colors.orange,),
                                  ),
                                  SizedBox(width: 10,),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          dispensedLoans[index]['product'].toString(),
                                          style: styles,
                                        ),

                                        SizedBox(width: width * 0.1,),
                                        Text(
                                          '${formatCurrency(dispensedLoans[index]['loanAmount'])}',
                                          style: styles,
                                        ),
                                      ],
                                    ),
                                  ),
                                  // SizedBox(width: 40),
                                  Icon(Icons.navigate_next)
                                ],
                              ),
                            ),


                            // Divider()
                          ],
                        ),
                      ),
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
