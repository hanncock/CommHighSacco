import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../routes.dart';
import '../services/auth.dart';
import '../widgets/backbtn_overide.dart';
import '../widgets/spin_loader.dart';
import '../wrapper.dart';

class LoansGuaranteed extends StatefulWidget {
  const LoansGuaranteed({Key? key}) : super(key: key);

  @override
  State<LoansGuaranteed> createState() => _LoansGuaranteedState();
}

class _LoansGuaranteedState extends State<LoansGuaranteed> {


  final TextEditingController textEditingController = TextEditingController();
  final AuthService auth = AuthService();
  List requested_Guarantors = [];
  List incoming_request = [];
  bool nodata = false;
  bool nodata2 = false;
  bool initial_load = true;
  final styles = TextStyle(fontFamily: 'Muli',fontWeight: FontWeight.bold,fontSize: width * 0.035);

  requestedGuarantors()async{
    var response = await auth.guarantors_guaranteedissued();
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


  incomingrequest()async{
    var response = await auth.guarantors_guaranteedincoming();
    print(response);
    if (response['count'] == 0) {
      setState(() {
        initial_load = false;
        nodata2 = true;
      });
    } else {
      setState(() {
        nodata2 = false;
        initial_load = false;
        incoming_request = response['list'];
        print(incoming_request);
      });
    }
  }

  acceptreject(memberId,status)async{

    showDialog(
      context: context,
      builder: (BuildContext context) => LoadingSpinCircle()

    );
    Navigator.pop(context);
    var resu = await auth.acceptrejectGuarantorship(memberId, status);
    print(resu);
    showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
          content: resu['success'] == 'true' ?
          Text("Request Succesful",style: TextStyle(color: Colors.green),):
          Text('Error : ${resu}',style: TextStyle(color: Colors.redAccent),)
      ),
    );
    resu['success'] == 'true' ? Navigator.push(context, customePageTransion(LoansGuaranteed())) : null;
    Navigator.of(context).pop();
    // Timer(Duration(seconds: 2), () {
    //   Navigator.pop(context);
    // });
  }

  @override
  void initState() {
    requestedGuarantors();
    incomingrequest();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: goback(context),
        title: Text(
          'Issue Guarantance',
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
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Text(''),
            TabBar(
                labelColor: Colors.blue[800],
                unselectedLabelColor: Colors.black,
                indicatorColor: Colors.blue[800],
                tabs: [
                  Text('Issue Guarantance',style: styles,),
                  Text("Loans I've Guaranteed",style: styles,)
            ]),
            Flexible(
              child: TabBarView(
                  children: [
                nodata2 ? Center(child: Text('No request '),):
          Container(
            width: width,
          height : height * 0.6,
          child: ListView.builder(
          shrinkWrap: true,
          itemCount: incoming_request.length,
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
                      child: Column(
                        children: [
                          Row(
                            children: [
                              // Card(
                              //   elevation: 0,
                              //   color: Colors.blue,
                              //   child: Padding(
                              //     padding: const EdgeInsets.all(5.0),
                              //     child: Icon(Icons.person_outline_rounded,color: Colors.white,),
                              //   ),
                              // ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Text('${incoming_request[index]['memberNo']}',style: styles,),
                                    SizedBox(width: 10,),
                                    Text('${incoming_request[index]['memberName'] ?? ''}',style: styles,),
                                    SizedBox(width: 10,),

                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Loan Num.',style: styles,),
                                  Text(''),
                                  Text('${incoming_request[index]['loanNo'] ?? ''}',style: styles,),
                                ],
                              ),
                            ],
                          ),
                          Divider(),
                          incoming_request[index]['status'] == 'PENDING' ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.redAccent,
                                    padding:  EdgeInsets.all(10.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  onPressed: (){
                                    acceptreject(incoming_request[index]['id'], 'REJECTED');
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 15.0,right: 15),
                                    child: Text('Reject',style: styles,),
                                  )
                              ),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    padding:  EdgeInsets.all(10.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  onPressed: (){
                                    acceptreject(incoming_request[index]['id'], 'APPROVED');
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 15.0,right: 15),
                                    child: Text('Accept',style: styles,),
                                  )
                              ),
                            ],
                          ) :
                          incoming_request[index]['status'] == 'REJECTED' ?
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Card(
                                  color: Colors.redAccent,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('REJECTED',style: TextStyle(color: Colors.white),),
                                  )
                              ),
                            ],
                          )
                              :
                          incoming_request[index]['status'] == 'APPROVED' ? Row(
                            children: [
                              Card(
                                  color: Colors.green,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('APPROVED',style: TextStyle(color: Colors.white),),
                                  )
                              ),
                            ],
                          ) : Text('')
                        ],
                      ),
                    )
                ),
              ),
            );
          }),
    ),
                initial_load ? Center(child: LoadingSpinCircle(),):
                nodata ? Center(child: Text('No Loans Guaranteed yet')): Column(
                  children: [
                    Text(''),
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
                                    )
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
