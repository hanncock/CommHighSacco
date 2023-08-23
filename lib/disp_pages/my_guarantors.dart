import 'package:flutter/material.dart';

import '../constants.dart';
import '../services/auth.dart';
import '../utils/formatter.dart';
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
  var showmore;
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
          nodata ? Text('No guarantors '):
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
                            child: InkWell(
                              onTap:(){
                                setState(() {
                                  showmore  == requested_Guarantors[index] ? showmore = null : showmore = requested_Guarantors[index];
                                });
                              },
                              child: Column(
                                children: [
                                  Row(
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
                                                child: Row(
                                                  children: [
                                                    Icon(Icons.person_outline_rounded,color: Colors.white,),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Text('${requested_Guarantors[index]['memberNo']}',style: styles,),
                                                SizedBox(width: 10,),
                                                Text('${requested_Guarantors[index]['memberName'] ?? ''}',style: styles,),
                                                SizedBox(width: 10,),

                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Icon(Icons.arrow_drop_down),
                                    ],
                                  ),

                                  showmore == requested_Guarantors[index] ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      color: Colors.grey[100],
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text('Loan Bal.',style: styles,),
                                                Text(''),
                                                Text('${requested_Guarantors[index]['loanBalance'] ?? ''}',style: styles,),
                                              ],
                                            ),
                                            SizedBox(height: 5,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text('Loan Product.',style: styles,),
                                                Text(''),
                                                Text('${requested_Guarantors[index]['loanProduct'] ?? ''}',style: styles,),
                                              ],
                                            ),
                                            SizedBox(height: 5,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text('Loan Amnt Applied.',style: styles,),
                                                Text(''),
                                                Text('${formatCurrency(requested_Guarantors[index]['amountAppliedFor']) ?? ''}',style: styles,),
                                              ],
                                            ),
                                            SizedBox(height: 5,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text('Loan Num.',style: styles,),
                                                Text(''),
                                                Text('${requested_Guarantors[index]['loanNo'] ?? ''}',style: styles,),
                                              ],
                                            ),
                                            SizedBox(height: 5,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text('Amount Requested',style: styles,),
                                                Text(''),
                                                Text('${requested_Guarantors[index]['guaranteedAmountReq'] ?? ''}',style: styles,),
                                              ],
                                            ),
                                            SizedBox(height: 5,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text('% Guaranteed',style: styles,),
                                                Text(''),
                                                Text('${requested_Guarantors[index]['percentageGuaranteed'] ?? ''}',style: styles,),
                                              ],
                                            ),
                                            SizedBox(height: 5,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text('Amount Guaranteed',style: styles,),
                                                Text(''),
                                                Text('${formatCurrency(requested_Guarantors[index]['guaranteedAmount']) ?? ''}',style: styles,),
                                              ],
                                            ),
                                            SizedBox(height: 5,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text('Loan Appl Date.',style: styles,),
                                                Text(''),
                                                Text('${f.format(new DateTime.fromMillisecondsSinceEpoch(requested_Guarantors[index]['loanAppDate'])) ?? ''}',style: styles,),
                                              ],
                                            ),
                                            SizedBox(height: 5,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text('Loan Status',style: styles,),
                                                Text(''),
                                                Text('${requested_Guarantors[index]['status'] ?? ''}',style: styles,),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ) :Text(''),
                                ],
                              ),
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
