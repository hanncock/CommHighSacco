import 'package:ezenSacco/constants.dart';
import 'package:ezenSacco/services/auth.dart';
import 'package:ezenSacco/utils/formatter.dart';
import 'package:ezenSacco/widgets/backbtn_overide.dart';
import 'package:flutter/material.dart';

import '../wrapper.dart';

class ShareProducts extends StatefulWidget {
  const ShareProducts({Key? key}) : super(key: key);

  @override
  State<ShareProducts> createState() => _ShareProductsState();
}

class _ShareProductsState extends State<ShareProducts> {

  final AuthService auth = AuthService();
  bool loading = false;
  bool shares = true;
  List share_products = [];
  bool initial_load = true;
  //DateTime today = DateTime.fromMillisecondsSinceEpoch();

  shareproducts () async{
    var check_connection = await auth.internetFunctions();
    if(check_connection == true){
      var response = await auth.getShareProducts();
      print(response);
      if(response['count']==null){
        initial_load = false;
        shares = false;
      }else{
        shares = false;
        initial_load = false;
        setState(() {
          share_products = response['list'];
          print(share_products);
        });
      }
    }else{
      initial_load = true;
    }

  }

  @override
  void initState() {
    shareproducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final styles = TextStyle(fontFamily: 'Muli',fontSize: width * 0.04,);
    final styles2 = TextStyle(fontFamily: 'Muli',fontSize: width * 0.035,color: Colors.black45);
    return Scaffold(
      appBar: AppBar(
        leading: goback(context),
        title: Text(
          "Available Share Products".toUpperCase(),
          style: TextStyle(
              color: Colors.black45,
              fontFamily: "Muli",
            fontSize: width * 0.045
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
                'There are no disbursed Loans',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                ),
              ),
            ): ListView.builder(
              itemBuilder: (context, index){
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 0.0,right: 0,top: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Text(
                                  share_products[index]['name'],
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
                                      'Share Type',
                                      style: styles,),
                                    Text(
                                      share_products[index]['type'].toString(),
                                      style: styles2,
                                    ),
                                  ],
                                ),

                                Divider(),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Required Active Period',
                                      style: styles,
                                    ),
                                    Text( share_products[index]['minActivePeriod'].toString(),style: styles2,),
                                  ],
                                ),
                                Divider(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Effective Date',
                                      style: styles,
                                    ),
                                    Text(f.format(new DateTime.fromMillisecondsSinceEpoch(share_products[index]['effectiveDate'])),style: styles2,),
                                  ],
                                ),

                                Divider(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('No. of accounts ',
                                      style: styles,),
                                    Text( share_products[index]['numOfAccounts'].toString(),style: styles2,),
                                  ],
                                ),
                                Divider(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Total Shares',
                                      style: styles,),
                                    Text( share_products[index]['totalShares'].toString(),style: styles2,),
                                  ],
                                ),
                                Divider(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Total Share Value',
                                      style: styles,),
                                    Text( '${formatCurrency(share_products[index]['totalShareValue'])}',style: styles2,),
                                  ],
                                ),
                                Divider(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Is Refundable ?',
                                      style: styles,),
                                    Text(share_products[index]['refundable'].toString(),style: styles2,),
                                  ],
                                ),
                                Divider(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Account Transferable ?',
                                      style: styles,),
                                    Text(share_products[index]['transferrable'].toString(),style: styles2,),
                                  ],
                                ),
                                Divider(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Minimun Shares ?',
                                      style: styles,),
                                    Text(share_products[index]['minimumShares'].toString(),style: styles2,),
                                  ],
                                ),
                                Divider(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Value Per Share',
                                      style: styles,),
                                    Text('${formatCurrency(share_products[index]['valuePerShare'])}',style: styles2,),

                                  ],
                                ),
                                Divider(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Quantity',
                                      style: styles,),
                                    Text(share_products[index]['quantity'].toString(),style: styles2,),

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
              itemCount: share_products.length,
              scrollDirection: Axis.vertical,
            ),
          )
        ],
      ),
    );
  }
}
