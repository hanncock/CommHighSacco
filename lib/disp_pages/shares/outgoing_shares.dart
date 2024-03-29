import 'package:ezenSacco/constants.dart';
import 'package:ezenSacco/services/auth.dart';
import 'package:ezenSacco/utils/formatter.dart';
import 'package:ezenSacco/widgets/spin_loader.dart';
import 'package:flutter/material.dart';

class OutgoingShares extends StatefulWidget {
  const OutgoingShares({Key? key}) : super(key: key);

  @override
  State<OutgoingShares> createState() => _OutgoingSharesState();
}

class _OutgoingSharesState extends State<OutgoingShares> {

  final AuthService auth = AuthService();
  bool initial_load = true;
  bool nodata = false;
  var incShareTrans;


  shareTransfer() async {
    var check_connection = await auth.internetFunctions();
    if (check_connection == true) {
      var response = await auth.getShareTransferIncoming();
      print(response);
      if (response['count'] == 0) {
        setState(() {
          initial_load = false;
          nodata = true;
        });
      } else {
        setState(() {
          nodata = false;
          initial_load = false;
          incShareTrans = response['list'];
          print(incShareTrans);
        });
      }
    } else {
      initial_load = true;
    }
  }

  @override
  void initState() {
    shareTransfer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final styles = TextStyle(fontFamily: 'Muli', fontSize: 15,);
    final styles2 = TextStyle(
        fontFamily: 'Muli', fontSize: 15, color: Colors.black45);
    return Scaffold(
      body: initial_load ?
      LoadingSpinCircle()
          :
      Column(
        children: [
          Flexible(
            child: nodata ?
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'There are No Share Deposits Saved For this Accounts!!! \n\nPlease Contact Your Sacco For More Info.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 14,
                  ),
                ),
              ),
            ) : ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Text(
                                  'To ${incShareTrans[index]['productTo'] ==
                                      null
                                      ? '---'
                                      : incShareTrans[index]['productTo']}',
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

                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Text(
                                      'Date Transfered',
                                      style: styles,
                                    ),
                                    Text(f.format(
                                        new DateTime.fromMillisecondsSinceEpoch(
                                            incShareTrans[index]['transferDate'])),
                                      style: styles2,),
                                  ],
                                ),
                                Divider(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Text(
                                      'Account To',
                                      style: styles,
                                    ),
                                    Text(
                                      incShareTrans[index]['shareAccountToNo']
                                          .toString() ?? '---', style: styles2,),
                                  ],
                                ),

                                Divider(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Text('Share Receiver',
                                      style: styles,),
                                    Text(
                                      incShareTrans[index]['membershipTo'].toString(),
                                      style: styles2,),
                                  ],
                                ),
                                Divider(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Text('Amount Transfered',
                                      style: styles,),
                                    Text(
                                      '${formatCurrency(incShareTrans[index]['amount'])}',
                                      style: styles2,),
                                  ],
                                ),
                                Divider(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Text('Price per Share',
                                      style: styles,),
                                    Text(
                                      '${formatCurrency(incShareTrans[index]['pricePerShare'])}',
                                      style: styles2,),
                                  ],
                                ),
                                Divider(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Text('No. of Shares?',
                                      style: styles,),
                                    Text(incShareTrans[index]['noOfShares']
                                        .toString() ?? '---', style: styles2,),
                                  ],
                                ),
                                Divider(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Text('Effective Shares',
                                      style: styles,),
                                    Text(incShareTrans[index]['effectiveShares']
                                        .toString() ?? '---', style: styles2,),
                                  ],
                                ),
                                Divider(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Text('Transfer Status',
                                      style: styles,),
                                    Text(incShareTrans[index]['status']
                                        .toString() ?? '---', style: styles2,),
                                  ],
                                ),
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
              itemCount: incShareTrans.length,
              scrollDirection: Axis.vertical,
            ),
          )
        ],
      ),
    );
  }
}