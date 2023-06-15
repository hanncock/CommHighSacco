import 'package:ezenSacco/constants.dart';
import 'package:ezenSacco/disp_pages/shares/shares_home.dart';
import 'package:ezenSacco/services/auth.dart';
import 'package:ezenSacco/utils/formatter.dart';
import 'package:ezenSacco/widgets/backbtn_overide.dart';
import 'package:flutter/material.dart';

import '../../routes.dart';
import '../../wrapper.dart';

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
    final styles2 = TextStyle(fontFamily: 'Muli',fontSize: width * 0.033,color: Colors.black45);
    return Scaffold(
      appBar: AppBar(
        leading: goback(context),
        title: Text(
          "Available Share Products".toUpperCase(),
          style: TextStyle(
            color: Colors.blue,
            fontFamily: "Muli",
            fontSize: width * 0.04
            // fontSize: width * 0.045
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
          shares ?
          Center(
            child: Text(
              'There are no Shares for this account',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 16,
              ),
            ),
          ): ListView.builder(
            itemBuilder: (context, index){
              return InkWell(
                onTap: (){
                  Navigator.push(context, customePageTransion(SharesHome(sharesDetails: share_products[index],)));
                },
                child: Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          share_products[index]['name'],
                          style: styles,
                        ),
                      ),
                      Icon(Icons.navigate_next)
                    ],
                  ),
                ),
              );
            },
            shrinkWrap: true,
            itemCount: share_products.length,
            scrollDirection: Axis.vertical,
          )
        ],
      ),
    );
  }
}
