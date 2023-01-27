import 'package:ezenSacco/constants.dart';
import 'package:ezenSacco/services/auth.dart';
import 'package:ezenSacco/widgets/spin_loader.dart';
import 'package:flutter/material.dart';
class IncomingSavings extends StatefulWidget {
  const IncomingSavings({Key? key}) : super(key: key);

  @override
  State<IncomingSavings> createState() => _IncomingSavingsState();
}

class _IncomingSavingsState extends State<IncomingSavings> {

  final AuthService auth = AuthService();
  bool initial_load = true;
  bool nodata = false;
  var outshareTransf;


  getShareTrans() async {
    var check_connection = await auth.internetFunctions();
    if (check_connection == true) {
      var response = await auth.getSavingsTransferIncoming();
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
          outshareTransf = response['list'];
          print(outshareTransf);
        });
      }
    } else {
      initial_load = true;
    }
  }

  @override
  void initState() {
    getShareTrans();
    print('soke');
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
                  'There are No Savings Transfer For this Accounts!!! \n\nPlease Contact Your Sacco For More Info.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
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
                                  'From ${outshareTransf[index]['productTo'] ==
                                      null
                                      ? '---'
                                      : outshareTransf[index]['productTo']}Account',
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
                                            outshareTransf[index]['transferDate'])),
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
                                      outshareTransf[index]['shareAccountFromNo']
                                          .toString() ?? '---', style: styles2,),
                                  ],
                                ),

                                Divider(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Text('Share Sender',
                                      style: styles,),
                                    Text(outshareTransf[index]['membershipFrom']
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
                                      outshareTransf[index]['amount'].toString() ?? '---',
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
                                      outshareTransf[index]['pricePerShare'].toString()?? '---',
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
                                    Text(outshareTransf[index]['noOfShares']
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
                                    Text(
                                      outshareTransf[index]['effectiveShares']
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
                                    Text(outshareTransf[index]['status']
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
              itemCount: outshareTransf.length,
              scrollDirection: Axis.vertical,
            ),
          )
        ],
      ),
    );
  }
}

// class IncomingSavings extends StatefulWidget {
//   const IncomingSavings({Key? key}) : super(key: key);
//
//   @override
//   State<IncomingSavings> createState() => _IncomingSavingsState();
// }
//
// class _IncomingSavingsState extends State<IncomingSavings> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Text('incoming'),
//         ],
//       ),
//     );
//   }
// }
