import 'package:ezenSacco/services/auth.dart';
import 'package:ezenSacco/widgets/backbtn_overide.dart';
import 'package:ezenSacco/widgets/spin_loader.dart';
import 'package:flutter/material.dart';

class Dividends extends StatefulWidget {
  const Dividends({Key? key}) : super(key: key);

  @override
  State<Dividends> createState() => _DividendsState();
}

class _DividendsState extends State<Dividends> {

  final AuthService auth = AuthService();
  bool initial_load = true;
  bool nodata = false;
  var dividends;


  getDividentss() async{
    var check_connection = await auth.internetFunctions();
    if(check_connection == true){
      var response = await auth.getDividents();
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
          dividends = response['list'];
          print(dividends);
        });
      }
    }else{
      initial_load = true;
    }

  }

  @override
  void initState(){
    getDividentss();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: goback(context),
        title: Text(
          'My Dividends',
          style: TextStyle(
              color: Colors.black45,
              fontFamily: "Muli"
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
        nodata ?
            // Column(
            //   children: [],
            // ):
        Center(
            child: Text(
              'Sorry !\n\nNo Dividents Earned Currently',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                  fontFamily: "Muli"
              ),
            ),) :
            Column(
              children: [
                Text('soke')
              ],
            )
    );
  }
}
