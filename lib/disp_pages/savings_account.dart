import 'package:ezenSacco/constants.dart';
import 'package:ezenSacco/disp_pages/montly_contributions.dart';
import 'package:ezenSacco/disp_pages/savingsAcc_ledger.dart';
import 'package:ezenSacco/disp_pages/savings_deposit.dart';
import 'package:ezenSacco/routes.dart';
import 'package:ezenSacco/services/auth.dart';
import 'package:ezenSacco/utils/formatter.dart';
import 'package:ezenSacco/widgets/backbtn_overide.dart';
import 'package:flutter/material.dart';

import '../wrapper.dart';

class SavingsAccount extends StatefulWidget {
  const SavingsAccount({Key? key}) : super(key: key);

  @override
  State<SavingsAccount> createState() => _SavingsAccountState();
}

var savingsLedger;
class _SavingsAccountState extends State<SavingsAccount> {

  final AuthService auth = AuthService();
  bool loading = false;
  bool shares = true;
  List savings = [];
  bool initial_load = true;


  shareItems () async{
    var check_connection = await auth.internetFunctions();
    if(check_connection == true){
      var response = await auth.getSavings();
      print(response);
      if(response['count']==null){
        initial_load = false;
        shares = false;
      }else{
        shares = false;
        initial_load = false;
        setState(() {
          savings = response['list'];
          print(savings);
        });
      }
    }else{
      initial_load = true;
    }

  }

  @override
  void initState() {
    shareItems();
    super.initState();
  }

  @override


  Widget build(BuildContext context) {
    final styles = TextStyle(fontFamily: 'Muli',fontSize: width * 0.035,);
    final styles2 = TextStyle(fontFamily: 'Muli',fontSize: width * 0.032,color: Colors.black45);

    return Scaffold(
      appBar: AppBar(
        leading: goback(context),
        title: Text(
          "My Savings' Account".toUpperCase(),
          style: TextStyle(
              color: Colors.black45,
              fontFamily: "Muli",
            fontSize: width * 0.04
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
        body: initial_load?
        Center(
          child: CircularProgressIndicator(
            color: Colors.redAccent,
          ),
        )
            : Column(
          children: [
            Flexible(
              child: shares ?
              Center(
                child: Text(
                  'There are no Savings For this Account',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                  ),
                ),
              ): ListView.builder(
                itemBuilder: (context, index){
                  return Card(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Text(
                                  savings[index]['product'],
                                  style: styles,
                                )
                              ],
                            ),
                          ],
                        ),
                        Card(
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Divider(),
                                SizedBox(height: 20,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Date Opened',
                                      style: styles,
                                    ),
                                    Text(f.format(new DateTime.fromMillisecondsSinceEpoch(savings[index]['dateOpened'])),style: styles2,),
                                  ],
                                ),
                                SizedBox(height: 20,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Balance',
                                      style: styles,),
                                    Text(
                                      '${formatCurrency(savings[index]['balance'] == null ? '---' : savings[index]['balance'] )}',
                                      style: styles2,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Period Deposit',
                                      style: styles,
                                    ),
                                    Text( savings[index]['periodDeposit'].toString(),style: styles2,),
                                  ],
                                ),
                                SizedBox(height: 20,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Savings Gurantee Assignable ?',
                                      style: styles,),
                                    Text(savings[index]['guaranteeAssignable'].toString(),style: styles2,),
                                  ],
                                ),
                                SizedBox(height: 20,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Savings Collateral assignable',
                                      style: styles,),
                                    Text(savings[index]['collateralAssignable'].toString(),style: styles2,),
                                  ],
                                ),
                                SizedBox(height: 20,),
                                Divider(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    ElevatedButton(
                                      onPressed: (){
                                        Navigator.push(context, customePageTransion(SavingsDeposit()));
                                      },
                                      child: Text(
                                        'View Deposits',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: width * 0.035,
                                            fontFamily: "Muli"
                                        ),
                                      ),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.lightBlue,
                                          padding:  EdgeInsets.all(15.0),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),
                                        ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () async {
                                          var check_connection = await auth.internetFunctions();
                                          if (check_connection == true) {
                                            var response = await auth.getSavingsLedger('${savings[index]['ledgerId'].toString()}');
                                            print(response);
                                            if (response['count'] == 0) {
                                              setState(() {
                                                initial_load = false;
                                              });
                                            } else {
                                              setState(() {
                                                savingsLedger = response['list'];
                                                print(savingsLedger);
                                                print('data found');
                                                print(savingsLedger);
                                                Navigator.push(context, customePageTransion(SavingsLedger(ledgerId: savings[index]['ledgerId'].toString())));
                                              });
                                            }
                                          } else{
                                            print('not Connected');
                                          }

                                        //Navigator.push(context, customePageTransion(SavingsLedger(ledgerId: savings[index]['ledgerId'].toString())));
                                      },
                                      child: Text(
                                        'Open Ledger',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: width * 0.035,
                                            fontFamily: "Muli"
                                        ),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.lightBlue,
                                        padding:  EdgeInsets.all(15.0),
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
                  );
                },
                shrinkWrap: true,
                itemCount: savings.length,
                scrollDirection: Axis.vertical,
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding:  EdgeInsets.all(15.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onPressed: (){
                Navigator.push(context, customePageTransion(ContributionsMonthly()));
              },
              child: Text(
                'Monthly Contributions',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Muli",
                )),
            )
          ],
        ),
    );
  }
}
