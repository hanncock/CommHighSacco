import 'package:ezenSacco/disp_pages/savings/savingsAcc_ledger.dart';
import 'package:ezenSacco/disp_pages/savings/savings_account.dart';
import 'package:ezenSacco/disp_pages/savings/savings_deposit.dart';
import 'package:ezenSacco/disp_pages/savings/savings_transfer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../models/class profModel.dart';
import '../../routes.dart';
import '../../utils/formatter.dart';
import '../../widgets/backbtn_overide.dart';
import '../../widgets/profModelView.dart';
import '../../wrapper.dart';
import '../montly_contributions.dart';

class SavingsDetails extends StatefulWidget {
  final savingdetails;
  const SavingsDetails({Key? key, required this.savingdetails}) : super(key: key);

  @override
  State<SavingsDetails> createState() => _SavingsDetailsState();
}

class _SavingsDetailsState extends State<SavingsDetails> {



  final styles = TextStyle(fontFamily: 'Muli',fontSize: width * 0.035,);
  final styles2 = TextStyle(fontFamily: 'Muli',fontSize: width * 0.032,color: Colors.black45);
  var title = 'Details';
  late Widget screen;

  late final profMockData = [
    ProfModel(
      active: true,
      label: 'Details',
      route: '',
      widget: savingsDetails(),
    ),
    ProfModel(
      active: false,

      label: 'Deposits',
      route: '',
      widget: SavingsDeposit(),
    ),
    ProfModel(
      active: false,
      label: 'Ledger',
      route: '',
      widget: SavingsLedger(ledgerId: widget.savingdetails['ledgerId'].toString()),
    ),
    ProfModel(
      active: false,

      label: 'Contribute',
      route: '',
      widget: ContributionsMonthly(),
    ),
    ProfModel(
      active: false,

      label: 'Transfers',
      route: '',
      widget: SavingsTransfer(),
    )
  ];

  @override
  void initState(){
    super.initState();
    setState(() {
      screen = savingsDetails();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: goback(context),
        title: Text('${widget.savingdetails['product']}',
          style: TextStyle(
              color: Colors.blue,
              fontFamily: "Muli",
            fontSize: width * 0.04
          ),
        ),
        centerTitle: true,



        backgroundColor: Colors.white,
      ),
      body:Container(
        height: height * 0.8,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                  width: width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.grey[200]
                  ),
                  child:  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                        shrinkWrap: true,
                        itemCount: profMockData.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 10,
                          childAspectRatio : MediaQuery.of(context).size.width /
                              (MediaQuery.of(context).size.height / 8),
                          crossAxisCount: profMockData.length,),
                        itemBuilder: (context, index){
                          return InkWell(
                              onTap: (){
                                setState(() {
                                  profMockData[index].active = !profMockData[index].active;
                                  title = profMockData[index].label;
                                  screen = profMockData[index].widget;
                                });
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: title == profMockData[index].label ? Colors.blueAccent: Colors.grey[200],
                                  ),
                                  child: ProfView(profModel: profMockData[index],)
                              )
                          );
                        }),
                  )
              ),
            ),

            screen

          ],
        ),
      ),
    );
  }

  Column savingsDetails() {
    return Column(
          children: [
            Padding(
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
                      Text(f.format(new DateTime.fromMillisecondsSinceEpoch(widget.savingdetails['dateOpened'])),style: styles2,),
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
                        '${formatCurrency(widget.savingdetails['balance'] == null ? '---' : widget.savingdetails['balance'] )}',
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
                      Text( widget.savingdetails['periodDeposit'].toString(),style: styles2,),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Savings Gurantee Assignable ?',
                        style: styles,),
                      Text(widget.savingdetails['guaranteeAssignable'].toString(),style: styles2,),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Savings Collateral assignable',
                        style: styles,),
                      Text(widget.savingdetails['collateralAssignable'].toString(),style: styles2,),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // ElevatedButton(
                      //   onPressed: (){
                      //     Navigator.push(context, customePageTransion(SavingsDeposit()));
                      //   },
                      //   child: Text(
                      //     'View Deposits',
                      //     style: TextStyle(
                      //         color: Colors.white,
                      //         fontSize: 16,
                      //         fontFamily: "Muli"
                      //     ),
                      //   ),
                      //   style: ElevatedButton.styleFrom(
                      //     backgroundColor: Colors.redAccent,
                      //     padding:  EdgeInsets.all(10.0),
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(10.0),
                      //     ),
                      //   ),
                      // ),

                      // ElevatedButton(
                      //   onPressed: () async {

                      //
                      //     //Navigator.push(context, customePageTransion(SavingsLedger(ledgerId: widget.savingdetails['ledgerId'].toString())));
                      //   },
                      //   child: Text(
                      //     'Open Ledger',
                      //     style: TextStyle(
                      //         color: Colors.white,
                      //         fontSize: 16,
                      //         fontFamily: "Muli"
                      //     ),
                      //   ),
                      //   style: ElevatedButton.styleFrom(
                      //     backgroundColor: Colors.redAccent,
                      //     padding:  EdgeInsets.all(10.0),
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(10.0),
                      //     ),
                      //   ),
                      // )
                    ],
                  )
                ],
              ),
            ),
            
            
            // Text('${widget.savingdetails}')
          ],
        );
  }
}
