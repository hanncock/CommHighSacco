import 'package:ezenSacco/constants.dart';
import 'package:ezenSacco/services/auth.dart';
import 'package:ezenSacco/utils/formatter.dart';
import 'package:ezenSacco/widgets/backbtn_overide.dart';
import 'package:ezenSacco/widgets/spin_loader.dart';
import 'package:flutter/material.dart';

import '../wrapper.dart';

class ShareAccountDeposits extends StatefulWidget {
  const ShareAccountDeposits({Key? key}) : super(key: key);

  @override
  State<ShareAccountDeposits> createState() => _ShareAccountDepositsState();
}

class _ShareAccountDepositsState extends State<ShareAccountDeposits> {

  final AuthService auth = AuthService();
  bool initial_load = true;
  bool nodata = false;
  var sharedeposits;


  getShareDeposits() async{
    var check_connection = await auth.internetFunctions();
    if(check_connection == true){
      var response = await auth.getShareDeposits();
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
          sharedeposits = response['list'];
          print(sharedeposits);
        });
      }
    }else{
      initial_load = true;
    }

  }

  @override
  void initState(){
    getShareDeposits();
    print('soke');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final styles = TextStyle(fontFamily: 'Muli',fontSize: width * 0.035,);
    final styles2 = TextStyle(fontFamily: 'Muli',fontSize: width * 0.035,color: Colors.black45);
    return Scaffold(
        appBar: AppBar(
          leading: goback(context),
          title: Text(
            'Shares Account Deposits',
            style: TextStyle(
                color: Colors.black45,
                fontFamily: "Muli",
              fontSize: width * 0.04
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.refresh,
                color: Colors.redAccent,
              ),
              onPressed: () {
                setState(() {
                  print('Reload init');
                  // provider.getStatements(context, mounted, reload: true);
                  // _data = ApiService().getDividends(true);
                });
              },
            ),
          ],
        ),
        body: initial_load?
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
                      fontSize: 16,
                    ),
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
                                  sharedeposits[index]['product'] == null ? '---' : sharedeposits[index]['product'],
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
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Date Deposited',
                                      style: styles,
                                    ),
                                    Text(f.format(new DateTime.fromMillisecondsSinceEpoch(sharedeposits[index]['depositDate'])),style: styles2,),
                                  ],
                                ),
                                Divider(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Share Acc. No.',
                                      style: styles,
                                    ),
                                    Text(
                                      sharedeposits[index]['shareAccountNo'].toString() == null ? '---' : sharedeposits[index]['shareAccountNo'].toString() ,style: styles2,),
                                  ],
                                ),

                                Divider(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Amount',
                                      style: styles,),
                                    Text( '${formatCurrency(sharedeposits[index]['amount'])}',style: styles2,),
                                  ],
                                ),
                                Divider(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Receipt No.',
                                      style: styles,),
                                    Text( sharedeposits[index]['receiptNo'] == null ? '---' : sharedeposits[index]['receiptNo'],style: styles2,),
                                  ],
                                ),
                                Divider(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Reference No.',
                                      style: styles,),
                                    Text( sharedeposits[index]['paymentRefNo']== null ? '---' : sharedeposits[index]['paymentRefNo'],style: styles2,),
                                  ],
                                ),
                                Divider(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Price Per Share',
                                      style: styles,),
                                    Text( '${formatCurrency(sharedeposits[index]['pricePerShare'])}' ,style: styles2,),
                                  ],
                                ),
                                Divider(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('No. of Shares',
                                      style: styles,),
                                    Text(sharedeposits[index]['noOfShares'].toString() == null ? '---' : sharedeposits[index]['noOfShares'].toString(),style: styles2,),
                                  ],
                                ),
                                Divider(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Effective Shares',
                                      style: styles,),
                                    Text( sharedeposits[index]['effectiveShares'].toString() == null ? '---' : sharedeposits[index]['effectiveShares'].toString() ,style: styles2,),
                                  ],
                                ),
                                Divider(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                shrinkWrap: true,
                itemCount: sharedeposits.length,
                scrollDirection: Axis.vertical,
              ),
            )
          ],
        ),
    );
  }
}
