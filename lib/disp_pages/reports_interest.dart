import 'package:ezenSacco/services/auth.dart';
import 'package:ezenSacco/widgets/backbtn_overide.dart';
import 'package:flutter/material.dart';

//https://online.ezenfinancials.com/live/api/sacco_savings/interests?membershipFromId=8456
class InterstEarned extends StatefulWidget {
  const InterstEarned({Key? key}) : super(key: key);

  @override
  State<InterstEarned> createState() => _InterstEarnedState();
}

class _InterstEarnedState extends State<InterstEarned> {

  final AuthService auth = AuthService();
  bool loading = false;
  bool shares = false;
  List interstEarned = [];
  bool initial_load = true;
  bool nodata = false;
  //DateTime today = DateTime.fromMillisecondsSinceEpoch();

  getinterestEarned () async{
    var check_connection = await auth.internetFunctions();
    if(check_connection == true){
      var response = await auth.getInterestEarned();
      print(response);
      if(response['count']==0){
        setState(() {
          initial_load = false;
          nodata = true;
        });
      }else{
        setState(() {
          shares = false;
          initial_load = false;
          interstEarned = response['list'];
          print(interstEarned);
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
    getinterestEarned();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: goback(context),
          title: Text(
            "My Earned Interest",
            style: TextStyle(
                color: Colors.black45,
                fontFamily: "Muli"
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
              child: nodata ?
              Center(
                child: Text('There Are No Interest Earned to Display ! !',
                  style: TextStyle(fontFamily: "Muli",color: Colors.blue),),
              )
                  :
              Column(
                children: [
                  Text('No Data')
                ],
              ),
            )
          ],
        )

    );
  }
}
