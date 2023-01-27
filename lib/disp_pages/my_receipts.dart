import 'package:ezenSacco/services/auth.dart';
import 'package:ezenSacco/widgets/backbtn_overide.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MonthlyContributions extends StatefulWidget {
  const MonthlyContributions({Key? key}) : super(key: key);

  @override
  State<MonthlyContributions> createState() => _MonthlyContributionsState();
}

class _MonthlyContributionsState extends State<MonthlyContributions> {

  final AuthService auth = AuthService();
  var contributions ;
  bool initial_load = true;
  bool nodata = false;
  dynamic yearTo = DateTime.now().year;
  dynamic yearFrom = DateTime.now().year -1;


  loanproduct () async{
    var check_connection = await auth.internetFunctions();
    if(check_connection == true){
      print('connected');
      var response = await auth.getMonthlyContributions(yearFrom,yearTo);
      print(response);
      if(response == null){
        initial_load = false;
        nodata = true;
      }else{
        setState(() {
          // user_info = response;
          initial_load = false;
          contributions = response;
          print(contributions);
        });
      }
    }else{
      //initial_load = true;
    }
  }

  @override
  void initState() {
    loanproduct();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: goback(context),
          title: Text(
            "Receipts",
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
                child: Text('No Content!'),
              )
                  :
              Center(
                child: Column(
                  children: [
                    Text('No Data To Display')
                  ],
                ),
              ),
            )
          ],
        )

    );
  }
}
