import 'package:ezenSacco/constants.dart';
import 'package:ezenSacco/disp_pages/shares/share_transfers.dart';
import 'package:ezenSacco/services/auth.dart';
import 'package:ezenSacco/widgets/spin_loader.dart';
import 'package:flutter/material.dart';

class OutgoingSavings extends StatefulWidget {
  const OutgoingSavings({Key? key}) : super(key: key);

  @override
  State<OutgoingSavings> createState() => _OutgoingSavingsState();
}

class _OutgoingSavingsState extends State<OutgoingSavings> {
  final AuthService auth = AuthService();
  bool initial_load = true;
  bool nodata = false;
  var savingsTrans;


  savingsIncoming() async{
    var check_connection = await auth.internetFunctions();
    if(check_connection == true){
      var response = await auth.getSavingsTransferOutgoing();
      print(response);
      if(response['count']== 0){
        setState(() {
          initial_load = false;
          nodata = true;
        });

      }else{
        setState(() {
          nodata = false;
          initial_load = false;
          savingsTrans = response['list'];
          print(savingsTrans);
        });
      }
    }else{
      initial_load = true;
    }

  }

  @override
  void initState(){
    savingsIncoming();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final styles = TextStyle(fontFamily: 'Muli', fontSize: 15,);
    final styles2 = TextStyle(
        fontFamily: 'Muli', fontSize: 15, color: Colors.black45);
    return  initial_load?
    LoadingSpinCircle()
        :
    nodata ?
    Center(
      child: Text(
        'Sorry !\n\nNo Savings Transfers Done yet',
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.blue,
            fontSize: width * 0.04,
            fontFamily: "Muli"
        ),
      ),) :
    Column(
      children: [
        ListView.builder(
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
                              'From ${savingsTrans[index]['productTo'] ==
                                  null
                                  ? '---'
                                  : savingsTrans[index]['productTo']}Account',
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
                                  'Date Received',
                                  style: styles,
                                ),
                                Text(f.format(
                                    new DateTime.fromMillisecondsSinceEpoch(
                                        savingsTrans[index]['transferDate'])),
                                  style: styles2,),
                              ],
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment
                                  .spaceBetween,
                              children: [
                                Text(
                                  'Account From',
                                  style: styles,
                                ),
                                Text(
                                  savingsTrans[index]['shareAccountFromNo']
                                      .toString() == null
                                      ? '---'
                                      : savingsTrans[index]['shareAccountFromNo']
                                      .toString(), style: styles2,),
                              ],
                            ),

                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment
                                  .spaceBetween,
                              children: [
                                Text('Share Sender',
                                  style: styles,),
                                Text(savingsTrans[index]['membershipFrom']
                                    .toString(), style: styles2,),
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
                                  savingsTrans[index]['amount'].toString() == null
                                      ? '---'
                                      : savingsTrans[index]['amount'].toString(),
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
                                  savingsTrans[index]['pricePerShare'].toString() ==
                                      null
                                      ? '---'
                                      : savingsTrans[index]['pricePerShare'].toString(),
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
                                Text(savingsTrans[index]['noOfShares']
                                    .toString() == null
                                    ? '---'
                                    : savingsTrans[index]['noOfShares']
                                    .toString(), style: styles2,),
                              ],
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment
                                  .spaceBetween,
                              children: [
                                Text('Effective Shares',
                                  style: styles,),
                                Text(
                                  savingsTrans[index]['effectiveShares']
                                      .toString() == null
                                      ? '---'
                                      : savingsTrans[index]['effectiveShares']
                                      .toString(), style: styles2,),
                              ],
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment
                                  .spaceBetween,
                              children: [
                                Text('Transfer Status',
                                  style: styles,),
                                Text(savingsTrans[index]['status']
                                    .toString() == null
                                    ? '---'
                                    : savingsTrans[index]['status']
                                    .toString(), style: styles2,),
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
          itemCount: savingsTrans.length,
          scrollDirection: Axis.vertical,
        ),
      ],
    );
  }
}
