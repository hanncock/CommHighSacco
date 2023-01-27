import 'package:ezenSacco/constants.dart';
import 'package:ezenSacco/services/auth.dart';
import 'package:ezenSacco/utils/formatter.dart';
import 'package:ezenSacco/widgets/backbtn_overide.dart';
import 'package:flutter/material.dart';

import '../wrapper.dart';

class SavingsProducts extends StatefulWidget {
  const SavingsProducts({Key? key}) : super(key: key);

  @override
  State<SavingsProducts> createState() => _SavingsProductsState();
}

class _SavingsProductsState extends State<SavingsProducts> {

  final AuthService auth = AuthService();
  bool loading = false;
  bool shares = false;
  List saving_products = [];
  bool initial_load = true;
  //DateTime today = DateTime.fromMillisecondsSinceEpoch();

  savingProducts () async{
    var check_connection = await auth.internetFunctions();
    if(check_connection == true){
      var response = await auth.savingsProduct();
      if(response['count']==null){
        setState(() {
          initial_load = false;
          shares = true;
        });
      }else{
        setState(() {
          shares = false;
          initial_load = false;
          saving_products = response['list'];
          print(saving_products);
        });
      }
    }else{
      setState(() {
        initial_load = true;
      });
    }

  }

  @override
  void initState() {
    savingProducts();
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
            "Available Savings Products",
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
                  'There are No Producss Saved For this Accounts Please COntact Your Sacco For More Info.',
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
                                  saving_products[index]['name'],
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
                                      'Required Active Period',
                                      style: styles,),
                                    Text(
                                      saving_products[index]['minActivePeriod'].toString(),
                                      style: styles2,
                                    ),
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
                                    Text(f.format(new DateTime.fromMillisecondsSinceEpoch(saving_products[index]['effectiveDate'])),style: styles2,),
                                  ],
                                ),
                                Divider(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Min A/C Balance',
                                      style: styles,
                                    ),
                                    Text( saving_products[index]['accountMinBal'].toString(),style: styles2,),
                                  ],
                                ),

                                Divider(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Product Code',
                                      style: styles,),
                                    Text( saving_products[index]['code'].toString(),style: styles2,),
                                  ],
                                ),
                                Divider(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Required Min. initial Amount',
                                      style: styles,),
                                    Text( saving_products[index]['initialMinAmount'] ?? '---',style: styles2,),
                                  ],
                                ),
                                Divider(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Required Max. initial Amount',
                                      style: styles,),
                                    Text( saving_products[index]['accountMaxBal']  ?? '---',style: styles2,),
                                  ],
                                ),
                                Divider(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Deposit Frequency',
                                      style: styles,),
                                    Text(saving_products[index]['depositFreq'].toString(),style: styles2,),
                                  ],
                                ),
                                Divider(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Deposit Min. Amount',
                                      style: styles,),
                                    Text(saving_products[index]['depositMinAmount'].toString(),style: styles2,),
                                  ],
                                ),
                                Divider(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Deposit Max. Amount',
                                      style: styles,),
                                    Text('${formatCurrency(saving_products[index]['depositMaxAmount'])}',style: styles2,),
                                  ],
                                ),
                                Divider(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Account Transferable ?',
                                      style: styles,),
                                    Text(saving_products[index]['accountTransferable'] ?? '---',style: styles2,),

                                  ],
                                ),
                                Divider(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Account Withdrawable ?',
                                      style: styles,),
                                    Text( saving_products[index]['withdrawable']  ?? '---',style: styles2,),

                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                shrinkWrap: true,
                itemCount: saving_products.length,
                scrollDirection: Axis.vertical,
              ),
            )
          ],
        ),

    );
  }
}
