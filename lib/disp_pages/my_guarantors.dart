import 'package:flutter/material.dart';

import '../services/auth.dart';
import '../widgets/backbtn_overide.dart';
import '../widgets/spin_loader.dart';
import '../wrapper.dart';

class MyGuarantorsList extends StatefulWidget {
  const MyGuarantorsList({Key? key}) : super(key: key);

  @override
  State<MyGuarantorsList> createState() => _MyGuarantorsListState();
}

class _MyGuarantorsListState extends State<MyGuarantorsList> {

  final TextEditingController textEditingController = TextEditingController();
  final AuthService auth = AuthService();
  List requested_Guarantors = [];
  bool nodata = false;
  bool initial_load = true;
  final styles = TextStyle(fontFamily: 'Muli',fontWeight: FontWeight.bold,fontSize: width * 0.035);

  requestedGuarantors()async{
    var response = await auth.guarantors_guaranteedmbdrship();
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
        requested_Guarantors = response['list'];
        print(requested_Guarantors);
      });
    }
  }

  @override
  void initState() {
    requestedGuarantors();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: goback(context),
        title: Text(
          'My Guarantors',
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
      body: initial_load ? Center(child: LoadingSpinCircle(),):
      Column(
        children: [
          Text(''),
          nodata ? Center(child: Text('No guarantors ')):
          Flexible(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: requested_Guarantors.length,
                itemBuilder: (context,index){
                  return Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: InkWell(
                      onTap: (){
                      },
                      child: Card(
                        // color: selectedIndexes.contains(addedguarantorslst[index]['memberNo']) ? Colors.lightBlueAccent.withOpacity(0.3): Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              children: [
                                SizedBox(
                                  width:15,
                                  height: 40,
                                  child: Card(
                                    color: requested_Guarantors[index]['status'] ==  null ? Colors.lightBlueAccent:
                                    requested_Guarantors[index]['status'] == 'PENDING' ? Colors.orange:
                                    requested_Guarantors[index]['status'] == 'APPROVED' ? Colors.green : Colors.grey,
                                    child: Text(''),
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Card(
                                        elevation: 0,
                                        color: Colors.blue,
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Icon(Icons.person_outline_rounded,color: Colors.white,),
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Text('${requested_Guarantors[index]['memberNo']}',style: styles,),
                                            SizedBox(width: 10,),
                                            Text('${requested_Guarantors[index]['memberName'] ?? ''}',style: styles,),
                                            SizedBox(width: 10,),

                                          ],
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Loan Num.',style: styles,),
                                          Text(''),
                                          Text('${requested_Guarantors[index]['loanNo'] ?? ''}',style: styles,),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
