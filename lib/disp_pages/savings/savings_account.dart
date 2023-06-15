import 'package:ezenSacco/constants.dart';
import 'package:ezenSacco/disp_pages/montly_contributions.dart';
import 'package:ezenSacco/disp_pages/savings/savingsAcc_ledger.dart';
import 'package:ezenSacco/disp_pages/savings/savings_deposit.dart';
import 'package:ezenSacco/disp_pages/savings/savings_details.dart';
import 'package:ezenSacco/routes.dart';
import 'package:ezenSacco/services/auth.dart';
import 'package:ezenSacco/utils/formatter.dart';
import 'package:ezenSacco/widgets/backbtn_overide.dart';
import 'package:flutter/material.dart';

import '../../wrapper.dart';

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

    return  initial_load?
    Center(
      child: CircularProgressIndicator(
        color: Colors.redAccent,
      ),
    )
        : Container(
      height: height * 0.8,
      child: Column(
        children: [
          shares ?
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
              return InkWell(
                onTap: (){
                  Navigator.push(context, customePageTransion(SavingsDetails(savingdetails: savings[index])));
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              savings[index]['product'],
                              style: styles,
                            ),
                            Icon(Icons.navigate_next),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            shrinkWrap: true,
            itemCount: savings.length,
            scrollDirection: Axis.vertical,
          ),
          // ElevatedButton(
          //   style: ElevatedButton.styleFrom(
          //     backgroundColor: Colors.green,
          //     padding:  EdgeInsets.all(15.0),
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(10.0),
          //     ),
          //   ),
          //   onPressed: (){
          //     Navigator.push(context, customePageTransion(ContributionsMonthly()));
          //   },
          //   child: Text(
          //     'Monthly Contributions',
          //     style: TextStyle(
          //       color: Colors.white,
          //       fontFamily: "Muli",
          //     )),
          // )
        ],
        // ),
      ),
    );
  }
}
